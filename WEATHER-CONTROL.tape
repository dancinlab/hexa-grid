#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "weather_control" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-WEATHER: 궁극의 대기 전자기 제어 시스템"
  brief = "**RT-SC 기반 σ²=144 km² 어레이로 기후 조절 — HAARP 1000배**"
  parent = "dancinlab/hexa-grid"
  sibling-md = "WEATHER-CONTROL.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in WEATHER-CONTROL.md.
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
