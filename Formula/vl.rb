class Vl < Formula
  desc "Command-line tool to display stock volume leaders (cross-platform)"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.10/bin/vl"
  sha256 "9185595f4d693cc5e1a7deca7ae3485ecb07f3597c68d39775111880925f1a34"
  version "3.0.10"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 