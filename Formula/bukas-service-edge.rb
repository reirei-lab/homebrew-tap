class BukasServiceEdge < Formula
  desc "Bukas agent service (edge channel)"
  homepage "https://github.com/reirei-lab/bukas-releases"
  url "https://github.com/reirei-lab/bukas-releases/releases/download/edge-20261017.085011.2-613f2b72baf8/bukas-service-edge-20261017.085011.2-613f2b72baf8-macos-arm64.zip"
  version "20261017.085011.2"
  sha256 "6afa14137409c0201c66b2ae0e22a0d8a3e3104b2123967f0b78b1f76ffd607d"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  conflicts_with "bukas-service", because: "both channels manage the same service and data"

  def install
    bin.install "bukas-service"
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
    assert_match "20261017.085011.2", shell_output("#{bin}/bukas-service --version")
  end
end
