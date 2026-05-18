#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "environment_thermal" :: identity-claim [d=2026-05-14 active]
  kind = "Ultimate Environment Thermal (HEXA-ENVIRONMENT-THERMAL) — n=6 perfect-number architecture"
  brief = "Environment Thermal (HEXA-ENVIRONMENT-THERMAL) is foundational infrastructure that supports everyday life. Applying the n=6 perfect-number architecture (σ(6)=12, τ(6)=4, φ=2, sopfr(6)=5) targets **σ-φ"
  parent = "dancinlab/hexa-grid"
  sibling-md = "ENVIRONMENT-THERMAL.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in ENVIRONMENT-THERMAL.md.
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
