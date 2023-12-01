{ inputs
, pkgs
, ...
}: {
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    sassc
    swww
    brightnessctl

    hyprpicker
    slurp
    wf-recorder
    wayshot
    imagemagick
    wl-gammactl
    pavucontrol
    swappy
    (python311.withPackages(p: [ p.python-pam ]))
  ];

  programs.ags = {
    enable = true;
    extraPackages = [ pkgs.libsoup_3 ];
  };
}
