class Claudecontrol < Formula
  desc "Menubar app surfacing the Claude desktop app's tasks across Chat/Cowork/Code"
  homepage "https://github.com/grothkopp/claudecontrol"
  url "https://github.com/grothkopp/claudecontrol/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "bad58df2fab5e157578a2c81dd41331aa0564d08144b4be1ffe7b9af23701543"
  license "MIT"

  depends_on "uv"
  depends_on :macos

  def install
    libexec.install "claudebar.py", "claude-state.js", "claude-focus.js"
    (bin/"claudecontrol").write <<~SH
      #!/bin/bash
      exec uv run --quiet "#{libexec}/claudebar.py" "$@"
    SH
  end

  def caveats
    <<~EOS
      Start the menubar app:      claudecontrol
      Grant Accessibility access: System Settings -> Privacy & Security -> Accessibility
      Unofficial - not affiliated with Anthropic.
    EOS
  end

  test do
    assert_path_exists libexec/"claudebar.py"
  end
end
