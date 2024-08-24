services.fprintd = {
  enable = true;
  package = pkgs.fprintd-tod;
  tod = {
    enable = true;
    driver = pkgs.libfprint-2-tod1-vfs0090;
  };
};
