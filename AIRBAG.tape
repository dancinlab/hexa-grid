#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "airbag" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate airbag safety system (HEXA-AIRBAG) — n=6 perfect-number architecture"
  brief = "Airbag safety system (explosive-deploy 6-zone smart airbag) is foundational infrastructure underpinning daily life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ=2, sopfr(6)=5) targ"
  parent = "dancinlab/hexa-grid"
  sibling-md = "AIRBAG.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in AIRBAG.md.
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
