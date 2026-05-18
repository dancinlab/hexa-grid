#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "tsunami_shield" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-TSUNAMI — 궁극의 해일 방지기 (능동 파랑 반사벽)"
  brief = "→ **파도를 능동 차단**. 수동 콘크리트 방파제 시대 종료."
  parent = "dancinlab/hexa-grid"
  sibling-md = "TSUNAMI-SHIELD.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in TSUNAMI-SHIELD.md.
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
