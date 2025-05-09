class Volumeleaders < Formula
  desc "Command-line tool to display stock volume leaders"
  homepage "https://github.com/donoage/vl"
  bottle do
    root_url "https://github.com/donoage/vl/releases/download/volumeleaders"
    sha256 cellar: :any_skip_relocation, monterey: "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    bin.install "volumeleaders"
  end

  test do
    system "#{bin}/volumeleaders", "--help"
  end
end 