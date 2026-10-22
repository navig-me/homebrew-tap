cask "tinyprune" do
  version "0.2.3"
  sha256 "b6e9fad585545129c0967bbb58df54d9c480069ae3b2b6f16bf80652694ede41"

  url "https://github.com/navig-me/tinyprune/releases/download/v0.2.3/TinyPrune-0.2.3-homebrew.dmg"
  name "TinyPrune"
  desc "Local-first lifecycle-rule tool"
  homepage "https://tinyprune.com/"

  # Explicit minimum-version expression retained for distribution policy.
  depends_on macos: ">= :sonoma"

  app "TinyPrune.app"
  binary "#{appdir}/TinyPrune.app/Contents/MacOS/tinyprune"

  postflight do
    ohai "Unsigned preview: not notarized. Clearing quarantine only for this trusted release."
    ohai "Finder extension and launch-at-login may need approval in System Settings."
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TinyPrune.app"]
  end

  uninstall launchctl: "com.navig-me.tinyprune.agent",
            quit:      "com.navig-me.tinyprune",
            script:    {
              executable: "/usr/bin/pluginkit",
              args:       ["-e", "ignore", "-i", "com.navig-me.tinyprune.finder"],
              sudo:       false,
            }

  zap trash: [
    "~/Library/Application Support/TinyPrune",
    "~/Library/Preferences/com.navig-me.tinyprune.finder.plist",
    "~/Library/Preferences/com.navig-me.tinyprune.plist",
  ]
end
