{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "auto-cpufreq";
  src = pkgs.fetchFromGitHub {
    owner = "AdnanHodzic";
    repo = "auto-cpufreq";
    rev = "master";
    sha256 = "0v3k4k0g2lg7wpj8dgr7v8s2h8j9p2f9vj1nkl5s0fz0l8f8r7yq";
  };
  buildInputs = [pkgs.python3 pkgs.git];
  buildPhase = ''
    cd $src
    sudo ./auto-cpufreq-installer
  '';
}
