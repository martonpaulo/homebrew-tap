# martonpaulo/tap

Homebrew casks for apps by Marton Paulo.

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

## License

GPL-3.0-only, like WindowHop.
