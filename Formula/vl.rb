class Vl < Formula
  desc "Command-line tool to display stock volume leaders and index charts"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/be40897e413731e56d76d7a8cf65e70685aaa95c/bin/vl"
  sha256 "821ac9016f316b4c98c64a9537a4e10fe736903b0c20fe4e90b0ec896fc3e736"
  version "3.0.41"
  
  depends_on "python@3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    assert_match "Usage: vl TICKER", shell_output("#{bin}/vl 2>&1", 1)
  end
end 