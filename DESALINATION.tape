#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "desalination" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-DESAL — 초전도 해수 담수화 (Ultimate SC Desalination)"
  brief = "**일상 시나리오**:"
  parent = "dancinlab/hexa-grid"
  sibling-md = "DESALINATION.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in DESALINATION.md.
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
