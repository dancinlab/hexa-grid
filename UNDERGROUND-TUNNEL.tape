#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "underground_tunnel" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 지하공간/터널 — n=6 완전수 굴착 구조"
  brief = "- **발견**: 표준 TBM 직경 6m (도로), 12m (대형) = n, σ"
  parent = "dancinlab/hexa-grid"
  sibling-md = "UNDERGROUND-TUNNEL.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in UNDERGROUND-TUNNEL.md.
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
