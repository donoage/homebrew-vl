class VlTrades < Formula
  desc "Command-line tool to display VolumeLeaders trade analysis URLs in positioned browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/main/bin/vl-trades"
  sha256 "placeholder_sha256_will_be_updated"
  version "1.0.0"
  
  depends_on "python@3"

  def install
    bin.install "vl-trades"
    system "chmod", "+x", "#{bin}/vl-trades"
  end

  test do
    assert_match "Usage: vl-trades", shell_output("#{bin}/vl-trades --help 2>&1", 1)
  end
end 