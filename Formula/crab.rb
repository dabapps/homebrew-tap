class Crab < Formula
  include Language::Python::Virtualenv

  desc "Crab"
  homepage "https://github.com/dabapps/crab"
  url "https://github.com/dabapps/crab/archive/v0.1.5.tar.gz"
  sha256 "fdac36fe63a0a822e44c14dbd08e7b64106317fadeb31239531491772a0b36bc"
  head "https://github.com/dabapps/crab.git"

  depends_on "python@3.11"

  def install
    venv  = virtualenv_create(libexec, "python3", without_pip: false)
    system libexec/"bin/pip", "install", buildpath
    system libexec/"bin/pip", "uninstall", "-y", "crabtools"
    venv.pip_install_and_link buildpath
  end

  service do
    run [bin/"crab", "router"]
    keep_alive true
    working_dir HOMEBREW_PREFIX
    log_path var/"log/crab.log"
    error_log_path var/"log/crab.log"
  end

  test do
    assert_match "crab v#{version}", shell_output("#{bin}/crab --version")
    assert_match "crab v#{version}", shell_output("#{bin}/crab")
  end
end
