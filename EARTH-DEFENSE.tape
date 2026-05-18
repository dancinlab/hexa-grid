#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "earth_defense" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-DEFENSE — 궁극의 지구방어 시스템"
  brief = "┌──────────────────────────────────────────────────────────────┐"
  parent = "dancinlab/hexa-grid"
  sibling-md = "EARTH-DEFENSE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in EARTH-DEFENSE.md.
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
