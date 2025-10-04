class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/b206f57e0f5ac1febfb5578272b15efedd84aea5/bin/vl"
  sha256 "aa1dbd01913fd11f794701dccbf4cd48d12947e3c4fd050ac972cebc0837181d"
  version "3.0.42"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 