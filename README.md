# 🌐 hexa-grid — AI 산업 인프라 fabric

> 9-verb AI-infrastructure substrate sitting between **hexa-energy (power)**,
> **hexa-chip (compute)**, and **hexa-codex (model)** — the connective fabric
> binding the AI industrial stack.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20102809.svg)](https://doi.org/10.5281/zenodo.20102809)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-informational.svg)](hexa.toml)
[![Verbs: 9 / 4 groups](https://img.shields.io/badge/verbs-9_%2F_4_groups-blue.svg)](#status)
[![Wired: 0/9](https://img.shields.io/badge/wired-0%2F9_(SPEC__FIRST)-orange.svg)](#status)
[![Closure: 15/15](https://img.shields.io/badge/closure-15%2F15_PASS_(lattice%2Bcross--doc%2Breal--limits%2Bvendor--spec)-brightgreen.svg)](#verify)
[![Real-Limits](https://img.shields.io/badge/real--limits-LATTICE__POLICY_%C2%A71.2-purple.svg)](LATTICE_POLICY.md)
[![Provenance](https://img.shields.io/badge/from-canon%4047c70cbf-purple.svg)](#provenance)

---

## Why

The AI industrial stack already has three HEXA standalones:

```
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│ hexa-energy  │   │  hexa-chip   │   │  hexa-codex  │
│   (power)    │   │  (compute)   │   │   (model)    │
└──────┬───────┘   └──────┬───────┘   └──────┬───────┘
       │                  │                  │
       └─────────┬────────┴────────┬─────────┘
                 │                 │
                 ▼                 ▼
              ┌─────────────────────────┐
              │      hexa-grid          │
              │   (AI infra fabric)     │
              └─────────────────────────┘
```

**hexa-grid** owns what is genuinely fabric-level — networking, wireless
backbone, GPGPU programming model, AI-native architecture, mesh learning
terminals, manufacturing-quality, datacenter construction.

For things that already live elsewhere, we **call the sibling CLI directly**
rather than re-vendoring:

| concern                | call                                      |
| ---------------------- | ----------------------------------------- |
| datacenter facility    | `hexa-energy smr_dc` / `dc_reactor`       |
| power grid             | `hexa-energy grid`                        |
| HVAC / thermal mgmt    | `hexa-energy hvac` / `thermal`            |
| chip interconnect      | `hexa-chip interconnect`                  |
| model serving / infer  | `hexa-codex deploy` / `agent_serving`     |

---

## Install

```bash
# 1. Install hexa-lang (gives you `hexa` + `hx` package manager)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dancinlab/hexa-lang/main/install.sh)"

# 2. Install hexa-grid
hx install hexa-grid
```

## Run

```bash
hexa-grid network            # network spec doc
hexa-grid netproto           # network-protocol spec doc
hexa-grid hexa_netproto      # hexa-netproto spec doc
hexa-grid 5g6g               # 5g-6g-network spec doc
hexa-grid lora_mesh          # lora-mesh-learning-terminal spec doc
hexa-grid gpgpu              # gpgpu spec doc
hexa-grid ai_native          # ai-native-architecture spec doc
hexa-grid mfg_quality        # manufacturing-quality spec doc
hexa-grid construction       # construction-structural spec doc
hexa-grid status             # 9-verb table + cross-link + caveats
hexa-grid selftest           # 9-verb spec doc presence check
hexa-grid version            # print version
hexa-grid help               # full --help (subcommands + env vars + cross-link)
```

## Status

Spec-first at v1.0.0 — 9/9 verbs ship as peer-citable markdown docs;
**0/9 verbs wired** (SPEC_FIRST verdict preserved). Datacenter /
power-grid / interconnect / cooling / model-serving are **explicitly
NOT_SCOPE** — sibling CLI is the SSOT for those.

Closure (native, this repo): **15/15 PASS** across 4 verify scripts —
see [§Verify](#verify) below.

## Verify

Sister-pattern verify surface (parity with hexa-energy / hexa-chip /
hexa-rtsc / hexa-fusion / hexa-cern). Stdlib-only Python + a thin
`.hexa` orchestrator — no third-party deps, exit 0 = all PASS.

```bash
# orchestrator (preferred — runs all 4 scripts, prints 15/15 summary)
hexa run verify/run_all.hexa            # 4 scripts → 15 checks total; exit 0 = all PASS

# individual scripts (stdlib only)
python3 verify/grid_verify.py           # n=9 verb / 4-group lattice         (3 checks)
python3 verify/cross_doc_audit.py       # cross-doc consistency              (4 checks)
python3 verify/real_limits_audit.py     # LATTICE_POLICY §1.2 real-limits    (4 checks)
python3 verify/vendor_spec_audit.py     # raw#10 C3 vendor / industry defer  (4 checks)
```

| Script                          | Checks | What it verifies                                                                                          |
|--------------------------------- |-------:|-----------------------------------------------------------------------------------------------------------|
| `verify/grid_verify.py`          | 3      | 3/3 PASS — verb sentinel · group sentinel · 3-surface lattice equality (hexa.toml [closure]/[verbs]/CLI)  |
| `verify/cross_doc_audit.py`      | 4      | 4/4 PASS — per-group counts · verdict honesty · out-of-scope phrasing · no-rogue-code                     |
| `verify/real_limits_audit.py`    | 4      | 4/4 PASS — PUE > 1.0 floor · GPU TDP (B200/H200/MI300X/Gaudi3) · NVLink/UCIe/PCIe BW · ERCOT/PJM grid    |
| `verify/vendor_spec_audit.py`    | 4      | 4/4 PASS — no lattice-fit on externals · MLPerf/Top500 ref · crosslink integrity · CLI SPEC_FIRST sanity  |

### Honesty

PASS does NOT imply any quantitative claim in any verb spec `.md` has
been empirically validated. The `verbs_wired = 0/9` badge remains the
honest verdict at v1.0.0 (SPEC_FIRST, raw#10 C3).

Real-limit anchors are pinned by `verify/real_limits_audit.py` per
[`LATTICE_POLICY.md §1.2`](LATTICE_POLICY.md): datacenter PUE > 1.0
(energy conservation), NVIDIA B200 ~1000 W / H200 ~700 W / AMD MI300X
~750 W / Intel Gaudi 3 ~900 W (vendor TDP), NVLink 5 1.8 TB/s / PCIe 5.0
128 GB/s ×16 / UCIe 2.0 32 GT/s (vendor + standards bodies), ERCOT
peak ~85 GW / PJM peak ~165 GW (grid operator public reports).

External AI-infra entities (NVIDIA / AMD / Intel / CoreWeave / Lambda /
OpenAI / Anthropic / xAI) are referenced via THEIR own published
invariants — no n=6 lattice-fit framing applied. Performance claims
defer to MLPerf / Top500 (per raw#10 C3).

## Provenance

Extracted from `canon/domains/{compute,infra}/` @ `47c70cbf`
(2026-05-09). Each copy file carries an `@canonical:` provenance header
injected by `tools/inject_provenance.hexa`. Drift checked by
`tools/check_drift.hexa`.

## License

MIT.
