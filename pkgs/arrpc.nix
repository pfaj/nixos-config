{
    bash,
    buildNpmPackage,
    fetchFromGitHub,
    nodejs,
}:
buildNpmPackage rec {
    name = "arrpc";

    src = fetchFromGitHub {
        owner = "OpenAsar";
        repo = "arrpc";
        rev = "ec5ed0acb1995c1588c49cd7c86376029a5f0ced";
        sha256 = "1z3x8kc29hyqyqwpq3d2b0zzmsaljzg24kaq9qnl7ycmvc9v8bp6";
    };

    npmDepsHash = "sha256-vxx0w6UjwxIK4cgpivtjNbIgkb4wKG4ijSHdP/FeQZ4=";

    buildPhase = ''
        npm install
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp -r . $out/
        echo "#!${bash}/bin/bash" > $out/bin/start-arrpc
        echo "cd $out && node src" >> $out/bin/start-arrpc
        chmod +x $out/bin/start-arrpc
    '';
}
