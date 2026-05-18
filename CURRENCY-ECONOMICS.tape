#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "currency_economics" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 화폐/경제사 — n=6 통화 래더 아키텍처"
  brief = "**σ(6)·φ(6) = 6·τ(6) — 금 24K=J₂, FRB 12지구=σ, 이집트 분수 1/2+1/3+1/6=1, 20/20 EXACT**"
  parent = "dancinlab/hexa-grid"
  sibling-md = "CURRENCY-ECONOMICS.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in CURRENCY-ECONOMICS.md.
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
