class Conscience < Formula
  desc "Evaluate the impact of AI-assisted work"
  homepage "https://github.com/subversivesoftwareorg/conscience"
  version "0.6.1"
  license "MIT"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.6.1/conscience-macos-arm64"
    sha256 "7e5eb4915a4816ade42c83a380cd572d23946e771659f8b2d087535ad961aa05"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.6.1/conscience-linux-arm64"
    sha256 "4cafa3923b94fa9a904227c490e0b2005f626098283948765e5464b4f69b3203"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/subversivesoftwareorg/conscience/releases/download/v0.6.1/conscience-linux-amd64"
    sha256 "a9b8d6b5524eb77553a9b6e102655660da4b51fa6b8b55b83197336045e630c8"
  else
    url "https://github.com/subversivesoftwareorg/conscience/archive/refs/tags/v0.6.1.tar.gz"
    sha256 "da84ed3414957bfb1cddc8ae4394cbedc7239d70a1ad30aa26cc4dc976696c4f"
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
