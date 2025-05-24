class Vl < Formula
  desc "Command-line tool to display stock volume leaders without closing extra browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v3.0.18/bin/vl"
  sha256 "001f657eb20507e453683a3973b3ba7a7df931c04a702afa803eb1bd3bb28541"
  version "3.0.18"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 