class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  license "MIT"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/subversivesoftwareorg/conscience/releases/download/v#{version}/conscience-macos-arm64"
      sha256 "95177945662c91a71f2f92b272c94533c80539db0260721c30106928711d589b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/subversivesoftwareorg/conscience/releases/download/v#{version}/conscience-linux-arm64"
      sha256 "905f5d4c26d20d7b9aea0ac81671d584a4cdd90ef69c1b8b46639cfb9c22c55f"
    end

    on_intel do
      url "https://github.com/subversivesoftwareorg/conscience/releases/download/v#{version}/conscience-linux-amd64"
      sha256 "658d44bef1c79c35a49c34f875e59cf95ca98732498d37c6a631d9bd6ead9f1d"
    end
  end

  def install
    if Hardware::CPU.intel? && OS.mac?
      odie "No prebuilt binary for macOS Intel. Install via: cargo install conscience"
    end
    bin.install Dir["conscience*"].first => "conscience"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/conscience --version")
  end
end
