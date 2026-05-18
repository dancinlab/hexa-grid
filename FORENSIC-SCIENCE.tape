#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "forensic_science" :: identity-claim [d=2026-05-14 active]
  kind = "Forensic Science (HEXA-FORENSIC) — n=6 Locard 6 trace evidence classes"
  brief = "Locard's exchange principle anchors **6 trace-evidence classes** (fiber,"
  parent = "dancinlab/hexa-grid"
  sibling-md = "FORENSIC-SCIENCE.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in FORENSIC-SCIENCE.md.
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
