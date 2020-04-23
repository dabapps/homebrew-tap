class Crab < Formula
  include Language::Python::Virtualenv

  desc "Crab"
  homepage "https://github.com/dabapps/crab"
  url "https://github.com/dabapps/crab/archive/v0.1.2.tar.gz"
  sha256 "4e6f51d7f530dc1ae195e2b3f94e130a1fa803e96d2ca40ba6b1d83193e6ca67"
  head "https://github.com/dabapps/crab.git"

  depends_on "python@3"

  def install
    venv  = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "crabtools"
    venv.pip_install_and_link buildpath
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/crab</string>
          <string>router</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/crab.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/crab.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    assert_match "crab v#{version}", shell_output("#{bin}/crab --version")
    assert_match "crab v#{version}", shell_output("#{bin}/crab")
  end
end
