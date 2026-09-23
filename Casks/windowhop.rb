cask "windowhop" do
  version "2.3.2"
  sha256 "8e9af15b112b2f2c08b24c46d9229e56fdf6e4b8ea04323a1fc800c0f6892813"

  url "https://github.com/martonpaulo/windowhop/releases/download/v#{version}/WindowHop-#{version}.dmg"
  name "WindowHop"
  desc "Window switcher that gives every window its own tile"
  homepage "https://windowhop.martonpaulo.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "WindowHop.app"

  uninstall quit: "com.martonpaulo.windowhop"

  zap trash: [
    "~/Library/Caches/com.martonpaulo.windowhop",
    "~/Library/Caches/com.perso.windowhop",
    "~/Library/HTTPStorages/com.martonpaulo.windowhop",
    "~/Library/HTTPStorages/com.martonpaulo.windowhop.binarycookies",
    "~/Library/HTTPStorages/com.perso.windowhop",
    "~/Library/HTTPStorages/com.perso.windowhop.binarycookies",
    "~/Library/Preferences/com.martonpaulo.windowhop.plist",
    "~/Library/Preferences/com.perso.windowhop.plist",
  ]
end
