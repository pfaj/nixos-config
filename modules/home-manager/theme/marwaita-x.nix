{ pkgs }:
pkgs.stdenv.mkDerivation {
    name = "marwaita-x";

    src = pkgs.fetchurl {
        url = "https://github.com/darkomarko42/Marwaita-X/archive/refs/tags/0.3.zip";
        sha256 = "02ryjwibamlw9sm0f5k6i2vi6v1dxj7imrrxwakj0jxyjjz2b98a";
    };

    dontUnpack = true;

    installPhase = ''
        mkdir -p $out/share/themes
        ${pkgs.unzip}/bin/unzip $src -d $out
        cp -R $out/Marwaita-X-0.3/* "$out/share/themes/"
    '';
}
