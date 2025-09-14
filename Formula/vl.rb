class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/13caacf6fa886f82167eef662155cc8cd9c38cb8/bin/vl"
  sha256 "1033504f468f96d947989ab2ef4ffaa0674131067cb5543db73c1f670ae2387d"
  version "3.0.38"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 