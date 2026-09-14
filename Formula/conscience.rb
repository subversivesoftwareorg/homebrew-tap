class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work — measuring velocity, quality, and ethical implications"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.3.0/conscience-macos-arm64"
      sha256 "95177945662c91a71f2f92b272c94533c80539db0260721c30106928711d589b"
    end

    on_intel do
      # No prebuilt Intel binary — build from source
      url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v0.3.0.tar.gz"
      sha256 :no_check
      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.3.0/conscience-linux-arm64"
      sha256 "905f5d4c26d20d7b9aea0ac81671d584a4cdd90ef69c1b8b46639cfb9c22c55f"
    end

    on_intel do
      url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.3.0/conscience-linux-amd64"
      sha256 "658d44bef1c79c35a49c34f875e59cf95ca98732498d37c6a631d9bd6ead9f1d"
    end
  end

  def install
    if build.head? || File.exist?("Cargo.toml")
      # Source build (macOS Intel or --HEAD)
      system "cargo", "install", *std_cargo_args
    else
      bin.install Dir["conscience*"].first => "conscience"
    end
  end

  test do
    assert_match "conscience", shell_output("#{bin}/conscience --version")
  end
end
