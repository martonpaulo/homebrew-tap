# Project Working Agreements

## Project identity and policy

- Display name: `martonpaulo/tap`
- Code name: `homebrew-tap`
- Slug: `homebrew-tap`
- Identifier name: `tap`
- Benefit-first description: Install Marton Paulo's macOS apps, WindowHop and Leve, with one Homebrew command each, and remove each app and its settings with one more.
- Repository: `martonpaulo/homebrew-tap` (public)
- Public identifiers: tap `martonpaulo/tap` (from the repository name `homebrew-tap`); cask tokens `windowhop` and `leve`, each the app's lowercase slug and the file name `Casks/<slug>.rb`. Renaming any of them breaks every existing install command.
- Landing page: None. The README is the only surface; each app's own site or repository is its landing page.
- License: `GPL-3.0-only`
- Copyright: 2026 Marton Paulo
- Development language: English.
- Product copy: English only, in the README and the casks' `desc`; no localization.
- Branch policy: work directly on `main`; a branch and pull request only when the owner asks for one. Dependabot pull requests merge through GitHub.
- Commit policy: automatic. Commit each completed task once `make check` passes, one commit per concern, only the task's files. The app release workflows commit `chore: <Name> <version>` as `github-actions[bot]`.
- Push policy: automatic. Push each validated commit to `origin/main` right away, as in the owner's other repositories (assumed on 2026-11-26 while the owner was away; no policy was recorded before). A push changes what every user installs, so never push a cask whose `url` and `sha256` were not checked against the published release. Never force-push.
- Product versioning: none. The tap has no version of its own; each cask's `version` follows its app's published release.
- Merge policy: merge commits only; never squash or rebase
- Commit subject: a commit made for an issue ends with `(#<issue number>)`, never the pull request's.
- Delete branches after merge: disabled
- Release, signing, and secret-storage policy: not applicable to the tap itself: it publishes no release. Each app's `release.yml` bumps its cask with the optional `HOMEBREW_TAP_TOKEN` secret, stored in the app repository, never here; without it, the cask is bumped by hand with `bench-release`'s `bump-cask.sh`. The `bench-project-standards` skill's `references/homebrew-tap.md` owns both paths.
- Default-branch protection: none, and no ruleset. Its one author commits to `main` directly, the app release workflows push cask bumps to it, and `make check` gates each commit; read the `Validate` result after each push (recorded 2026-11-26).
- Secret protection: GitHub secret scanning and push protection enabled (read back 2026-11-26). They are backstops, not a substitute for reading the exact payload before a push.
- Skill packs: core, release
- Skills baseline revision: `560c2437ee7e93e7fd9c8c52102f593bb96f166a`
- Skills baseline applied: `2026-11-26`

Change an identifier or policy recorded above only through an explicit task describing the migration and its effects.

## Route map

Before editing under a path, read the file its row names. A module with rules of its own keeps them in its own `AGENTS.md` of at most 150 lines, beside a `CLAUDE.md` symlink, and has a row here; this file stays at most 200 lines.

| Path | Read first |
| :--- | :--- |
| `Casks/` | `AGENTS.md (Patterns), then the bench-project-standards skill's references/homebrew-tap.md` |
| `README.md` | `AGENTS.md (Patterns) and docs/product.md` |
| `scripts/` | `AGENTS.md (Tests and validation): every file there is an unchanged copy` |

## Patterns

The patterns this tap repeats. A change that breaks one or adds a new one asks the owner first.

- One cask per app at `Casks/<slug>.rb`, in the shape and stanza order of the `bench-project-standards` skill's `references/homebrew-tap.md`: `version`, `sha256`, `url` on the app's GitHub release `v#{version}` disk image, `name`, `desc`, `homepage`, `livecheck` with `:github_latest`, `auto_updates true`, `depends_on`, `app`, `uninstall quit:` with the bundle identifier, then `zap trash:`. Guarded by `brew style` in `make check`.
- `sha256` is the digest GitHub recorded for the published release asset, never a local checksum and never a placeholder. No check guards it yet: `brew audit --cask --online martonpaulo/tap/<slug>` is the manual review.
- `zap trash:` lists the caches, `HTTPStorages` (with `.binarycookies`) and preferences of the current bundle identifier and of every legacy one, in alphabetical order. Review guards it.
- A version bump is one commit `chore: <Name> <version>` that changes only `version` and `sha256`; a new cask is `feat: add the <Name> cask` together with its README section.
- The README has one section per app: one sentence, links, the install command, the requirements and first-run permission, the Sparkle note and the `--zap` uninstall command. Review guards it.

## Agent skill paths

- Product definition: `docs/product.md`
- Decision log: `docs/decisions.md` (create with the first consequential decision)
- Canonical rules: `docs/rules/`, adapter data: `docs/adapters/` (create only when a rule exists)
- Domain glossary: `GLOSSARY.md`
- Research notes: `docs/research/` (create only when persisting research; a status line opens each note, superseded notes move to `docs/research/archive/`)
- Handoffs: `.scratch/handoffs/handoff.md`
- Prototypes: `.scratch/prototypes/`

## Instruction hierarchy and sources of truth

- Follow the direct task, the most specific scoped instructions, this file, then general agreements. Read applicable instructions before editing.
- Code is evidence of current behavior, `AGENTS.md` is normative for process, and an approved specification for desired behavior. Expose divergence among them; never resolve it silently.
- When two sources disagree (issues, comments, this file, the agent's memory, the owner's current instruction), a newer trusted statement is the recommended side, never the decided one. Ask the owner before acting on either side and record the answer in the newer issue; `bench-agent-context` owns the precedence.
- Keep one canonical source per rule, as the `bench-project-standards` skill's `references/documentation-standard.md` defines; issues, code and tests cite a rule's ID, never its text.
- Do not turn analysis, research, or a read-only audit into implementation without authorization.
- The owner calls `bench-<verb>` and `bench-issue-*` by name; every other skill is internal: offer one in plain words, never by name.
- Be direct and evidence-based: state assumptions, risks, tradeoffs, blockers. Ask only about a material decision you cannot discover safely; otherwise make explicit, reversible assumptions.
- Give concise progress updates during long-running work.

## Long-running operations

Long-running work follows the `bench-project-standards` skill's `references/long-running-operations.md`. A delegation brief states its concurrency budget; without one, the delegated agent spawns no sub-agents. Delegate only bounded, independent work that cannot race on shared writes; the parent keeps scope, verification and every mutation.

## Before editing

1. Check Git status and the current branch.
2. Search for the behavior, callers, tests, contracts, and nearby patterns; read only the chunks the change needs.
3. Distinguish verified facts, reasonable inferences, and unknowns, and define the source of truth before changing data or state.
4. When the project records an upstream or reference project, consult it before planning. When
   this project solves the problem differently, document the divergence and its reason.
5. Make a short plan only for complex, risky, ambiguous, or multi-file work.

## Scope, reuse, and implementation

- Preserve behavior outside the task and unrelated or uncommitted user changes.
- Follow the patterns this project already repeats. When a change would break a recorded pattern or establish a new one, stop and ask first, naming the existing pattern, the proposed one, and why the existing one does not fit.
- When a change sets or fixes a pattern, the same delivery adds the cheapest automatic check that guards it: a lint or type rule, a test over the repository, a gate script. A check larger than the fix becomes its own issue, linked from the change ([martonpaulo/skill-deck#732](https://github.com/martonpaulo/skill-deck/issues/732)).
- Prefer the smallest correct, readable, reversible solution that is cheap to operate.
- Keep one owner and one source of truth for each business rule, state, default, and copy value, outside presentation and adapter layers. Derive values instead of storing synchronized copies; model invalid states explicitly.
- Deliver large changes in reviewable, executable increments. Implement errors, states, accessibility, and tests with the behavior.
- Never return a success-shaped default (zero, an empty list, `ok`) for a value that failed or is missing; show or raise the failure. A result that is really empty stays empty ([#758](https://github.com/martonpaulo/skill-deck/issues/758)).

## Data, security, and destructive operations

- Distinguish canonical data, reconstructible cache, transient state, and preferences. Persist or synchronize only data that must survive or cross devices; a cache never becomes a source of truth.
- Use stable application-owned identifiers, and validate data at input and persistence boundaries.
- Change a relational schema only through an explicit, tested, versioned migration, never manually in production. Use transactions or atomic writes when partial failure could leave inconsistent state.
- Request only necessary permissions and scopes. Keep credentials, keys, signing material, personal data, and sensitive payloads out of the repository and logs.
- Use structured subprocess arguments and validate destinations, redirects, and untrusted inputs.
- Apply the `bench-project-standards` skill's `references/security-standard.md` to every change, plan and audit that touches a surface it covers; `docs/security.md` records each item's answer.
- Resolve an exact target before deletion, overwrite, interruption, or another hard-to-recover action. A clear request authorizes its exact resolved operation; ask again when the target is ambiguous, loss is difficult to recover, or effects exceed the named scope.
- Prefer recoverable deletion. Never perform broad cleanup without explicit authorization. Never force-push, except to purge sensitive data from a remote branch's history, on the owner's approval of that exact push, as the `bench-github-publishing` skill's section 2 defines.

## Product interface and accessibility

- Prefer native platform components and established patterns; custom UI must provide clear product value.
- Before changing an interface, a style, or a visual asset, name what the product should communicate and how it should feel, from the product definition and brand decisions, and judge visual and copy choices by that intent. When none is recorded, state the one you infer and ask before a consequential visual change.
- Define the layout and the loading, empty, error, disabled, and destructive states that apply. Include keyboard navigation, focus, screen-reader labels, scalable text, contrast, reduced motion, and non-color status cues in the same change.
- Build every interface to the `bench-project-standards` skill's `references/interface-standard.md`; an explicit owner request to do otherwise wins and is recorded where this project records decisions.
- Before showing an interface change to the owner, compare it side by side with its reference and take its sizes and colours from that reference, measured, as the `bench-project-standards` skill's `references/reference-comparison.md` defines. Interface reference: a reference app: none applies, the tap has no interface; the README follows the `bench-project-standards` skill's `references/public-surface-style.md`.
- Accessibility evidence: the view code, reviewed in each change; `docs/product.md` records the accepted gap under `## Accepted evidence gaps`. Manual screen-reader passes are not run and never block completion, as the `bench-capture` skill defines ([martonpaulo/skill-deck#266](https://github.com/martonpaulo/skill-deck/issues/266)).
- Keep visible copy centralized and localized. Keep expensive work out of render paths and hot loops. Measure before claiming a performance problem.

## Code, comments, and documentation

- Write code, comments, commits, filenames, tests, configuration, and developer documentation in English; product copy follows the localization strategy. Write human-facing English in plain international English that non-native readers understand: precise verbs, no idioms, short sentences.
- Prefer clear types and simple control flow.
- Comment non-obvious constraints, linking official documentation when a workaround must stay visible.
- Update the smallest canonical documentation section when a durable contract changes; never create empty documentation.
- A divergence answer goes in the newer issue's Clarify. A decision that changes a durable rule rewrites the document that owns it, which keeps only the current rule with a short `#N` link, and adds one row to the `## Decision index` of `docs/decisions.md`, the only home of decision history. An ADR is the owning document only for architecture. No issue, wiki page or long-lived comment serves as a decision register.
- Each limit the owner sets is one row of the product definition's `## Limits the owner set`, in the same commit; a relaxed limit keeps its row as «replaced» ([martonpaulo/skill-deck#738](https://github.com/martonpaulo/skill-deck/issues/738)).
- README: the recorded `Display name` is the H1. Links to the live project are allowed. The rest
  follows the `bench-project-standards` skill's `references/public-surface-style.md`.
- Every fenced code block you create or materially edit has an explicit language identifier.
- Never mark an API, a flag or a behaviour `implemented` without running it. Fix or drop a broken script; never ship it documented as working.
- Every issue or pull request reference in Markdown prose is a link to the issue's URL; code,
  quoted lines and quoted commit subjects stay as written. The `bench-setup` skill's
  `assets/issue_links.py` checks it in the gate.
- Preserve third-party licenses and notices in `NOTICE.md`. Maintain `CHANGELOG.md` when the project has public releases.

## Durable project learning

At wrap-up, propose recording a learning only when it is verified, specific to this project, likely
to recur, and not already recorded, as the `bench-project-standards` skill's `references/durable-learning.md`
defines. A command that failed twice for the same cause qualifies: record the cause and working form.
End each finding, here or in `martonpaulo/skill-deck` for one about Skill Deck itself, as
`bench-github-publishing` section 15 defines.

## Output shape and asking the owner

Shape every message and ask the owner as Skill Deck's global rules define (`global/AGENTS.md`, which `bench sync` links into every agent); the four kinds of request are in the `bench-owner-questions` skill's `references/attention-cards.md`. Do every action your tools allow instead of handing it to the owner; hand over only what the owner alone can do, as those rules list.

## Configuration and repository hygiene

- Ignore secrets, local environments, logs, caches, and build output. Keep `.env.example` with every variable and a safe placeholder, and secrets only in the platform's secure store. Nothing new in `~` (`project-layout.md`).
- Add CI, dependency updates, release workflows, and signing only when distribution or risk requires them.
- The Validate workflow has no `pull_request_target` trigger and reads no stored secret, so it runs on a fork; the `validate-trust` check of `check_repository_conventions.py` fails either ([martonpaulo/skill-deck#801](https://github.com/martonpaulo/skill-deck/issues/801)).
- Workflows: `validate.yml` (`Validate`). A workflow added outside the `bench-setup` skill's `references/ci-pipelines.md` is a recorded exception. A Node repository's `validate` script runs exactly what CI runs. Do not add an image-optimisation bot.
- The agent rules live in `AGENTS.md`, the one real file; `CLAUDE.md` is a symlink to it. Do not create `GEMINI.md`, `.gemini/rules/agents.md`, or any other alias, and never commit `.claude/settings.local.json`.
- Change the repository `homepage` only as the `bench-setup` skill's `references/github-settings.md` describes.

## Tests and validation

- Add or update focused tests for changed behavior, regressions, persistence, migrations, security, and critical accessibility, at stable seams.
- Every test, fixture, example and demo or default data holds synthetic data only: no real person's name, address, email, username or account, least of all the owner's. Person-shaped data comes from one shared list in the project, in its order; add a person there, never at the call site.
- With more than one gate, choose them with the gate selector (the `bench-setup` skill's `assets/gates.py`, rules in `gates.json`): it prints the gates the changed paths need, cheapest first, and every gate for a path no rule names; CI uses the same selector.
- Run the smallest check while iterating. Before each commit, run the full suite and repository validation when the full suite takes about 90 seconds or less; otherwise run the suites that cover a change or list its directory, let CI run the full suite, read its result before reporting done with the `bench-github-publishing` skill's `scripts/ci_result.py <sha>`, and require zero failures and zero warnings. Use a real integration only when local tests cannot prove the contract.
- When a change alters behavior, run the real application with its native diagnostics and observe the changed behavior. Green tests are not seeing it run.
- Before investigating or reporting a suspected defect, read `docs/answered-suspicions.md`; after measuring one that is not a defect, add its row there, as the `bench-setup` skill's `references/product-definition.md` defines.
- Report skips, blockers, residual risk, what was verified manually, and what remains unverified.
- A piped check reports the last command's status: `npm run lint | tail -3` exits 0 when lint fails. Run a gating check unpiped or with `set -o pipefail`. A check whose exit code you did not observe has not run.
- Local browser tests follow the `bench-setup` skill's `references/browser-test-harness.md`.
- Repository-wide rules live in one discovery-based checker that accepts `--root` and is tested over fixtures, never in scattered one-off scripts.
- The gate runs unchanged copies of the `bench-setup` skill's `assets/text_check.py` (no invisible character, every relative link and anchor resolves, a long `docs/` file opens with a Contents list) and, with shell suites, `assets/run_suites.sh` (an unknown command fails, GNU grep first, `VERBOSE=0|1` the one output switch); the `text-check` and `suite-runner` rules of `check_repository_conventions.py` check both ([martonpaulo/skill-deck#797](https://github.com/martonpaulo/skill-deck/issues/797)). In shell, no backslash escape in a `grep` pattern, no `$?` read after a pipeline, and no numeric compare of captured output before checking it is a number.
- With code, the gate runs an unchanged copy of the `bench-setup` skill's `assets/dry_check.py` over a root `dry-check.json`: no new magic value, repeated block, twin rule without an owner, or rule written in a second document; its counts only go down (`references/dry-checks.md`, the `dry-gate` rule, [martonpaulo/skill-deck#722](https://github.com/martonpaulo/skill-deck/issues/722)).

## Artifacts and processes

- Temporary is the default; retention is an explicit exception. Remove only temporary files the current task created, keeping deliverables and failure evidence, never pre-existing artifacts, fixtures, baselines, or logs, and never version caches, logs, coverage, or build output.
- Stop only processes the session started, never the user's pre-existing ones.

## Git and releases

- Follow the recorded branch, commit, push, and version policies; leave unrelated changes untouched.
- Use English Conventional Commits, one per concern: `feat: add the export button (#54)`.
- Before a commit, push, published text or release upload, apply `bench-github-publishing` section 2.
- If commit or push fails, report the exact failure.
- Under direct push to the default branch, a red default branch is fixed at once by a new commit, never left for later.
- Close a `completed` issue with the closing comment `bench-github-publishing` defines.
- Release or change a version only when the task and recorded policy authorize it, through `bench-release`.

## Completion report

Lead with the outcome, in the output shape, and include:

- what changed and why, and the files touched;
- validation commands and results, with warnings, skips, and remaining risks;
- what running the application verified, and what remains unverified;
- each change to the owner's real state, and its restore with the diff result;
- each issue closed, with the resolving commit its closing comment names;
- each issue opened in the run;
- temporary artifacts kept or removed, commit, branch, push, and worktree status.
