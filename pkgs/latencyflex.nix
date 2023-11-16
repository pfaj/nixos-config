{ stdenv, fetchurl }:
let
  dxvk_nvapi_src = fetchurl {
    url = "https://github.com/jp7677/dxvk-nvapi/releases/download/v0.6.4/dxvk-nvapi-v0.6.4.tar.gz";
    sha256 = "0r6k62m3h2pvpymv13dsah70rz1pv3irzi1zdby46s39217zw2mb";
  };
in
stdenv.mkDerivation rec {
  name = "LatencyFleX";

  src = fetchurl {
    url = "https://github.com/ishitatsuyuki/LatencyFleX/releases/download/v0.1.1/latencyflex-v0.1.1.tar.xz";
    sha256 = "12p7a5lrprz29a2sadhmaz14rbls5mlwxzx6hi5ap69wyk9fp4n9";
  };

  dontBuild = true;

  unpackPhase = ''
    tar -xvf $src
    mv latencyflex-* latencyflex

    mkdir dxvk-nvapi
    tar -xzvf ${dxvk_nvapi_src} -C dxvk-nvapi
  '';

  installPhase = ''
    ### OLD METHOD, PROBABLY DIDNT WORK
    # Install the Vulkan layer files
    install -D latencyflex/layer/usr/lib/x86_64-linux-gnu/liblatencyflex_layer.so $out/lib/x86_64-linux-gnu/liblatencyflex_layer.so
    install -D latencyflex/layer/usr/share/vulkan/implicit_layer.d/latencyflex.json $out/share/vulkan/implicit_layer.d/latencyflex.json

    # Adjust the .json file to have the correct path
    substituteInPlace $out/share/vulkan/implicit_layer.d/latencyflex.json \
      --replace "/usr/lib/x86_64-linux-gnu/liblatencyflex_layer.so" "$out/lib/x86_64-linux-gnu/liblatencyflex_layer.so"

    # Install the Wine extension files
    install -D latencyflex/wine/usr/lib/wine/x86_64-unix/latencyflex_layer.so $out/lib/wine/x86_64-unix/latencyflex_layer.so
    install -D latencyflex/wine/usr/lib/wine/x86_64-windows/latencyflex_layer.dll $out/lib/wine/x86_64-windows/latencyflex_layer.dll
    install -D latencyflex/wine/usr/lib/wine/x86_64-windows/latencyflex_wine.dll $out/lib/wine/x86_64-windows/latencyflex_wine.dll

    # Install DXVK-NVAPI files
    install -D dxvk-nvapi/x64/nvapi64.dll $out/dist/lib64/wine/nvapi/nvapi64.dll
  '';

  meta = {
    description = "LatencyFleX Layer for Vulkan";
    homepage = "https://github.com/ishitatsuyuki/LatencyFleX";
  };
}
