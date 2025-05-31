class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/6e82ff175383ac4745b077984b02c3e08f66afd8/bin/vl"
  sha256 "a5b8ac6307e050bf81a7f60d552c78ca9dce5e8fe973078e997b0a48fcf3cbbc"
  version "3.0.31"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 