#!/usr/bin/env python3
"""hexa-grid / verify / grid_verify.py

Stdlib-only invariant audit for the n=9 verb / 4-group lattice.

Mirrors the hexa-energy/verify/energy_verify.py pattern (sister-pattern
parity with hexa-rtsc / hexa-fusion / hexa-cern / hexa-chip): runnable,
no third-party deps, exit 0 on PASS, non-zero with stderr diagnostics on
FAIL.

Checks (raw#10 C3 honesty obligations):
  1. Verb sentinel sweep — 9 canonical verb directories present.
  2. Group sentinel sweep — 4 group keys present in hexa.toml [verbs].
  3. n=9 lattice equality — verb_count == 9 across the three authoritative
     surfaces (hexa.toml [closure].verbs_total, hexa.toml [verbs] flat
     count, cli/hexa-grid.hexa VERBS registry length).

PASS does NOT imply any quantitative claim in any verb spec .md has been
empirically validated. Verdict honesty: SPEC_FIRST (9/9 verbs spec-only).

Per LATTICE_POLICY.md §1.3: this script counts the verb lattice; the
real-limit anchors (PUE, B200 TDP, NVLink BW, ERCOT capacity) live in
verify/real_limits_audit.py and are the binding verification surface.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO = Path(__file__).resolve().parent.parent

CANONICAL_VERBS: list[str] = [
    # network group
    "network", "netproto", "hexa_netproto",
    # wireless group
    "5g6g", "lora_mesh",
    # compute group
    "gpgpu", "ai_native",
    # facility group
    "mfg_quality", "construction",
]

CANONICAL_GROUPS: list[str] = [
    "network", "wireless", "compute", "facility",
]

# (verb_dir, expected_spec_md_filename) — must match cli/hexa-grid.hexa VERBS table.
CANONICAL_SPEC_FILES: dict[str, str] = {
    "network":       "network.md",
    "netproto":      "network-protocol.md",
    "hexa_netproto": "hexa-netproto.md",
    "5g6g":          "5g-6g-network.md",
    "lora_mesh":     "lora-mesh-learning-terminal.md",
    "gpgpu":         "gpgpu.md",
    "ai_native":     "ai-native-architecture.md",
    "mfg_quality":   "manufacturing-quality.md",
    "construction":  "construction-structural.md",
}

EXPECTED_VERB_COUNT = 9
EXPECTED_GROUP_COUNT = 4


def _fail(check: str, detail: str) -> None:
    print(f"FAIL [{check}] {detail}", file=sys.stderr)


def check_verb_sentinel() -> bool:
    """1. Each canonical verb has a <verb>/ directory containing its spec .md."""
    missing_dirs: list[str] = []
    missing_specs: list[str] = []
    for v in CANONICAL_VERBS:
        d = REPO / v
        if not d.is_dir():
            missing_dirs.append(v)
            continue
        spec = d / CANONICAL_SPEC_FILES[v]
        if not spec.is_file():
            missing_specs.append(f"{v}/{CANONICAL_SPEC_FILES[v]}")
    if missing_dirs:
        _fail("verb_sentinel", f"missing verb dirs: {missing_dirs}")
        return False
    if missing_specs:
        _fail("verb_sentinel", f"missing spec docs: {missing_specs}")
        return False
    if len(CANONICAL_VERBS) != EXPECTED_VERB_COUNT:
        _fail("verb_sentinel", f"len(CANONICAL_VERBS)={len(CANONICAL_VERBS)} != {EXPECTED_VERB_COUNT}")
        return False
    print(f"PASS verb_sentinel — {EXPECTED_VERB_COUNT}/{EXPECTED_VERB_COUNT} verb dirs + spec docs present")
    return True


def check_group_sentinel() -> bool:
    """2. hexa.toml [verbs] section contains the 4 canonical group keys."""
    toml = (REPO / "hexa.toml").read_text(encoding="utf-8")
    in_verbs_section = False
    found: list[str] = []
    for line in toml.splitlines():
        s = line.strip()
        if s.startswith("[verbs]"):
            in_verbs_section = True
            continue
        if in_verbs_section and s.startswith("[") and not s.startswith("[verbs]"):
            break
        if in_verbs_section:
            m = re.match(r"^([a-z_]+)\s*=", s)
            if m:
                found.append(m.group(1))
    missing = [g for g in CANONICAL_GROUPS if g not in found]
    if missing:
        _fail("group_sentinel", f"missing in hexa.toml [verbs]: {missing} (found: {found})")
        return False
    if len(found) != EXPECTED_GROUP_COUNT:
        _fail("group_sentinel", f"hexa.toml [verbs] has {len(found)} keys, expected {EXPECTED_GROUP_COUNT}")
        return False
    print(f"PASS group_sentinel — {EXPECTED_GROUP_COUNT}/{EXPECTED_GROUP_COUNT} group keys in hexa.toml")
    return True


def _count_verbs_in_hexa_toml_closure() -> int | None:
    text = (REPO / "hexa.toml").read_text(encoding="utf-8")
    m = re.search(r"^\s*verbs_total\s*=\s*(\d+)", text, re.MULTILINE)
    if not m:
        _fail("verb_count_toml", "hexa.toml [closure].verbs_total not found")
        return None
    return int(m.group(1))


def _count_verbs_in_hexa_toml_verbs_section() -> int | None:
    text = (REPO / "hexa.toml").read_text(encoding="utf-8")
    in_verbs = False
    total = 0
    for line in text.splitlines():
        s = line.strip()
        if s.startswith("[verbs]"):
            in_verbs = True
            continue
        if in_verbs and s.startswith("[") and not s.startswith("[verbs]"):
            break
        if in_verbs:
            m = re.match(r"^[a-z_]+\s*=\s*\[(.*)\]\s*$", s)
            if m:
                items = re.findall(r'"([^"]+)"', m.group(1))
                total += len(items)
    if total == 0:
        _fail("verb_count_toml_flat", "hexa.toml [verbs] has 0 verbs across groups")
        return None
    return total


def _count_verbs_in_cli() -> int | None:
    p = REPO / "cli" / "hexa-grid.hexa"
    if not p.is_file():
        _fail("verb_count_cli", f"missing {p.relative_to(REPO)}")
        return None
    text = p.read_text(encoding="utf-8")
    # The VERBS registry is a [str] of 3-tuple-shaped string rows: ["verb", "dir", "file.md"]
    m = re.search(r"let\s+VERBS\s*=\s*\[(.*?)\]\s*\n\s*\n", text, re.DOTALL)
    if not m:
        # fallback: count [...] row entries between "let VERBS = [" and the closing line.
        m = re.search(r"let\s+VERBS\s*=\s*\[(.*?)^\]", text, re.DOTALL | re.MULTILINE)
    if not m:
        _fail("verb_count_cli", "VERBS registry not found in cli/hexa-grid.hexa")
        return None
    body = m.group(1)
    rows = re.findall(r"\[\s*\"[^\"]+\"\s*,\s*\"[^\"]+\"\s*,\s*\"[^\"]+\"\s*\]", body)
    return len(rows)


def check_lattice_equality() -> bool:
    """3. verb_count == 9 across the three surfaces."""
    toml_closure_n = _count_verbs_in_hexa_toml_closure()
    toml_flat_n = _count_verbs_in_hexa_toml_verbs_section()
    cli_n = _count_verbs_in_cli()

    surfaces = {
        "hexa.toml [closure].verbs_total": toml_closure_n,
        "hexa.toml [verbs] flat count": toml_flat_n,
        "cli/hexa-grid.hexa VERBS registry length": cli_n,
    }
    ok = True
    for name, n in surfaces.items():
        if n is None:
            ok = False
            continue
        marker = "PASS" if n == EXPECTED_VERB_COUNT else "FAIL"
        if n != EXPECTED_VERB_COUNT:
            ok = False
        print(f"{marker} lattice_equality / {name} = {n} (expected {EXPECTED_VERB_COUNT})")
    return ok


def main() -> int:
    print("hexa-grid / verify / grid_verify.py — n=9 verb / 4-group lattice audit")
    print(f"  repo root: {REPO}")
    print()
    results = [
        check_verb_sentinel(),
        check_group_sentinel(),
        check_lattice_equality(),
    ]
    print()
    if all(results):
        print(f"__HEXA_GRID_VERIFY__ PASS — {sum(results)}/{len(results)} checks")
        return 0
    print(f"__HEXA_GRID_VERIFY__ FAIL — {sum(results)}/{len(results)} checks")
    return 1


if __name__ == "__main__":
    sys.exit(main())
