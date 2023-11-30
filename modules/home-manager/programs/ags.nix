{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.ags.packages.${pkgs.system}.default
  ];
}
