#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "law_justice" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 법학/사법 — n=6 정의 아키텍처"
  brief = "**σ(6)·φ(6) = 6·τ(6) — 배심원 12=σ, 3심=n/φ, 6대법=n, 전 세계 사법 구조 20/20 EXACT**"
  parent = "dancinlab/hexa-grid"
  sibling-md = "LAW-JUSTICE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in LAW-JUSTICE.md.
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
