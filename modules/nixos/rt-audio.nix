{inputs, ...}:{
  imports = [
    inputs.musnix.nixosModules.musnix
  ];
  environment.etc = {
    "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
      context.properties = {
        default.clock.rate = 44100
        default.clock.quantum = 512
        default.clock.min-quantum = 512
        default.clock.max-quantum = 512
      }
    '';
  };

  musnix.enable = true;
}
