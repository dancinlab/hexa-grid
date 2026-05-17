#!/usr/bin/env tape
# ══════════════════════════════════════════════════════════════════════
# .tape v1.2 — grammar primer (cold-read by any LLM / agent / human)
# ══════════════════════════════════════════════════════════════════════
# Form: each entry is `@<type> <id> := "<subject>" :: <kind> [<grades>]`
#       optionally followed by body lines (2-space indent) — key=value,
#       edges (<- -> => …), or quoted prose.
#
# ENTRY TYPES (17):
#   Runtime (10): @S session  @U user  @A assistant  @T tool-call  @R result
#                 @H hook  @D decision  @K cost  @P provider  @? anomaly
#   Foundation:   @I identity-claim
#   Declarative:  @X external-citation  @F forbidden-pattern  @N note
#                 @C config  @L layout  @V spec-version
#
# EDGES (12, on body lines, 2-space indent):
#   Causal:     <- caused-by   -> triggers   == continues
#               ~> supersedes  !! aborts     |> verified-by
#   Effect:     => produces (followed by quoted natural-language)
#   Structural: <: specializes  :> generalizes  ?> soft-depends
#               !> conflicts-with  @> projects-to (e.g. @> AGENTS.md)
#
# GRADE TAGS (in [...] on entry header):
#   Delivery:   ok · err · denied · cancelled · partial · superseded
#   Governance: required · recommended · optional · draft · active · deprecated
#   Scoped:     allow:<x> · deny:<x>
#   Time/index: T<n> (turn)  N<n> (wall-sec)  d=<YYYY-MM-DD>
#
# PAYLOAD SYNTAX (body lines):
#   key = "value"           single-line string
#   key = [a, b, c]         array literal
#   key <<~EOF              heredoc (multi-line; ends with EOF on own line)
#     multi-line text
#   EOF
#   "see [@x1] §3"          inline citation by entry id
#   `cmd or path`           backtick code-span (inline only)
#
# Full spec: ~/core/tape/spec/tape.md (or github.com/dancinlab/tape)
# ══════════════════════════════════════════════════════════════════════
#
# AGENTS.tape for `dancinlab/hexa-grid`

@V := "tape" :: spec [active]
  version = "1.2"

@X hexa_verify := "hexa verify — verification via hexa CLI only" :: guide [active]
  tldr = "Any correctness / purity / grade / identity claim → verify with `hexa <verb>` or `hexa run <verifier>.hexa` (e.g. `hexa run tool/atlas_verify.hexa`) and paste the verdict VERBATIM. NEVER cite sympy / PyPhi / Wolfram / Mathematica output as evidence."
  detail = "~/core/atlas/VERIFY.tape"

@X wilson_pool := "wilson pool — resource utilization" :: guide [active]
  tldr = "Heavy / deterministic work (build · drill · probe · compile · test-sweep · GPU fire) → do NOT serialize on localhost; route to the host pool: `wilson pool list` then `wilson pool on <host> <cmd>`, or a ToolUse `\"host\"` field. Empty roster = degrade-to-local, fine."
  detail = "~/core/atlas/POOL.tape"

@I id001 := "hexa-grid" :: identity-claim [d=2026-05-14 active]
  kind = "HEXA-Grid family — grids · mining · monetary history"
  brief = "HEXA-Grid family · grids · mining · monetary history"
  parent = "dancinlab"

@L l1 := "repo-layout" :: structure [active]
  AGENTS.tape -> "this file · governance + identity (.tape v1.2)"
  AIRBAG.md -> "documentation"
  ARCHITECTURE.md -> "documentation"
  AUTONOMOUS-DRIVING.md -> "documentation"
  AVIATION.md -> "documentation"
  CALENDAR-TIME-GEOGRAPHY.md -> "documentation"
  CARBON-CAPTURE.md -> "documentation"
  CARTOGRAPHY-GIS.md -> "documentation"
  CITATION.cff -> "file"
  CIVIL-ENGINEERING.md -> "documentation"
  CLAUDE.md -> "symlink → AGENTS.tape"
  CLIMATE.md -> "documentation"
  CONSTRUCTION-STRUCTURAL.md -> "documentation"
  CONTROL-AUTOMATION.md -> "documentation"
  CURRENCY-ECONOMICS.md -> "documentation"
  DESAL.md -> "documentation"
  DESALINATION.md -> "documentation"
  EARTH-DEFENSE.md -> "documentation"
  EARTHQUAKE-ENGINEERING.md -> "documentation"
  ECOMMERCE-FINTECH.md -> "documentation"
  ECONOMICS-FINANCE.md -> "documentation"
  ECONOMICS.md -> "documentation"
  ELECTRIC-VEHICLE.md -> "documentation"
  ENVIRONMENT-THERMAL.md -> "documentation"
  ENVIRONMENTAL-PROTECTION.md -> "documentation"
  FIRE-SCIENCE.md -> "documentation"
  FORENSIC-SCIENCE.md -> "documentation"
  FUN-CAR.md -> "documentation"
  GEOLOGY.md -> "documentation"
  GOVERNANCE-SAFETY-URBAN.md -> "documentation"
  HEXA-DEFENSE.md -> "documentation"
  HEXA-EXO.md -> "documentation"
  HEXA-SKYWAY.md -> "documentation"
  HEXA-TSUNAMI.md -> "documentation"
  HEXA-WEATHER.md -> "documentation"
  hexa.toml -> "TOML config"
  IMPORTED_FROM_CANON.md -> "documentation"
  install.hexa -> "hexa-lang source"
  INSURANCE.md -> "documentation"
  JURISPRUDENCE.md -> "documentation"
  LATTICE_POLICY.md -> "project-local copy of dancinlab real-limits standard"
  LAW-JUSTICE.md -> "documentation"
  LICENSE -> "license file"
  LIMIT_BREAKTHROUGH.md -> "per-domain HARD/SOFT_WALL · BREAKABLE_WITH_TECH · UNCLEAR audit"
  LORA-MESH-LEARNING-TERMINAL.md -> "documentation"
  MANUFACTURING-QUALITY.md -> "documentation"
  MARKETING.md -> "documentation"
  METEOROLOGY.md -> "documentation"
  MINING.md -> "documentation"
  MONETARY-HISTORY.md -> "documentation"
  MOTORCYCLE.md -> "documentation"
  NAVAL-ARCHITECTURE.md -> "documentation"
  OCEAN.md -> "documentation"
  OCEANOGRAPHY.md -> "documentation"
  PRINTING.md -> "documentation"
  README.md -> "human intro · 18-block format (atlas/README-FORMAT.md)"
  ROBOTICS-TRANSPORT.md -> "documentation"
  ROBOTICS.md -> "documentation"
  SAFETY.md -> "documentation"
  SEABED-GRID.md -> "documentation"
  SKYWAY.md -> "documentation"
  SMART-CITY.md -> "documentation"
  SURVEYING.md -> "documentation"
  TAPE-AUDIT.md -> ".tape v1.x adoption audit ledger"
  TRANSPORTATION.md -> "documentation"
  TSUNAMI-SHIELD.md -> "documentation"
  ULTIMATE-SAFETY.md -> "documentation"
  UNDERGROUND-TUNNEL.md -> "documentation"
  WATER-TREATMENT.md -> "documentation"
  WEATHER-CONTROL.md -> "documentation"
  5g6g/ -> "subdir (1 items)"
  ai-efficiency/ -> "subdir (2 items)"
  ai_native/ -> "subdir (1 items)"
  browser/ -> "subdir (1 items)"
  cli/ -> "subdir (1 items)"
  compiler-os/ -> "subdir (1 items)"
  construction/ -> "subdir (1 items)"
  digital-twin/ -> "subdir (1 items)"
  gpgpu/ -> "subdir (1 items)"
  hexa-proglang/ -> "subdir (1 items)"
  hexa_netproto/ -> "subdir (1 items)"
  keyboard/ -> "subdir (1 items)"
  learning-algorithm/ -> "subdir (1 items)"
  lora_mesh/ -> "subdir (1 items)"
  mfg_quality/ -> "subdir (1 items)"
  mouse/ -> "subdir (2 items)"
  netproto/ -> "subdir (1 items)"
  network/ -> "subdir (1 items)"
  papers/ -> "papers / publications (2 items)"
  programming-language/ -> "subdir (1 items)"
  software-crypto/ -> "subdir (1 items)"
  software-design/ -> "subdir (1 items)"
  spatial-computing/ -> "subdir (1 items)"
  state/ -> "runtime state (gitignored typically) (1 items)"
  tests/ -> "test suite"
  verify/ -> "verification scripts (5 items)"

@D g_inherit := "inherits-lattice-policy" :: governance [required]
  rule = "All echoes/LATTICE_POLICY.md rules apply — real-limits-first · lattice-is-tool · verification-anchor-real-limit · no-artificial-ceilings · honesty-obligation-external."
  authority = "[@x_lattice_policy]"
  @> AGENTS.md

@D g1 := "real-limits-first" :: governance [required]
  rule = "The project's ceiling is set by REAL math/physics/engineering limits, NEVER by the n=6 invariant lattice."
  authority = "[@x_lattice_policy]"
  @> AGENTS.md

@D g2 := "lattice-is-tool" :: governance [required]
  rule = "n=6 lattice is a TOOL, not a CONSTRAINT. Use only where it naturally fits."
  <: g1
  @> AGENTS.md

@D g3 := "honesty-obligation-external" :: governance [required deny:write]
  rule = "Claims about external entities (companies · fabs · vendors) must NOT include lattice-fit assertions. Use their OWN invariants."
  @> AGENTS.md

@D g4 := "commit-conventions" :: governance [recommended]
  rule = "AI-assisted commits include \`Co-Authored-By: <model> <noreply@anthropic.com>\` trailer; Conventional Commits title."
  @> AGENTS.md

@D g_arch_vs_log_split := "v1.2 architecture-vs-history split" :: governance [required d=2026-05-14 active]
  rule = "UPPERCASE.tape files are EDITABLE architecture (latest-wins per id). Append-only event history lives in UPPERCASE.log.tape siblings."
  why = "declarative entries (governance · config · layout · identity) evolve naturally; locking them as append-only via ~> supersedes creates noisy histories. The split lets architecture stay current and history stay immutable."
  applies-to = "AGENTS.tape · all UPPERCASE.tape root files"
  authority = "[@x_tape_spec] §Domain-tape sibling §Architecture-vs-history split"
  @> AGENTS.md


@F f1 := "lattice-fit-on-external-entity" :: governance [required deny:write]
  pattern = "applying n=6 lattice as derivation rule to TSMC · ASML · IPCC · NASA · SpaceX · CERN · DeepMind · NIST · or any external vendor"
  exception = "values may coincidentally match — observation OK, derivation NOT OK"

@X x_lattice_policy := "echoes/LATTICE_POLICY.md" :: policy [d=2026-05-12 active]
  url = "https://github.com/dancinlab/echoes/blob/main/LATTICE_POLICY.md"

@X x_tape_spec := "tape v1.2 spec" :: spec [d=2026-05-14 active]
  url = "https://github.com/dancinlab/tape/blob/main/spec/tape.md"
  scope = "this file's grammar reference"

@H h1 := "agents-md-replaced" :: generator [active]
  note = "AGENTS.md replaced by this AGENTS.tape (tape v1.2)"

@H h2 := "claude-md-symlink" :: generator [active]
  rule = "CLAUDE.md → AGENTS.tape symlink"
  command = `ln -sf AGENTS.tape CLAUDE.md`
