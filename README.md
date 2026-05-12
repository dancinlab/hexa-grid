# 🌐 hexa-grid — AI 산업 인프라 fabric

> 9-verb AI-infrastructure substrate sitting between **hexa-energy (power)**,
> **hexa-chip (compute)**, and **hexa-codex (model)** — the connective fabric
> binding the AI industrial stack.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20102809.svg)](https://doi.org/10.5281/zenodo.20102809)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-informational.svg)](hexa.toml)
[![Verbs: 9 spec](https://img.shields.io/badge/verbs-9_spec-blue.svg)](#verbs)

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

## Verbs (9)

| group     | verbs                                               |
| --------- | --------------------------------------------------- |
| network   | `network`, `netproto`, `hexa_netproto`              |
| wireless  | `5g6g`, `lora_mesh`                                 |
| compute   | `gpgpu`, `ai_native`                                |
| facility  | `mfg_quality`, `construction`                       |

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

Spec-first at v1.0.0 — 9/9 verbs ship as peer-citable markdown docs.
Datacenter / power-grid / interconnect / cooling / model-serving are
**explicitly NOT_SCOPE** — sibling CLI is the SSOT for those.

## Provenance

Extracted from `canon/domains/{compute,infra}/` @ `47c70cbf`
(2026-05-09). Each copy file carries an `@canonical:` provenance header
injected by `tools/inject_provenance.hexa`. Drift checked by
`tools/check_drift.hexa`.

## License

MIT.
