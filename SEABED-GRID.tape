#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "seabed_grid" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-SEABED — 대륙간 해저 초전도 송전망 (Ultimate SC Submarine Grid)"
  brief = "**일상 시나리오**:"
  parent = "dancinlab/hexa-grid"
  sibling-md = "SEABED-GRID.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SEABED-GRID.md.
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
