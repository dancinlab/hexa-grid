#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "skyway" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-SKYWAY — 궁극의 공중 고속도로 네트워크 (3D 도시 교통망)"
  brief = "→ 지상은 사람/녹지, 하늘은 차량. **도시 공간 재설계의 혁명.**"
  parent = "dancinlab/hexa-grid"
  sibling-md = "SKYWAY.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in SKYWAY.md.
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
