class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.4.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.4.0/conscience-macos-arm64"
    sha256 "cf8e6b4aa8f94e6c34681fcd3bb5d6b5616e42bd2b85e8c8b17f1a558c749163"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.4.0/conscience-linux-arm64"
    sha256 "954c09f1bae47dc6b3de457170a3556c1cbd3e3d3c72602add3171465d87ca9f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.4.0/conscience-linux-amd64"
    sha256 "896e827d6220bfb7dbfd690f81e8902e04e711c3eef12486c60d63b49025c034"
  else
    url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v0.4.0.tar.gz"
    sha256 "e9af0557fdef1c009441c6f2d24722ababbad11e680afe1e4c56bb7560447eb5"
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
