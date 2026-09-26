class AgentHpServer < Formula
  desc "Serve Codex usage data to the AgentHP iPhone app and widgets"
  homepage "https://github.com/reirei-lab/agent-hp-server"
  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/reirei-lab/agent-hp-server/releases/download/v0.1.0/agent-hp-server-macos-arm64-v0.1.0.zip"
    sha256 "8be27b59eec2e8ab2e692305250c0f70bc5e1fd87006b9db3a1adfcd3954b96d"
  else
    url "https://github.com/reirei-lab/agent-hp-server/releases/download/v0.1.0/agent-hp-server-macos-x64-v0.1.0.zip"
    sha256 "2045ec75147fbf278c136bfc87a0e1f34415fdedca05342f6191e3680f2b8538"
  end

  def install
    bin.install Dir["agent-hp-server-macos-*"].fetch(0) => "agent-hp-server"
  end

  test do
    assert_predicate bin/"agent-hp-server", :executable?
  end
end
