class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/5ce11844ec8b2bcd7e64df6c7eb27bb76d8251d5/bin/vl"
  sha256 "dfcbc9a2d21c32ef7456a9b2b189dc8ac396692a7cf085429116e1aa62df3e0e"
  version "3.0.37"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 