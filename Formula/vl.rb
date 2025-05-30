class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/84a5314e070b37e238497066a3a8f60cfc62d257/bin/vl"
  sha256 "af640c224eacac9897f7cddb8d1cce2958387ea4096e7aa69cb224ce934a6da2"
  version "3.0.30"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 