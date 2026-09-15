class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.5.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.5.1/conscience-macos-arm64"
    sha256 "f2e146f10041b072709b28cc3ff206322683eb102789ae0390c3d12957b28181"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.5.1/conscience-linux-arm64"
    sha256 "9497df374ae99e68db6b14205bd44df94a2b69c434f1675c1e6954b5ad567bf7"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.5.1/conscience-linux-amd64"
    sha256 "e23eadecc34b3e2c65d0403b79669df50fa5102070ac5d3c882786138a05b136"
  else
    url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v0.5.1.tar.gz"
    sha256 "fe403e45cc88be6f870f76cbcf860a4927df43c89cca38b485e42cb0cd6758bb"
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
