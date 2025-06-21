class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/13caacf6fa886f82167eef662155cc8cd9c38cb8/bin/vl"
  sha256 "6aa1cd347791aa2453c383f1ce383557de3ce1489de74031bb46040def2ece8f"
  version "3.0.36"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 