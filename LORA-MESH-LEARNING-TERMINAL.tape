#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "lora_mesh_learning_terminal" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-LORA-MESH-LEARNING-TERMINAL mk1 — physical-limit-anchored offline rural learning network"
  brief = "LORA-MESH-LEARNING-TERMINAL per-domain ledger · sibling of LORA-MESH-LEARNING-TERMINAL.md"
  parent = "dancinlab/hexa-grid"
  sibling-md = "LORA-MESH-LEARNING-TERMINAL.md"

# ─── §Log (append @A / @D events here, chronological) ────────────────
# 
# Pre-existing log entries live in LORA-MESH-LEARNING-TERMINAL.md.
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
