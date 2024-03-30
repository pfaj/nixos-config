# nixos-config
![image](https://github.com/bdebiase/nixos-config/assets/66143154/d3539dc3-a8d1-45b3-a2c5-901a1fcea198)

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
