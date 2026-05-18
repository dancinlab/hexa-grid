#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "civil_engineering" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate civil engineering (HEXA-CIVIL-ENGINEERING) — n=6 perfect-number architecture"
  brief = "Civil engineering (HEXA-Civil cable-stayed bridge / bridge / tunnel n=6 design) is foundational infrastructure underpinning daily life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ"
  parent = "dancinlab/hexa-grid"
  sibling-md = "CIVIL-ENGINEERING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CIVIL-ENGINEERING.md.
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
