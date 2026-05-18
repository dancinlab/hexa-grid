#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "aviation" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate Aviation (HEXA-AVIATION) — n=6 perfect-number architecture"
  brief = "Aviation (HEXA-AVIATION) is foundational infrastructure that supports everyday life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ=2, sopfr(6)=5) targets **σ-φ=10× performance gain "
  parent = "dancinlab/hexa-grid"
  sibling-md = "AVIATION.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in AVIATION.md.
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
