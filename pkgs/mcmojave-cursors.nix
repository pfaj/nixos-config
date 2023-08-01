{
    stdenv,
    fetchFromGitHub,
}:
stdenv.mkDerivation {
    name = "mcmojave-cursors";

    src = fetchFromGitHub {
        owner = "vinceliuice";
        repo = "McMojave-cursors";
        rev = "7d0bfc1f91028191cdc220b87fd335a235ee4439";
        sha256 = "0p8r7rpkgxa4jyv8mxkwyj04z93wr4w00nlzp3nbh0virawr52p1";
    };

    installPhase = ''
        mkdir -p $out
        cp -R ./dist $out/
    '';
}
