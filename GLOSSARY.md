# Glossary

| Term | Definition | Do not write |
| :--- | :--- | :--- |
| Tap | This repository as Homebrew sees it, `martonpaulo/tap`: a third-party source of casks. | repo, formula repository |
| Cask | One Ruby file in `Casks/` that tells Homebrew how to install one app from its disk image. | formula, recipe, package |
| Cask token | The lowercase name a user types, such as `windowhop`; it is also the file name. | cask name, app id |
| Zap | The `zap trash:` stanza, run by `brew uninstall --zap`, which also removes the app's settings and caches. | purge, deep clean |
| Bump | A commit that moves one cask to a newer published release: `version` and `sha256` only. | update, upgrade |
