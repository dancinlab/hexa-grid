#!/usr/bin/env python3
"""hexa-grid / verify / cross_doc_audit.py

Stdlib-only cross-document consistency audit. Mirrors hexa-energy /
hexa-sscb verify/cross_doc_audit.py: catches drift across README,
hexa.toml, and CLI dispatcher.

Checks (raw#10 C3 honesty obligations):
  1. Per-group verb counts match the canonical 3/2/2/2 distribution
     (network/wireless/compute/facility = 3+2+2+2 = 9).
  2. Verdict honesty — `SPEC_FIRST` + `0/9 wired` consistent across:
       README.md, hexa.toml [closure], cli/hexa-grid.hexa.
  3. Out-of-scope phrasing — datacenter / power-grid / interconnect /
       cooling / model-serving referenced as "call sibling CLI directly"
       (NOT "federated" / "passthrough" / "proxy through" / "vendored").
  4. No rogue code outside the four allowed locations (verify/, tests/,
       cli/, build/, plus install.hexa at root). Non-canonical
       legacy verb dirs (browser/, compiler-os/, digital-twin/,
       hexa-proglang/, keyboard/, learning-algorithm/, mouse/,
       programming-language/, software-crypto/, software-design/,
       spatial-computing/, ai-efficiency/) are treated as canon-archive
       imports (immutable, doc-first) and are exempt — analogous to
       hexa-energy's origins/ + papers/ exemption.

PASS does NOT imply any quantitative claim in any spec .md has been
empirically validated. SPEC_FIRST verdict preserved.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO = Path(__file__).resolve().parent.parent

CANONICAL_GROUPS_AND_VERBS: dict[str, list[str]] = {
    "network":  ["network", "netproto", "hexa_netproto"],
    "wireless": ["5g6g", "lora_mesh"],
    "compute":  ["gpgpu", "ai_native"],
    "facility": ["mfg_quality", "construction"],
}

EXPECTED_PER_GROUP = {g: len(vs) for g, vs in CANONICAL_GROUPS_AND_VERBS.items()}
# i.e. {"network": 3, "wireless": 2, "compute": 2, "facility": 2}

# Words that signal a federation/proxy framing — must NOT appear next to
# the cross-link sibling subjects.
FORBIDDEN_FRAMINGS = ["federated", "Federated", "passthrough", "Passthrough",
                       "proxy through", "vendored"]
CROSSLINK_SUBJECTS = ["datacenter", "power grid", "power-grid", "interconnect",
                       "cooling", "hvac", "thermal", "model serving",
                       "model-serving", "inference cost"]

# Code locations allowed: verify/, tests/, cli/, build/, plus install.hexa.
ALLOWED_CODE_DIRS = {"verify", "tests", "cli", "build"}

# Non-canonical legacy verb dirs (canon-import — doc-first, immutable).
# Sister to hexa-energy origins/ + papers/ exemption under own 3.
CANON_ARCHIVE_DIRS = {
    "browser", "compiler-os", "digital-twin", "hexa-proglang",
    "keyboard", "learning-algorithm", "mouse", "programming-language",
    "software-crypto", "software-design", "spatial-computing",
    "ai-efficiency", "papers", "origins",
}

CODE_EXTENSIONS = {".py", ".c", ".h", ".S", ".s"}


def _fail(check: str, detail: str) -> None:
    print(f"FAIL [{check}] {detail}", file=sys.stderr)


# ── check 1: per-group verb counts ─────────────────────────────

def check_per_group_counts() -> bool:
    """hexa.toml [verbs] groups must each have the canonical verb count."""
    text = (REPO / "hexa.toml").read_text(encoding="utf-8")
    in_verbs = False
    found: dict[str, list[str]] = {}
    for line in text.splitlines():
        s = line.strip()
        if s.startswith("[verbs]"):
            in_verbs = True
            continue
        if in_verbs and s.startswith("[") and not s.startswith("[verbs]"):
            break
        if in_verbs:
            m = re.match(r"^([a-z_]+)\s*=\s*\[(.*)\]\s*$", s)
            if m:
                key = m.group(1)
                items = re.findall(r'"([^"]+)"', m.group(2))
                found[key] = items
    ok = True
    for g, expected in EXPECTED_PER_GROUP.items():
        got = found.get(g)
        if got is None:
            _fail("per_group_counts", f"hexa.toml [verbs] missing key '{g}'")
            ok = False
            continue
        if len(got) != expected:
            _fail("per_group_counts",
                  f"group '{g}' has {len(got)} verbs, expected {expected} (got: {got})")
            ok = False
            continue
        canonical = set(CANONICAL_GROUPS_AND_VERBS[g])
        if set(got) != canonical:
            _fail("per_group_counts",
                  f"group '{g}' verb set {got} != canonical {sorted(canonical)}")
            ok = False
    if ok:
        print("PASS per_group_counts — 4/4 groups match canonical 3/2/2/2")
    return ok


# ── check 2: verdict honesty ───────────────────────────────────

def check_verdict_honesty() -> bool:
    """SPEC_FIRST + 0/9 wired consistent across surfaces."""
    ok = True

    # hexa.toml
    toml = (REPO / "hexa.toml").read_text(encoding="utf-8")
    m = re.search(r'^\s*verdict\s*=\s*"([^"]+)"', toml, re.MULTILINE)
    if not m:
        _fail("verdict_honesty", "hexa.toml [closure].verdict not found")
        ok = False
    elif m.group(1) != "SPEC_FIRST":
        _fail("verdict_honesty", f"hexa.toml [closure].verdict = {m.group(1)!r}, expected 'SPEC_FIRST'")
        ok = False
    m = re.search(r'^\s*verbs_wired\s*=\s*(\d+)', toml, re.MULTILINE)
    if not m:
        _fail("verdict_honesty", "hexa.toml [closure].verbs_wired not found")
        ok = False
    elif int(m.group(1)) != 0:
        _fail("verdict_honesty", f"hexa.toml [closure].verbs_wired = {m.group(1)}, expected 0 at v1.0.0")
        ok = False

    # README.md
    readme = (REPO / "README.md").read_text(encoding="utf-8")
    if "SPEC_FIRST" not in readme.upper() and "spec-first" not in readme.lower():
        _fail("verdict_honesty", "README.md does not mention SPEC_FIRST / spec-first")
        ok = False
    if not re.search(r"9\s*/\s*9|0\s*/\s*9", readme):
        _fail("verdict_honesty", "README.md does not mention '9/9' or '0/9' wired count")
        ok = False

    # cli
    cli = (REPO / "cli" / "hexa-grid.hexa").read_text(encoding="utf-8")
    if "SPEC_FIRST" not in cli:
        _fail("verdict_honesty", "cli/hexa-grid.hexa does not mention SPEC_FIRST")
        ok = False

    if ok:
        print("PASS verdict_honesty — SPEC_FIRST + 9/9 spec consistent across README/hexa.toml/cli")
    return ok


# ── check 3: out-of-scope phrasing ─────────────────────────────

def check_out_of_scope_phrasing() -> bool:
    """Cross-link subjects must not be framed as federated/passthrough/proxy.

    Policy: when a forbidden framing word (federated, passthrough,
    proxy through, vendored) appears within 80 chars of a cross-link
    subject (datacenter, power-grid, interconnect, cooling, model-serving),
    flag it — UNLESS the forbidden word is itself negated (e.g. "no proxy",
    "NOT vendored") or quoted as a policy citation.
    """
    ok = True
    targets = [REPO / "README.md", REPO / "hexa.toml",
               REPO / "cli" / "hexa-grid.hexa"]
    subj_alt = "|".join(re.escape(s) for s in CROSSLINK_SUBJECTS)
    forb_alt = "|".join(re.escape(w) for w in FORBIDDEN_FRAMINGS)
    pattern = re.compile(
        r"(" + subj_alt + r")[^\n]{0,80}?(" + forb_alt + r")",
        re.IGNORECASE,
    )
    negation_re = re.compile(r"\b(not|NOT|never|no)\b", re.IGNORECASE)
    for t in targets:
        if not t.is_file():
            continue
        text = t.read_text(encoding="utf-8")
        for m in pattern.finditer(text):
            forbidden_pos = m.start(2)
            ctx_start = max(0, forbidden_pos - 20)
            ctx = text[ctx_start:forbidden_pos]
            if negation_re.search(ctx):
                continue
            if forbidden_pos > 0 and text[forbidden_pos - 1] in "`'\"":
                continue
            _fail("out_of_scope_phrasing",
                  f"{t.relative_to(REPO)}: '…{m.group(0)}…' (forbidden framing near cross-link subject)")
            ok = False
    if ok:
        print("PASS out_of_scope_phrasing — cross-link subjects framed as 'call sibling CLI directly'")
    return ok


# ── check 4: no rogue code ─────────────────────────────────────

def check_no_rogue_code() -> bool:
    """Code files must live in verify/, tests/, cli/, build/, or be install.hexa.

    Legacy non-canonical verb dirs (CANON_ARCHIVE_DIRS) are exempt as
    canon-import provenance (analogous to hexa-energy origins/ + papers/).
    """
    ok = True
    rogues: list[str] = []
    for p in REPO.rglob("*"):
        if not p.is_file():
            continue
        rel = p.relative_to(REPO)
        parts = rel.parts
        if parts and parts[0] in {".git", ".pytest_cache", "__pycache__"}:
            continue
        suffix = p.suffix.lower()
        is_code = suffix in CODE_EXTENSIONS or suffix == ".hexa" or p.name == "Makefile"
        if not is_code:
            continue
        if parts[0] in ALLOWED_CODE_DIRS:
            continue
        if parts[0] in CANON_ARCHIVE_DIRS:
            continue
        # install.hexa at root is the hx install hook — allowed.
        if parts == ("install.hexa",):
            continue
        rogues.append(str(rel))
    if rogues:
        for r in rogues:
            _fail("no_rogue_code", f"{r} (not in {sorted(ALLOWED_CODE_DIRS)} or canon-archive)")
        ok = False
    if ok:
        print(f"PASS no_rogue_code — code restricted to {sorted(ALLOWED_CODE_DIRS)} + install.hexa (canon-archive dirs exempt)")
    return ok


# ── main ───────────────────────────────────────────────────────

def main() -> int:
    print("hexa-grid / verify / cross_doc_audit.py — cross-document consistency audit")
    print(f"  repo root: {REPO}")
    print()
    results = [
        check_per_group_counts(),
        check_verdict_honesty(),
        check_out_of_scope_phrasing(),
        check_no_rogue_code(),
    ]
    print()
    if all(results):
        print(f"__HEXA_GRID_CROSS_DOC__ PASS — {sum(results)}/{len(results)} checks")
        return 0
    print(f"__HEXA_GRID_CROSS_DOC__ FAIL — {sum(results)}/{len(results)} checks")
    return 1


if __name__ == "__main__":
    sys.exit(main())
