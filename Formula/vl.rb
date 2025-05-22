class Vl < Formula
  desc "Command-line tool to display stock volume leaders without closing extra browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.17/bin/vl"
  sha256 "eba614ed55f1c3ae51b7ceea9f43d260c90e7a0108a6b34ea74823fb6eb39adb"
  version "3.0.17"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 