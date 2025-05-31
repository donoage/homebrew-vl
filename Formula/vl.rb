class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/5269d32781fadbcaaafc415995363ef49d82a075/bin/vl"
  sha256 "771857212d1097c09ef0ec1d6aa666cfb9fce209ecda6be36d454f4c429767ff"
  version "3.0.33"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 