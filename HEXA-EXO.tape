#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "hexa_exo" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 AI 외골격 — HEXA-EXO (SE(3) n=6 DOF 전신 증강 시스템)"
  brief = "HEXA-EXO는 몸에 입는 AI 로봇이다. 무게 12kg(sigma), 배터리 24시간(J2), 근력 12배(sigma) 증강."
  parent = "dancinlab/hexa-grid"
  sibling-md = "HEXA-EXO.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in HEXA-EXO.md.
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
