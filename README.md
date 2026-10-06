# navig-me/homebrew-tap

Homebrew tap for [TinyPrune](https://github.com/navig-me/tinyprune), a local-first macOS app that gives files a lifetime and moves expired items to the Trash.

```sh
brew install --cask navig-me/tap/tinyprune
```

Early releases are unsigned, not notarized pre-releases. The cask clears quarantine for you and updates only with `brew upgrade --cask tinyprune`.
`brew uninstall --zap` also removes TinyPrune's local rules and settings; export your rules first.
