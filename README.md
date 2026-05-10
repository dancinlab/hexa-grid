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

## Quick start

```sh
hx install hexa-grid
hexa-grid status         # 9-verb table + cross-link map
hexa-grid gpgpu          # gpgpu.md spec headline
hexa-grid selftest       # verb-count check

# for cross-domain concerns, call sibling CLIs:
hexa-energy smr_dc
hexa-energy grid
hexa-chip interconnect
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
