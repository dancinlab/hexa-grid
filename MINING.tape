#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "mining" :: identity-claim [d=2026-05-14 active]
  kind = "광업광물학 — 궁극의 n=6 아키텍처 (HEXA-MINING)"
  brief = "┌──────────────────────────────────────────────────────────┐"
  parent = "dancinlab/hexa-grid"
  sibling-md = "MINING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in MINING.md.
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
