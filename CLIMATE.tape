#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "climate" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 기후 아키텍처 — HEXA-CLIMATE"
  brief = "┌──────────────────────────────────────────────────────────────────┐"
  parent = "dancinlab/hexa-grid"
  sibling-md = "CLIMATE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CLIMATE.md.
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
