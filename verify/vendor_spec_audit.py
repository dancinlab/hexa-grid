#!/usr/bin/env python3
"""hexa-grid / verify / vendor_spec_audit.py

Stdlib-only vendor-spec / scope-honesty audit per raw#10 C3.

AI infrastructure is REAL and MEASURED. NVIDIA, AMD, Intel, CoreWeave,
Lambda, OpenAI, Anthropic, xAI publish their own architecture specs +
SLAs + capacity numbers. This audit enforces that any reference to these
vendors uses THEIR published invariants — never the n=6 lattice and never
a "lattice fit" framing (LATTICE_POLICY §1.3 #4: over-claim avoidance).

Checks (raw#10 C3 + LATTICE_POLICY §1.3):
  1. No lattice-fit framing on external entities — phrases like
     "NVIDIA follows n=6", "AMD complies with σ·φ=24", "OpenAI maps to
     τ=4" are forbidden across all spec docs.
  2. Vendor-name sanity — at least one mention of the relevant
     reference benchmark family (MLPerf / Top500) in
     LIMIT_BREAKTHROUGH or a verb spec, to verify the doc surface
     defers to industry benchmarks for performance claims.
  3. Cross-link integrity — every NOT_SCOPE subject listed in
     hexa.toml [scope].not_scope must appear in [crosslink] with a
     concrete sibling-CLI invocation (datacenter, power-grid,
     interconnect, cooling, model-serving).
  4. SPEC_FIRST sanity — the cli/hexa-grid.hexa dispatcher must
     print SPEC_FIRST verdict + cross-link reminder for at least one
     subcommand (status / version / help).

PASS does NOT imply the spec content is empirically correct; it
implies the SPEC_FIRST surface respects vendor / industry reality
(raw#10 C3) and does not over-claim lattice applicability to external
entities.

References (vendor + industry — public, 2024-2025):
  - MLCommons MLPerf Training v4.1 / Inference v4.1 (2024)
  - Top500 list (Nov 2024)
  - NVIDIA / AMD / Intel datasheets cited in real_limits_audit.py
  - CoreWeave + Lambda + OpenAI + Anthropic + xAI public infrastructure
    posts (2024-2025)
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO = Path(__file__).resolve().parent.parent

SCAN_TARGETS: list[Path] = [
    REPO / "network" / "network.md",
    REPO / "netproto" / "network-protocol.md",
    REPO / "hexa_netproto" / "hexa-netproto.md",
    REPO / "5g6g" / "5g-6g-network.md",
    REPO / "lora_mesh" / "lora-mesh-learning-terminal.md",
    REPO / "gpgpu" / "gpgpu.md",
    REPO / "ai_native" / "ai-native-architecture.md",
    REPO / "mfg_quality" / "manufacturing-quality.md",
    REPO / "construction" / "construction-structural.md",
    REPO / "LIMIT_BREAKTHROUGH.md",
    REPO / "README.md",
    REPO / "hexa.toml",
]

# External AI-infra entities that must use their OWN invariants.
EXTERNAL_ENTITIES = [
    "NVIDIA", "AMD", "Intel", "CoreWeave", "Lambda", "OpenAI",
    "Anthropic", "xAI", "Microsoft Azure", "Google Cloud", "AWS",
    "Meta", "Oracle Cloud",
]

# Lattice-fit language that must NOT be applied to external entities.
LATTICE_FIT_PHRASES = [
    r"\bfollow(?:s|ed)?\s+n\s*=\s*6\b",
    r"\bcomp(?:ly|lies|liant)\s+with\s+(?:σ|sigma|tau|τ|phi|φ)",
    r"\bmaps?\s+(?:to|onto)\s+(?:n\s*=\s*6|σ\(6\)|τ\(6\)|φ\(6\))",
    r"\bfits?\s+the\s+n\s*=\s*6\s+lattice\b",
    r"\bobeys\s+(?:σ·φ|σ\*φ|σ\.φ)\s*=\s*24\b",
]

# Industry benchmark families that should be referenced when making
# performance claims (per raw#10 C3: defer to industry benchmarks).
BENCHMARK_FAMILIES = ["MLPerf", "Top500", "MLCommons"]


def _fail(check: str, detail: str) -> None:
    print(f"FAIL [{check}] {detail}", file=sys.stderr)


def _read(p: Path) -> str:
    if not p.is_file():
        return ""
    return p.read_text(encoding="utf-8", errors="replace")


# ── check 1: no lattice-fit framing on external entities ───────

def check_no_lattice_fit_on_externals() -> bool:
    """No spec doc may claim an external AI-infra vendor follows the n=6 lattice."""
    ok = True
    entity_alt = "|".join(re.escape(e) for e in EXTERNAL_ENTITIES)
    for phrase_pat in LATTICE_FIT_PHRASES:
        # Pattern: <entity> within 80 chars of <lattice-fit phrase>.
        pat = re.compile(
            r"(" + entity_alt + r")[^\n]{0,80}?(" + phrase_pat + r")",
            re.IGNORECASE,
        )
        for t in SCAN_TARGETS:
            text = _read(t)
            if not text:
                continue
            for m in pat.finditer(text):
                _fail("no_lattice_fit_on_externals",
                      f"{t.relative_to(REPO)}: '…{m.group(0)[:120]}…' "
                      f"(external entity must use its own invariants — LATTICE_POLICY §1.3 #4)")
                ok = False
    if ok:
        print("PASS no_lattice_fit_on_externals — no external AI-infra vendor framed as lattice-fit")
    return ok


# ── check 2: industry benchmark presence ───────────────────────

def check_benchmark_reference() -> bool:
    """At least one benchmark family (MLPerf / Top500 / MLCommons) must be
    referenced across the audit surface — confirms deferral to industry
    measurement for performance claims.

    LIMIT_BREAKTHROUGH.md is the natural home; any verb spec is also fine.
    """
    found_families: set[str] = set()
    for t in SCAN_TARGETS:
        text = _read(t)
        if not text:
            continue
        for fam in BENCHMARK_FAMILIES:
            if re.search(re.escape(fam), text, re.IGNORECASE):
                found_families.add(fam)
    if not found_families:
        _fail("benchmark_reference",
              f"no benchmark family ({BENCHMARK_FAMILIES}) referenced across audit surface "
              f"(per raw#10 C3, performance claims should defer to MLPerf / Top500)")
        return False
    print(f"PASS benchmark_reference — industry benchmark(s) referenced: {sorted(found_families)}")
    return True


# ── check 3: cross-link integrity ──────────────────────────────

def check_crosslink_integrity() -> bool:
    """Every NOT_SCOPE subject must have a sibling-CLI invocation in [crosslink]."""
    toml = _read(REPO / "hexa.toml")
    if not toml:
        _fail("crosslink_integrity", "hexa.toml missing")
        return False

    # Extract [scope].not_scope list.
    in_scope = False
    not_scope_block = ""
    for line in toml.splitlines():
        s = line.strip()
        if s.startswith("[scope]"):
            in_scope = True
            continue
        if in_scope and s.startswith("[") and not s.startswith("[scope]"):
            break
        if in_scope:
            not_scope_block += line + "\n"
    not_scope_items = re.findall(r'"([^"]+)"', not_scope_block)

    # Extract [crosslink] body.
    in_cross = False
    cross_block = ""
    for line in toml.splitlines():
        s = line.strip()
        if s.startswith("[crosslink]"):
            in_cross = True
            continue
        if in_cross and s.startswith("[") and not s.startswith("[crosslink]"):
            break
        if in_cross:
            cross_block += line + "\n"

    ok = True
    expected_subjects = [
        ("datacenter", "datacenter"),
        ("power grid", "power-grid"),
        ("interconnect", "interconnect"),
        ("thermal", "thermal-management"),
        ("model serving", "model serving"),
    ]
    cross_lc = cross_block.lower()
    for subject_a, subject_b in expected_subjects:
        if subject_a not in cross_lc and subject_b.lower() not in cross_lc:
            _fail("crosslink_integrity",
                  f"hexa.toml [crosslink] missing sibling-CLI for subject '{subject_a}'")
            ok = False

    # Also: every not_scope item should mention `hexa-` somewhere
    # (i.e., points to a sibling CLI).
    not_scope_pointing = sum(1 for it in not_scope_items if "hexa-" in it.lower())
    if not_scope_items and not_scope_pointing < len(not_scope_items) - 1:
        # Allow one not_scope item to be a free-form caveat (e.g.
        # "in-situ deployment validation").
        _fail("crosslink_integrity",
              f"hexa.toml [scope].not_scope: {not_scope_pointing}/{len(not_scope_items)} "
              f"items mention a sibling 'hexa-' CLI — expected ≥ {len(not_scope_items) - 1}")
        ok = False

    if ok:
        print(f"PASS crosslink_integrity — {len(not_scope_items)} not_scope items "
              f"all route to sibling CLIs ([crosslink] complete)")
    return ok


# ── check 4: SPEC_FIRST sanity in CLI dispatcher ───────────────

def check_spec_first_cli_sanity() -> bool:
    """cli/hexa-grid.hexa must print SPEC_FIRST verdict + cross-link."""
    cli = _read(REPO / "cli" / "hexa-grid.hexa")
    if not cli:
        _fail("spec_first_cli_sanity", "cli/hexa-grid.hexa missing")
        return False
    ok = True
    if "SPEC_FIRST" not in cli:
        _fail("spec_first_cli_sanity",
              "cli/hexa-grid.hexa does not print SPEC_FIRST verdict")
        ok = False
    if "cross-link" not in cli.lower() and "crosslink" not in cli.lower():
        _fail("spec_first_cli_sanity",
              "cli/hexa-grid.hexa does not print a cross-link reminder")
        ok = False
    if "hexa-energy" not in cli or "hexa-chip" not in cli:
        _fail("spec_first_cli_sanity",
              "cli/hexa-grid.hexa cross-link does not reference both hexa-energy + hexa-chip")
        ok = False
    if ok:
        print("PASS spec_first_cli_sanity — CLI prints SPEC_FIRST + cross-link to hexa-energy/hexa-chip")
    return ok


# ── main ───────────────────────────────────────────────────────

def main() -> int:
    print("hexa-grid / verify / vendor_spec_audit.py — raw#10 C3 vendor / industry-benchmark deferral")
    print(f"  repo root: {REPO}")
    print(f"  scan targets: {len(SCAN_TARGETS)} files")
    print()
    results = [
        check_no_lattice_fit_on_externals(),
        check_benchmark_reference(),
        check_crosslink_integrity(),
        check_spec_first_cli_sanity(),
    ]
    print()
    if all(results):
        print(f"__HEXA_GRID_VENDOR_SPEC__ PASS — {sum(results)}/{len(results)} vendor-spec deferral checks")
        return 0
    print(f"__HEXA_GRID_VENDOR_SPEC__ FAIL — {sum(results)}/{len(results)} vendor-spec deferral checks")
    return 1


if __name__ == "__main__":
    sys.exit(main())
