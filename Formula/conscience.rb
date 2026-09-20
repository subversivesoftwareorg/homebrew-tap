class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.6.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.6.0/conscience-macos-arm64"
    sha256 "0bfea5f8beef52d69a60f3ba7a59829b59a43b4b2d8cc8cb90d714c0137e625e"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.6.0/conscience-linux-arm64"
    sha256 "39f25ae0c4d5dfe99cd582b61ed97c263b0b51bee061ea90e33449b2769cae3f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.6.0/conscience-linux-amd64"
    sha256 "88741795277aa08136ed23aa27978a15a2e2cb12f9f8ec50299c5f64b8d5eb46"
  else
    url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v0.6.0.tar.gz"
    sha256 "a0cff6094dbce4294fd664d7d51ff6cdfaf27c8504830302bbc62889236af4dd"
    depends_on "rust" => :build
  end

  def install
    if File.exist?("Cargo.toml")
      system "cargo", "install", *std_cargo_args
    else
      bin.install Dir["conscience*"].first => "conscience"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/conscience --version")
  end
end
