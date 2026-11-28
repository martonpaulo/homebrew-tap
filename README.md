# martonpaulo/tap

Install Marton Paulo's macOS apps, WindowHop and Leve, with one Homebrew command each, and remove each app and its settings with one more.

## WindowHop

Switch between windows, not just apps. A free, native macOS window switcher.
[Website](https://windowhop.martonpaulo.com/) · [Source](https://github.com/martonpaulo/windowhop)

```sh
brew install --cask martonpaulo/tap/windowhop
```

Requires an Apple silicon Mac with macOS 26 or later. After installing, open WindowHop
from Applications and allow Accessibility when it asks.

WindowHop updates itself (Sparkle), so `brew upgrade` is not needed; the cask is marked
`auto_updates`. To remove it and its settings:

```sh
brew uninstall --zap --cask windowhop
```

## Leve

Today's time and today's events at the edge of your attention, in the macOS menu bar.
[Source](https://github.com/martonpaulo/leve)

Not yet released: Leve has no published release, so it has no cask yet. This section gets
its install command, requirements and uninstall command when the first release is out.

## License

GPL-3.0-only, like WindowHop.
