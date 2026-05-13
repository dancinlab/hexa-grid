# TAPE-AUDIT — hexa-grid

**Date:** 2026-05-14 · **Lens:** `.tape` (typed events + 5 placements incl. `<DOMAIN>.tape`).

## A. Audit-class ledgers

`state/markers/*.marker` — same dancinlab boot-hook touchstones (5–8 markers), **CARGO**. `verify/` has 3 Python audit scripts (`vendor_spec_audit.py`, `cross_doc_audit.py`, `real_limits_audit.py`) — scripts, not ledgers (rc-touch output to markers). No `.jsonl`, no `.hook-audit.jsonl`.

## B. Identity surface

`hexa.toml` no `[identity]`. Cross-domain meta-substrate — identity is per-domain consumer, not here.

## C. Domain.md files

**59 top-level UPPERCASE.md** — by far the heaviest in this audit set: `ARCHITECTURE`, `AUTONOMOUS-DRIVING` (1 MB), `AVIATION`, `AIRBAG`, `CARBON-CAPTURE`, `CIVIL-ENGINEERING`, `CLIMATE`, `CONSTRUCTION-STRUCTURAL`, `LAW-JUSTICE`, `MANUFACTURING-QUALITY`, `METEOROLOGY`, `ENVIRONMENT-THERMAL`, `ENVIRONMENTAL-PROTECTION`, `ECOMMERCE-FINTECH`, `FUN-CAR`, `HEXA-EXO`, `CARTOGRAPHY-GIS`, `CALENDAR-TIME-GEOGRAPHY`, … . Each is a cross-domain knowledge dump (multi-MB). **Strong adoption** of the `<UPPERCASE>(+<UPPERCASE>)*.md` domain convention (governance #4) — including hyphen-joined meta-domains (`LAW-JUSTICE`, `CALENDAR-TIME-GEOGRAPHY`, `CARTOGRAPHY-GIS`) which match the `+` meta-domain convention semantically.

## D. Per-run / per-event history

None. The domain.md files are static spec dumps (large prose) — no append-only event log. Marker timestamps reset on each verify-run.

## E. Promotion candidates

- **`<DOMAIN>.tape`** (HIGH): the 59 domain.md files are the natural placement bucket. Each could grow a sibling `<DOMAIN>.tape` for log entries that don't belong in static prose — e.g. `AUTONOMOUS-DRIVING.tape` `@H` per real-world deployment milestone, `@?` for open questions, `@K` for kept-state policy. Today the prose carries everything.
- **n6 atoms** (LIGHT): pure-numerics cell IDs (carbon-capture rate triplets, ASML throughput cells) — but real-limits-first policy bars forced n6 fits.
- **hxc / n12**: none.

## Verdict

**MEDIUM** — 59 domain.md files = the densest domain-roll-up in the society/mobility set, perfect candidate for `<DOMAIN>.tape` companion files. State surface today is marker-cargo only; no live event stream. Heaviest `.tape` adoption potential of the application-substrate group.
