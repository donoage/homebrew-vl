class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/18e4adb21e7d8062c2796ee0cc287fd72e304765/bin/vl"
  sha256 "5cff1b449c777105099a4abe3c3a5cceb48c4e28f134d1378d36d89b818b673b"
  version "3.0.45"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 