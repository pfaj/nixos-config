{inputs, ...}: {
  # Requires Nvidia GPU
  environment.systemPackages = with inputs; [
    zen-browser.packages.x86_64-linux.default
  ];
}
