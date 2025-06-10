# nixos-config
![image](https://github.com/user-attachments/assets/47ab4a93-5842-42eb-a59e-6a4ad1e27831)

> [!WARNING]
> This config is **heavily** tailored to my needs and won't be as simple as just running it on your system. At some point in the future I do plan on revising the codebase and making it more modular and configurable.

The project structure is as follows:
- `hosts`: contains the separate configuration files for each of my own systems
- `modules`: contains home-manager modules (set by home or other system modules) and nixos modules (set in hosts config)
- `overlays`: custom overlays/additions to already existing packages
- `pkgs`: all custom package derivations

---
## Included Software
### AI
- Ollama 

### Browser
- Zen Browser

### CLI
- alacritty
- neofetch
- tmux
- wezterm

### Editor
- Neovim
- Nixvim
- VS Code

### UI
#### Window Managers 
- Hyprland
- Niri
#### Desktop Environments
- Cosmic
- KDE
- Gnome
- Wayfire
- Quickshell

### Misc
- ADB
- Discord
- Searxng
- Steam
- Syncthing

---

## Contributing
Contributions are always welcome. If you see something that looks off or have any suggests to improve the codebase, it would be very much appreciated. This repo will be constantly evolving and adapting to fit modern standards and any NixOS changes moving on.

## Acknowledgements
Massive thanks to all the resources provided by the NixOS community and the endless repositories providing a reference for me to learn and build off of. Some of the massive inspirations I used for building my own configuration are:
- [Aylur's dotfiles](https://github.com/Aylur/dotfiles)
- [fufexan's dotfiles](https://github.com/fufexan/dotfiles)
- [dacioromero's nix config](https://github.com/dacioromero/nix-config)
