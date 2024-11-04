{pkgs, ...}: {
  # Requires Nvidia GPU
  environment.systemPackages = with pkgs; [
    (ollama.override {acceleration = "cuda";})
    nextjs-ollama-llm-ui
  ];
}
