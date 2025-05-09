class Vl < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v1.0.2/bin/vl"
  sha256 "afb5c74ab993e2f8fb8190dcf76ba71c7e18fd84c5ee6080864d1f081114940b"
  version "1.0.2"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    system "#{bin}/vl", "--help"
  end
end 