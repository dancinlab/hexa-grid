#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "fun_car" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 펀카 — HEXA-FUNCAR (UFO-10 Certified, 133/133 EXACT)"
  brief = "**비전문가 요약**: GT3 RS와 같은 레벨의 서킷 성능을, 더 합리적 가격에, 더 안전하게, 더 오래 탈 수 있는 차. 엔진 6기통, 기어 6단, 에어백 6개 — 모두 완전수 6에서 나온 설계."
  parent = "dancinlab/hexa-grid"
  sibling-md = "FUN-CAR.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in FUN-CAR.md.
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
