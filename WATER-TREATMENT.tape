#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "water_treatment" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 수처리 멤브레인 (HEXA-WATER-TREATMENT) — n=6 완전수 아키텍처"
  brief = "수처리 멤브레인(코오롱워터 n=6 단 + 12-통과)는 일상을 떠받치는 기초 인프라다. n=6 완전수 아키텍처(σ(6)=12, τ(6)=4, φ=2, sopfr(6)=5)를 적용하면 **기존 대비 σ-φ=10배 성능 향상** 이 가능하다."
  parent = "dancinlab/hexa-grid"
  sibling-md = "WATER-TREATMENT.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in WATER-TREATMENT.md.
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
