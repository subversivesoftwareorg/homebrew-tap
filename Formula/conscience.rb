class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.3.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v#{version}/conscience-macos-arm64"
    sha256 "95177945662c91a71f2f92b272c94533c80539db0260721c30106928711d589b"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v#{version}/conscience-linux-arm64"
    sha256 "905f5d4c26d20d7b9aea0ac81671d584a4cdd90ef69c1b8b46639cfb9c22c55f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v#{version}/conscience-linux-amd64"
    sha256 "658d44bef1c79c35a49c34f875e59cf95ca98732498d37c6a631d9bd6ead9f1d"
  else
    url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v#{version}.tar.gz"
    sha256 "3f426b290afbe25de79505040b96e4fcda9ad6f593db79f7af7d026ea1b126f0"
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
