# Product definition

## What it is

A Homebrew tap, `martonpaulo/tap`, that installs Marton Paulo's macOS apps with one command each.

## Who it is for

A person with an Apple silicon Mac who manages apps with Homebrew and wants WindowHop or Leve
installed, and later removed, the same way as the rest of their apps.

## The job

Install an app from its latest published release with `brew install --cask martonpaulo/tap/<slug>`,
and remove it with its settings with `brew uninstall --zap --cask <slug>`. Without the tap, the
person downloads the disk image from the app's release page and drags the app by hand.

## What it does

- One cask per app in `Casks/`, pointing at the disk image the app's own release publishes.
- One README section per app, with the install and the `--zap` uninstall commands.
- Each app updates itself with Sparkle, so each cask is `auto_updates` and `brew upgrade` is not
  needed.

## What it will never do

| Non-goal | Reason | Reopened when |
| :--- | :--- | :--- |
| Casks or formulae for apps by other people | The tap distributes the owner's apps only. | Never, by the owner's choice. |
| Build or host an app's binary | Each app's own `release.yml` builds, signs and publishes it; the tap only points at the published asset. | Never: a second build path would ship a binary nobody verified. |
| Submit the casks to `homebrew/cask` instead | `homebrew/cask` refuses young projects on notability (30 forks, 30 watchers or 75 stars). | An app passes that notability bar. |

## How you know it worked

For each cask, `brew style` and `brew audit --cask --online martonpaulo/tap/<slug>` pass, and its
`url` and `sha256` name a disk image that the app's GitHub release really publishes.

## Constraints

- The repository is public: Homebrew clones it for every user who taps it.
- A cask's `sha256` is the digest GitHub recorded for the published release asset, never a checksum
  of a local build.
- Apple silicon only; each cask's minimum macOS follows its app's `LSMinimumSystemVersion`.

## Accepted evidence gaps

- Accessibility: the tap has no interface of its own. Its only surface is the README, so the
  Markdown itself is the evidence, reviewed in each change.

## Alternatives considered

The new-project gate did not run: the tap existed before this definition (2026-11-26). The only
alternative, `homebrew/cask`, is the non-goal above.
