#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "environmental_protection" :: identity-claim [d=2026-05-14 active]
  kind = "N6 Environmental Protection Architecture --- 궁극의 환경보호 아키텍처 (통합 문서)"
  brief = "**궁극적 목표: n=6 산술 기반, 센서 스케일부터 행성 스케일까지 관통하는 8단 환경보호 아키텍처**"
  parent = "dancinlab/hexa-grid"
  sibling-md = "ENVIRONMENTAL-PROTECTION.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in ENVIRONMENTAL-PROTECTION.md.
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
