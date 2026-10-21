class BukasServiceEdge < Formula
  desc "Bukas agent service (edge channel)"
  homepage "https://github.com/reirei-lab/bukas-releases"
  url "https://github.com/reirei-lab/bukas-releases/releases/download/edge-20261021.042417.23-2da0a85e0be6/bukas-service-edge-20261021.042417.23-2da0a85e0be6-macos-arm64.zip"
  version "20261021.042417.23"
  sha256 "4131fa9046bd9ecc1caddbc815fad07c49e84f61f66a1c973ed81671797cd96a"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  conflicts_with "bukas-service", because: "both channels manage the same service and data"

  def install
    bin.install "bukas-service"
    libexec.install "bukas-updater" => "BukasUpdater"
    pkgshare.install "manifest.json"
  end

  def caveats
    <<~EOS
      Install Codex CLI separately and run codex login, then:
        bukas-service setup
        brew services start bukas-service-edge
      Stop the service before upgrading; running tasks will be interrupted.
      Configuration and conversation data survive uninstall.
    EOS
  end

  service do
    run [opt_bin/"bukas-service", "serve", "--config", "~/.config/bukas/service.json"]
    working_dir Dir.home
    environment_variables PATH: std_service_path_env
    log_path var/"log/bukas-service.log"
    error_log_path var/"log/bukas-service-error.log"
  end

  test do
    assert_match "20261021.042417.23", shell_output("#{bin}/bukas-service --version")
  end
end
