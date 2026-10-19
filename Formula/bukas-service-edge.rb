class BukasServiceEdge < Formula
  desc "Bukas agent service (edge channel)"
  homepage "https://github.com/reirei-lab/bukas-releases"
  url "https://github.com/reirei-lab/bukas-releases/releases/download/edge-20261019.092824.19-ae50463f22a3/bukas-service-edge-20261019.092824.19-ae50463f22a3-macos-arm64.zip"
  version "20261019.092824.19"
  sha256 "1bb5eccdb832a40530d465bc1366b7c21bdcc46a23a637a2a5b90a1f63e0b34d"

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
    assert_match "20261019.092824.19", shell_output("#{bin}/bukas-service --version")
  end
end
