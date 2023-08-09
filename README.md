**⚠️WARNING⚠️**

**This configuration is VERY incomplete. Most usual desktop features flat out don't work yet or may never work.**

# nix-config
The configuration for my personal NixOS setup.

![image](https://github.com/bdebiase/nix-config/assets/66143154/211b1496-efc2-486c-b6c9-2acf9aebd84f)

The project structure is as follows:
- `hosts`: contains the separate system-level configuration files for each of my own systems
- `modules`: contains home-manager modules (set by home or other modules) and nixos modules (set in hosts config)
- `overlays`: not even sure how it works but kinda self-explanatory
- `pkgs`: all custom package derivations
- `users`: contains only a single user for now, where the home resides
