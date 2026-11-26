# Contributing to martonpaulo/tap

This tap holds casks for Marton Paulo's own apps only. A cask for another app is out of scope.

## Quick Start

Homebrew and Python 3 on an Apple silicon Mac.

```bash
git clone https://github.com/martonpaulo/homebrew-tap.git && cd homebrew-tap && make check
```

## Commands

| Command | What it does |
| :--- | :--- |
| `make check` | Runs every check below; the gate before every commit, and what `Validate` runs. |
| `make style` | Runs `brew style` on every cask in `Casks/`. |
| `make text` | Checks the Markdown: invisible characters, relative links and anchors, issue references as links. |
| `make dry` | Runs the DRY check over `dry-check.json`; its counts only go down. |
| `brew audit --cask --online martonpaulo/tap/<slug>` | Compares a published cask with its app's latest release. Run it after a push. |

## Changing a cask

A cask's `version` and `sha256` change only to a release the app has already published, and the
`sha256` is the digest GitHub shows for that disk image. A problem with an app itself belongs in that
app's repository, linked from its README section.
