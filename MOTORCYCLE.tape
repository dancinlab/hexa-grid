#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "motorcycle" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 바이크 (HEXA-BIKE) — 완전수 n=6 모터사이클 아키텍처"
  brief = "바이크는 전 세계 3억 대 이상 운행 중인 핵심 이동수단입니다."
  parent = "dancinlab/hexa-grid"
  sibling-md = "MOTORCYCLE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in MOTORCYCLE.md.
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
