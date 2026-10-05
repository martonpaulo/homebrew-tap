cask "leve" do
  version "0.2.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/martonpaulo/leve/releases/download/v#{version}/Leve-#{version}.dmg"
  name "Leve"
  desc "Menu bar clock that keeps today's next event in view"
  homepage "https://github.com/martonpaulo/leve"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "Leve.app"

  uninstall quit: "com.martonpaulo.leve"

  zap trash: [
    "~/Library/Caches/com.martonpaulo.leve",
    "~/Library/HTTPStorages/com.martonpaulo.leve",
    "~/Library/HTTPStorages/com.martonpaulo.leve.binarycookies",
    "~/Library/Preferences/com.martonpaulo.leve.plist",
  ]
end
