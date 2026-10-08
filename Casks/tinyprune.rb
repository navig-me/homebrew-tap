cask "tinyprune" do
  version "0.1.3"
  sha256 "1935c7c81ff562d95152a45fdf1e035a3cbd16b892a73d6b2c0f95f04a16e7e5"

  url "https://github.com/navig-me/tinyprune/releases/download/v0.1.3/TinyPrune-0.1.3-homebrew.dmg"
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
