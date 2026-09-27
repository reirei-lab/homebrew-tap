class AgentHpServer < Formula
  desc "Serve Codex usage data to the AgentHP iPhone app and widgets"
  homepage "https://github.com/reirei-lab/agent-hp-server"
  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/reirei-lab/agent-hp-server/releases/download/v0.2.0/agent-hp-server-macos-arm64-v0.2.0.zip"
    sha256 "ef85b7da61a2eeefdc98fae0eae02a6da8e632623160e48cea70f8e015390c1a"
  else
    url "https://github.com/reirei-lab/agent-hp-server/releases/download/v0.2.0/agent-hp-server-macos-x64-v0.2.0.zip"
    sha256 "72ec0bc4d29345e92b558afa6a21c8046225e20ea289fc26498f9eb14195bd79"
  end

  def install
    bin.install Dir["agent-hp-server-macos-*"].fetch(0) => "agent-hp-server"
  end

  service do
    run opt_bin/"agent-hp-server"
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/agent-hp-server.log"
    error_log_path var/"log/agent-hp-server-error.log"
  end

  test do
    assert_predicate bin/"agent-hp-server", :executable?
  end
end
