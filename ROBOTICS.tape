#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "robotics" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 로봇 아키텍처 — HEXA-ROBOT"
  brief = "n=6 완전수 산술로 원자 스케일 소재부터 군집 지능까지 관통하는 8단 로봇 아키텍처."
  parent = "dancinlab/hexa-grid"
  sibling-md = "ROBOTICS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in ROBOTICS.md.
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
