class Vl < Formula
  desc "Command-line tool to display stock volume leaders without closing extra browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.20/bin/vl"
  sha256 "8e508fe6bbae995d8378e4fc92045f8f8d8b847e2909649b3985aae64bfdb103"
  version "3.0.20"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 