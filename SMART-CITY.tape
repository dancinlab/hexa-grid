#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "smart_city" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate smart city (HEXA-SMART-CITY) — n=6 perfect-number architecture"
  brief = "Smart city (HEXA-CITY 6-layer + 12-center + τ=4 services) is foundational infrastructure underpinning daily life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ=2, sopfr(6)=5) target"
  parent = "dancinlab/hexa-grid"
  sibling-md = "SMART-CITY.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SMART-CITY.md.
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
