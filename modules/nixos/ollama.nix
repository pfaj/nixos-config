{pkgs, ...}: {
  # Requires Nvidia GPU
  environment.systemPackages = with pkgs; [
    (ollama.override {acceleration = "cuda";})
  ];
}
