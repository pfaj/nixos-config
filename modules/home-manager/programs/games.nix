{pkgs, ...}: {
  home.packages = with pkgs; [
    lunar-client
    prismlauncher
    protonup-qt
  ];
}
