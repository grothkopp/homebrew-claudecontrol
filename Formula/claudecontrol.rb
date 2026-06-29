class Claudecontrol < Formula
  desc "Menubar app surfacing the Claude desktop app's tasks across Chat/Cowork/Code"
  homepage "https://github.com/grothkopp/claudecontrol"
  url "https://github.com/grothkopp/claudecontrol/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a53ee2165afedbc44b17dd4c1e4605ad7dae1dc12a00d566a6481cb4546a5600"
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
