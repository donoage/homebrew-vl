class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/818b9b594a3a9513783622306e25a21d3f15def5/bin/vl"
  sha256 "661a3537c2e7cc882401cf3c45e2cdd198ce5ff63a746a06be5ac998ea2157d9"
  version "3.0.47"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 