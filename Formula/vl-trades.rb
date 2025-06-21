class VlTrades < Formula
  desc "Command-line tool to display VolumeLeaders trade analysis URLs in positioned browser windows"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/13caacf6fa886f82167eef662155cc8cd9c38cb8/bin/vl-trades"
  sha256 "c8481d80715c018b2bee85b268332ad6d4d3327f612c7d406e475c8b05fea401"
  version "1.0.1"
  
  depends_on "python@3"

  def install
    bin.install "vl-trades"
    system "chmod", "+x", "#{bin}/vl-trades"
  end

  test do
    assert_match "Usage: vl-trades", shell_output("#{bin}/vl-trades --help 2>&1", 1)
  end
end 