class Vl < Formula
  desc "Command-line tool to display stock volume leaders without closing extra browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.19/bin/vl"
  sha256 "c87c6caa282dc535075911d34b2c8dafedaa83fd0c9f4897cea0b2b3ac9c08f8"
  version "3.0.19"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 