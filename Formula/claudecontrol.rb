class Claudecontrol < Formula
  desc "Menubar app surfacing the Claude desktop app's tasks across Chat/Cowork/Code"
  homepage "https://github.com/grothkopp/claudecontrol"
  url "https://github.com/grothkopp/claudecontrol/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4782c5d9348d7cbf18ea2b11990a2317971382553703cb0d6a6f2d064ed1e86c"
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
