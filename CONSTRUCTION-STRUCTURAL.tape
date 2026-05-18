#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "construction_structural" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate construction / structural engineering (HEXA-CONSTRUCTION-STRUCTURAL) — n=6 perfect-number architecture"
  brief = "Construction / structural engineering (n=6 load universality + 12-tap seismic) is foundational infrastructure underpinning daily life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ="
  parent = "dancinlab/hexa-grid"
  sibling-md = "CONSTRUCTION-STRUCTURAL.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CONSTRUCTION-STRUCTURAL.md.
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
