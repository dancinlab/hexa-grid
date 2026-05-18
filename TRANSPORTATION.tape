#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "transportation" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-FUNCAR -- 궁극의 Transportation (Consolidated Goal)"
  brief = "하이퍼카 성능 + 스포츠카 가격 -- 완전수가 설계한 차."
  parent = "dancinlab/hexa-grid"
  sibling-md = "TRANSPORTATION.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in TRANSPORTATION.md.
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
