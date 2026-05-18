#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "earthquake_engineering" :: identity-claim [d=2026-05-14 active]
  kind = "지진공학 — HEXA-Earthquake 내진·면진·제진"
  brief = "n=6          : 지진 스펙트럼 주기대, 내진 설계 카테고리, 면진장치 클래스"
  parent = "dancinlab/hexa-grid"
  sibling-md = "EARTHQUAKE-ENGINEERING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in EARTHQUAKE-ENGINEERING.md.
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
