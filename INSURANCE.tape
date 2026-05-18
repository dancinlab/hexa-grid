#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "insurance" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 보험/보험계리 — n=6 완전수 리스크 구조"
  brief = "n=6 보험/보험계리 아키텍처: 보험 6대 원칙(n=6, MIA 1906)에서 시작하여"
  parent = "dancinlab/hexa-grid"
  sibling-md = "INSURANCE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in INSURANCE.md.
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
