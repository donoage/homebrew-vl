class Volumeleaders < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v1.0.0/bin/volumeleaders"
  sha256 "bb7026a769375a5110b11f1634ab8d18761bc8ab7b81c27c7d52cc8a4d19d6fd"
  version "1.0.0"

  def install
    bin.install "volumeleaders"
    system "chmod", "+x", "#{bin}/volumeleaders"
  end

  test do
    system "#{bin}/volumeleaders", "--help"
  end
end 