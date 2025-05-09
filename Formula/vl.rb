class Vl < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/homebrew-vl"
  url "https://raw.githubusercontent.com/donoage/homebrew-vl/v1.0.2/bin/vl"
  sha256 "b9ae713c176e4fe388c11ec25998758bd9ab813498e920eda090f27840779666"
  version "1.0.3"

  def install
    bin.install "vl"
    system "chmod", "+x", "#{bin}/vl"
  end

  test do
    system "#{bin}/vl", "--help"
  end
end 