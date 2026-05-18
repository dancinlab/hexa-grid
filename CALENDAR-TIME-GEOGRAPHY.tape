#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "calendar_time_geography" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate calendar / time / geography (HEXA-CALENDAR-TIME-GEOGRAPHY) — n=6 perfect-number architecture"
  brief = "Calendar / time / geography (sexagesimal + n=6 spacetime principle) is foundational infrastructure underpinning daily life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ=2, sopfr(6)"
  parent = "dancinlab/hexa-grid"
  sibling-md = "CALENDAR-TIME-GEOGRAPHY.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CALENDAR-TIME-GEOGRAPHY.md.
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
