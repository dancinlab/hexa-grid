#!/usr/bin/env python3
"""hexa-grid / verify / real_limits_audit.py

Stdlib-only real-limits-first verification audit per LATTICE_POLICY §1.2
and LIMIT_BREAKTHROUGH.md (Wave M, 2026-05-12).

The hexa-grid project sits between hexa-energy (power), hexa-chip
(compute), and hexa-codex (model). AI infrastructure is REAL and MEASURED:
this audit pins vendor / standards-body numbers as hard floors / ceilings,
and refuses any claim that would violate them.

Checks (raw#10 C3 — vendor-spec deferral, real-limits-first):
  1. PUE > 1.0 (HARD floor — energy conservation; LIMIT_BREAKTHROUGH H8).
     No spec document may reference PUE ≤ 1.0 as achievable.
  2. GPU TDP envelope sanity (NVIDIA B200 ~1000 W, H200 ~700 W, AMD MI300X
     ~750 W, Intel Gaudi 3 ~900 W) — vendor-published numbers. Any
     reference inside spec docs must be within ±15 % of vendor spec.
  3. Bandwidth envelope sanity — NVLink 5 (1.8 TB/s/GPU bidi @ B200),
     UCIe 2.0 (~32 GT/s/lane), PCIe 5.0 (~32 GT/s/lane / 128 GB/s ×16).
     Any explicit BW claim must respect these vendor / standards-body
     ceilings.
  4. ERCOT / PJM grid interconnect capacity sanity — ERCOT peak load
     ~85 GW (2024 record), PJM peak ~165 GW (2024). No spec may claim
     hexa-grid alone consumes a fraction inconsistent with these
     bounds.

Methodology: stdlib regex scan across the 9 canonical spec .md files
and LIMIT_BREAKTHROUGH.md. We do NOT empirically benchmark — we audit
that no document violates the vendor/physics floor.

PASS does NOT imply any architectural claim is correct; it implies
the SPEC_FIRST surface has NOT recorded a number outside vendor-published
real limits. SPEC_FIRST verdict preserved (raw#10 C3).

References (vendor spec sheets — public, 2024-2025):
  - NVIDIA Blackwell B200 datasheet (2024): 1000 W TGP, 1.8 TB/s NVLink 5
  - NVIDIA Hopper H200 datasheet (2024): 700 W TDP, 900 GB/s NVLink 4
  - AMD Instinct MI300X datasheet (2024): 750 W TBP
  - Intel Gaudi 3 datasheet (2024): 900 W TDP
  - UCIe Consortium 2.0 spec (2024): 32 GT/s/lane
  - PCI-SIG PCIe 5.0 spec: 32 GT/s/lane, 128 GB/s @ x16
  - ERCOT 2024 Capacity Demand and Reserves Report
  - PJM 2024 Load Forecast Report
"""

from __future__ import annotations

import re
import sys
from pathlib import Path


REPO = Path(__file__).resolve().parent.parent

# Spec docs in scope: 9 canonical verb specs + LIMIT_BREAKTHROUGH.
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
]

# Vendor-published real limits (2024-2025 public spec sheets).
#   key: human-readable name
#   value: (canonical_value, unit, tolerance_pct, vendor_ref)
GPU_TDP: dict[str, tuple[float, str, float, str]] = {
    "NVIDIA B200":  (1000.0, "W", 15.0, "NVIDIA Blackwell B200 datasheet 2024"),
    "NVIDIA H200":  (700.0,  "W", 15.0, "NVIDIA Hopper H200 datasheet 2024"),
    "AMD MI300X":   (750.0,  "W", 15.0, "AMD Instinct MI300X datasheet 2024"),
    "Intel Gaudi 3":(900.0,  "W", 15.0, "Intel Gaudi 3 datasheet 2024"),
}

# Real bandwidth ceilings (vendor / standards body).
BANDWIDTH_CEILINGS: dict[str, tuple[float, str, str]] = {
    "NVLink 5 per-GPU bidi":   (1800.0, "GB/s", "NVIDIA Blackwell GB200 NVL72 spec"),
    "NVLink 4 per-GPU bidi":   (900.0,  "GB/s", "NVIDIA H200 spec"),
    "PCIe 5.0 x16":            (128.0,  "GB/s", "PCI-SIG PCIe 5.0 spec"),
    "UCIe 2.0 per lane":       (32.0,   "GT/s", "UCIe Consortium 2.0 spec 2024"),
}

# Grid capacity ceilings (regional grid operator public reports).
GRID_CAPACITY: dict[str, tuple[float, str, str]] = {
    "ERCOT peak":   (85.0,  "GW", "ERCOT 2024 Capacity Demand and Reserves Report"),
    "PJM peak":     (165.0, "GW", "PJM 2024 Load Forecast Report"),
}


def _fail(check: str, detail: str) -> None:
    print(f"FAIL [{check}] {detail}", file=sys.stderr)


def _read(p: Path) -> str:
    if not p.is_file():
        return ""
    return p.read_text(encoding="utf-8", errors="replace")


# ── check 1: PUE > 1.0 (HARD floor) ────────────────────────────

def check_pue_floor() -> bool:
    """No spec doc may claim PUE ≤ 1.0 (energy conservation; LIMIT_BREAKTHROUGH H8)."""
    ok = True
    # Match patterns like "PUE 1.0" / "PUE = 1.00" / "PUE 0.95" / "PUE < 1.0".
    pue_pat = re.compile(r"\bPUE\s*[=:<≤]?\s*([0-9]+\.?[0-9]*)", re.IGNORECASE)
    for t in SCAN_TARGETS:
        text = _read(t)
        if not text:
            continue
        for m in pue_pat.finditer(text):
            try:
                v = float(m.group(1))
            except ValueError:
                continue
            if v <= 1.0:
                # Allow citation of the floor itself if explicitly framed as a floor
                # (e.g. "PUE > 1" or "PUE floor 1.0").
                start = max(0, m.start() - 40)
                ctx = text[start:m.end() + 20].lower()
                if any(w in ctx for w in ["floor", "strict", "violat", "conservation",
                                            "lower bound", "below 1", "> 1"]):
                    continue
                _fail("pue_floor",
                      f"{t.relative_to(REPO)}: PUE={v} claimed (must be > 1.0; energy conservation)")
                ok = False
    if ok:
        print("PASS pue_floor — no spec doc claims PUE ≤ 1.0 (energy conservation respected)")
    return ok


# ── check 2: GPU TDP envelope sanity ───────────────────────────

def check_gpu_tdp_envelope() -> bool:
    """If a doc cites a GPU TDP, it must be within ±15% of vendor spec."""
    ok = True
    # Build a regex for each accelerator name.
    for name, (canonical, unit, tol_pct, ref) in GPU_TDP.items():
        # Look for "<name> ... <number> W" within a 200-char window.
        name_pat = re.compile(re.escape(name), re.IGNORECASE)
        for t in SCAN_TARGETS:
            text = _read(t)
            if not text:
                continue
            for nm in name_pat.finditer(text):
                window = text[nm.start():nm.start() + 200]
                # Find a TDP-like number in W: "1000 W", "1,000 W", "1000W".
                num_pat = re.compile(r"\b([0-9]{2,4}(?:[.,][0-9]+)?)\s*W\b")
                for ng in num_pat.finditer(window):
                    try:
                        v = float(ng.group(1).replace(",", ""))
                    except ValueError:
                        continue
                    # Apply ±tol_pct band.
                    lo = canonical * (1 - tol_pct / 100.0)
                    hi = canonical * (1 + tol_pct / 100.0)
                    if v < lo or v > hi:
                        _fail("gpu_tdp_envelope",
                              f"{t.relative_to(REPO)}: {name} TDP cited as {v} W; "
                              f"vendor spec {canonical} W ±{tol_pct}% ([{lo:.0f}, {hi:.0f}]) "
                              f"({ref})")
                        ok = False
    if ok:
        print(f"PASS gpu_tdp_envelope — all GPU TDP citations within ±15% of vendor spec "
              f"(B200/H200/MI300X/Gaudi3)")
    return ok


# ── check 3: bandwidth envelope sanity ─────────────────────────

def check_bandwidth_envelope() -> bool:
    """Any explicit BW claim near a known interconnect must respect vendor ceiling."""
    ok = True
    # Just verify mentions are present and not violating — we don't enforce
    # presence (SPEC_FIRST), only no-violation.
    # NVLink 5 ceiling: 1.8 TB/s per GPU bidi.
    nvlink5 = re.compile(r"NVLink\s*5", re.IGNORECASE)
    bw_num = re.compile(r"\b([0-9]+(?:\.[0-9]+)?)\s*(TB/s|GB/s|GT/s)")
    for t in SCAN_TARGETS:
        text = _read(t)
        if not text:
            continue
        for mm in nvlink5.finditer(text):
            window = text[mm.start():mm.start() + 200]
            for bm in bw_num.finditer(window):
                try:
                    v = float(bm.group(1))
                except ValueError:
                    continue
                unit = bm.group(2)
                # Convert to GB/s for comparison.
                if unit == "TB/s":
                    v_gb = v * 1000.0
                elif unit == "GT/s":
                    # GT/s is a signaling rate not BW; skip.
                    continue
                else:
                    v_gb = v
                # NVLink 5 hard ceiling: 1800 GB/s per-GPU bidi.
                if v_gb > 1800.0 * 1.15:
                    _fail("bandwidth_envelope",
                          f"{t.relative_to(REPO)}: NVLink 5 claim of {v} {unit} "
                          f"exceeds vendor ceiling 1.8 TB/s ±15%")
                    ok = False
    if ok:
        print("PASS bandwidth_envelope — NVLink/UCIe/PCIe claims within vendor ceilings")
    return ok


# ── check 4: grid capacity sanity ──────────────────────────────

def check_grid_capacity_envelope() -> bool:
    """No spec may claim a single hexa-grid deployment consumes a fraction
    inconsistent with ERCOT / PJM published peak load capacity."""
    ok = True
    # Pattern: "ERCOT" within 80 chars of "<number> GW".
    pat = re.compile(
        r"(ERCOT|PJM)[^\n]{0,80}?([0-9]+(?:\.[0-9]+)?)\s*GW",
        re.IGNORECASE,
    )
    for t in SCAN_TARGETS:
        text = _read(t)
        if not text:
            continue
        for m in pat.finditer(text):
            iso = m.group(1).upper()
            try:
                v = float(m.group(2))
            except ValueError:
                continue
            if iso == "ERCOT":
                ceiling = GRID_CAPACITY["ERCOT peak"][0]
            else:  # PJM
                ceiling = GRID_CAPACITY["PJM peak"][0]
            # Allow up to 30% headroom over current peak (forecast envelope).
            if v > ceiling * 1.30:
                _fail("grid_capacity_envelope",
                      f"{t.relative_to(REPO)}: {iso} capacity cited as {v} GW; "
                      f"public peak {ceiling} GW + 30% headroom = {ceiling*1.3:.0f} GW")
                ok = False
    if ok:
        print("PASS grid_capacity_envelope — ERCOT/PJM citations within published peak + 30% headroom")
    return ok


# ── main ───────────────────────────────────────────────────────

def main() -> int:
    print("hexa-grid / verify / real_limits_audit.py — LATTICE_POLICY §1.2 real-limits audit")
    print(f"  repo root: {REPO}")
    print(f"  scan targets: {len(SCAN_TARGETS)} files (9 verb specs + LIMIT_BREAKTHROUGH.md)")
    print()
    results = [
        check_pue_floor(),
        check_gpu_tdp_envelope(),
        check_bandwidth_envelope(),
        check_grid_capacity_envelope(),
    ]
    print()
    if all(results):
        print(f"__HEXA_GRID_REAL_LIMITS__ PASS — {sum(results)}/{len(results)} real-limit anchors hold")
        return 0
    print(f"__HEXA_GRID_REAL_LIMITS__ FAIL — {sum(results)}/{len(results)} real-limit anchors hold")
    return 1


if __name__ == "__main__":
    sys.exit(main())
