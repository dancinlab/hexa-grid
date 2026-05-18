#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "marketing" :: identity-claim [d=2026-05-14 active]
  kind = "궁극의 마케팅 아키텍처 -- HEXA-MKT"
  brief = "n=6  sigma=12  tau=4  phi=2  sopfr=5  J2=24  lambda=2  R=1"
  parent = "dancinlab/hexa-grid"
  sibling-md = "MARKETING.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in MARKETING.md.
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
