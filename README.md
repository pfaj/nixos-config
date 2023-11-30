> [!WARNING]
> This configuration is VERY incomplete. Most usual desktop features flat out don't work yet or may never work.

# nix-config
The configuration for my personal NixOS setup.
![image](https://github.com/bdebiase/nix-config/assets/66143154/3d76fe92-f50e-4b7e-84d2-b89a0ff4807b)

The project structure is as follows:
- `hosts`: contains the separate configuration files for each of my own systems
- `modules`: contains home-manager modules (set by home or other system modules) and nixos modules (set in hosts config)
- `overlays`: custom overlays/additions to already existing packages
- `pkgs`: all custom package derivations

## Contributing
Contributions are always welcome. If you see something that looks off or have any suggests to improve the codebase, it would be very much appreciated. This repo will be constantly evolving and adapting to fit modern standards and any NixOS changes moving on.

## Acknowledgements
Massive thanks to all the resources provided by the NixOS community and the endless repositories providing a reference for me to learn and build off of. Some of the massive inspirations I used for building my own configuration are:
- [Aylur's dotfiles](https://github.com/Aylur/dotfiles)
- [fufexan's dotfiles](https://github.com/fufexan/dotfiles)
- [dacioromero's nix config](https://github.com/dacioromero/nix-config)
