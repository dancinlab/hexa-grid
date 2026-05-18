#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "autonomous_driving" :: identity-claim [d=2026-05-14 active]
  kind = "N6 Autonomous Driving Architecture --- Ultimate One-Page Goal"
  brief = "n = 6        sigma(6) = 12     tau(6) = 4      phi(6) = 2"
  parent = "dancinlab/hexa-grid"
  sibling-md = "AUTONOMOUS-DRIVING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in AUTONOMOUS-DRIVING.md.
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
