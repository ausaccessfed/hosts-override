class HostsOverride < Formula
  desc "Override hosts file entries for the lifetime of the process"
  homepage "https://github.com/ausaccessfed/hosts-override"
  url "https://github.com/ausaccessfed/hosts-override.git",
      :tag      => "0.7",
      :revision => "5fbf66021cf1f86f21abb47b8d3f3c2179211c79"
  head "https://github.com/ausaccessfed/hosts-override.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = "amd64"
    path = buildpath/"src/github.com/ausaccessfed/hosts-override"

    (path).install buildpath.children

    cd path do
      system "go", "build", "-o", "hosts-override", "."
      bin.install "hosts-override"
    end
  end

  test do
    system "#{bin}/hosts-override", "-h"
  end
end
