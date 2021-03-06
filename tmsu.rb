require "language/go"

class Tmsu < Formula
  desc "TMSU lets you tags your files and then access them through a nifty virtual filesystem from any other application."
  homepage "http://tmsu.org/"
  head "https://github.com/oniony/TMSU.git"

  depends_on "go" => :build
  depends_on "godep" => :build

  go_resource "github.com/mattn/go-sqlite3" do
    # url "https://github.com/mattn/go-sqlite3.git"
    url "https://github.com/faruzzy/go-sqlite3.git" # go 1.7 context patch
  end

  go_resource "github.com/hanwen/go-fuse" do
    url "https://github.com/hanwen/go-fuse.git"
  end
  
  go_resource "golang.org/x/crypto/blake2b" do
    #url "https://github.com/golang/crypto.git"
    url "golang.org/x/crypto/blake2b"
  end

  def install
    ENV["GOPATH"] = buildpath
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", "bin/tmsu", "github.com/oniony/TMSU"
    bin.install "bin/tmsu"
    man1.install "misc/man/tmsu.1"
  end
end
