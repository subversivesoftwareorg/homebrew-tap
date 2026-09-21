class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.7.0"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.7.0/conscience-macos-arm64"
    sha256 "1bcd167793c09e1f2c2765cf2fd09c5e384d79bb8e5fccef304decdc087e6a51"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.7.0/conscience-linux-arm64"
    sha256 "93554bd86f0422bfc208ac6ca94993a12db717bb6a4948d2c6d49cf5db474e0c"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.7.0/conscience-linux-amd64"
    sha256 "5d62b906243b119ed79d2f09aa244734acaa93ba7abf8373ebd0f3ef44e42a50"
  else
    url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v0.7.0.tar.gz"
    sha256 "c03660e2b35760f5a0d516b5eed3efb0aff5e8d521f0978f844211d2c3be3245"
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
