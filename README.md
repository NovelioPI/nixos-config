# Welcome to nixos-config! 🌟

This is my personal home for all things NixOS, and I'm happy to share it with you. I've spent a lot of time tweaking and refining this setup to make it feel just right. My goal is to make this a friendly, easy-to-use starting point for anyone who wants a reliable and beautiful system without all the headache.

Feel free to explore, use what you like, and make it your own!

## Features

- **NixOS Flakes**: Modern way to manage dependencies and reproducibility.
- **Modular Structure**: Organized into `hosts`, `features`, and `parts`.
- **Easy Setup**: Includes a `setup.sh` script to automate initial configuration.
- **Desktop Environments**: Predominantly GNOME support.
- **Modular Infrastructure**: Powered by `flake-parts` and `import-tree` for a clean and scalable structure.
- **Nix-Wrapper-Modules**: Integration for wrapping modules and applications.
- **Rich Toolset**: Common CLI tools, development environments, and gaming optimizations included.

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/noveliopi/nixos-config.git
   cd nixos-config
   ```

2. **Run the setup script**:
   ```bash
   ./setup.sh
   ```
   Follow the prompts to configure your username, hostname, timezone, locale, and GPU type. This will generate a `vars.nix` file.

3. **Check your hardware configuration**:
   Verify the disk UUIDs and kernel modules in `modules/hosts/pc/hardware.nix`. If you are installing on a new machine, you should generate your own hardware configuration:
   ```bash
   nixos-generate-config --no-filesystems --show-hardware-config > modules/hosts/pc/hardware.nix
   ```

4. **Build and switch**:
   ```bash
   sudo nixos-rebuild switch --flake .#pc
   ```

## What Can You Edit?

### User-Specific Variables (`vars.nix`)
The `setup.sh` script generates this file. You can manually edit it to change:
- `username`: Your system login name.
- `fullName`: Your display name.
- `hostname`: The name of your machine.
- `timezone`: System timezone (e.g., `Asia/Jakarta`).
- `locale`: System locale (e.g., `en_US.UTF-8`).
- `vgaType`: GPU driver (`amdgpu`, `nvidia`, `intel`).

### System Features (`modules/features/`)
Enabled features are imported in `modules/hosts/pc/configuration.nix`. You can enable or disable them by commenting/uncommenting the imports:
- `cli.nix`: Command-line tools (neovim, git, etc.).
- `dev.nix`: Development environments (docker, compilers, etc.).
- `gaming.nix`: Steam, Gamemode, and other gaming optimizations.
- `apps.nix`: Common GUI applications.
- `vpn.nix`: VPN and networking configurations.

### Hardware-Specifics (`modules/hosts/pc/hardware.nix`)
Edit this for:
- Disk UUIDs and mount points.
- Kernel modules and boot parameters.
- CPU specific settings (AMD/Intel microcode).

## Resources for Learning

- **[NixOS Official Documentation](https://nixos.org/learn.html)**: Start here for basics.
- **[NixOS Wiki](https://nixos.wiki/)**: A community-driven wiki with lots of practical examples.
- **[Zero to Nix](https://zero-to-nix.com/)**: A great guide for beginners to understand flakes and the Nix ecosystem.
- **[MyNixOS](https://mynixos.com/)**: Search for NixOS options and packages easily.
- **[Flake Parts Documentation](https://flake.parts/)**: Understand how the modular structure works in this project.
- **[Nix-Wrapper-Modules](https://github.com/BirdeeHub/nix-wrapper-modules)**: A powerful utility for wrapping NixOS modules and managing complex configurations.

## Credits

Created by [NovelioPI](https://github.com/noveliopi).
