#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "governance_safety_urban" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate governance/safety/urban (HEXA-GOVERNANCE-SAFETY-URBAN) — n=6 perfect-number architecture"
  brief = "Governance / safety / urban (6-axis + 12-indicator smart governance) is foundational infrastructure underpinning daily life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ=2, sopfr(6"
  parent = "dancinlab/hexa-grid"
  sibling-md = "GOVERNANCE-SAFETY-URBAN.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in GOVERNANCE-SAFETY-URBAN.md.
# New per-domain history entries land here as typed events:
#
#   @A commit_<hash> :: <domain> [d=<YYYY-MM-DD> ok]
#     <- <prev-id>
#     => "<one-line description>"
#
#   @D <id> := "<decision-name>" :: <domain> [<grades>]
#     <- <evidence-id>
#     |> <verifier>
#
# See ~/core/tape/spec/tape.md for full grammar.
