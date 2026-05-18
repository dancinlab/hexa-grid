#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "carbon_capture" :: identity-claim [d=2026-05-14 active]
  kind = "N6 탄소 포집 아키텍처 --- 궁극의 목표 (HEXA-CCUS)"
  brief = "**Carbon Z=6 기반, 원자 스케일부터 항성 스케일까지 관통하는 CO2 포집-저장-변환 아키텍처**"
  parent = "dancinlab/hexa-grid"
  sibling-md = "CARBON-CAPTURE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CARBON-CAPTURE.md.
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
