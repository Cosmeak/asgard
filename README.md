<div align="center">
  <h1> Asgard </h1>
</div>

This configuration is under constant construction so some things may be remove or add accordings to my needs but i want to keep all even if it's not used anymore.

> [!CAUTION]
> This configuration is make for my purpose, you can take inspiration and some configuration but do not expect it to work on your side.🙂
> Any damage caused by this configuration is not my responsibility. Use at your own risk.

## ✨️ - Features

- [x] NixOS
- [x] Nix Darwin
- [ ] Nix BSD
- [ ] WSL
- [ ] Homelab with MicroVM
- [x] Multi flavor for DE / WM
- [ ] Secrets management
- [ ] Multiple nixpkgs channel
- [ ] Dotfiles managing
- [ ] Custom live ISO
- [ ] Auto-updating flakes
- [ ] Encrypted disks
- [ ] Secure Boot


## 💻 - Hosts

| Hostname | CPU               | GPU            | RAM  | OS                    | Usage   | Status   | 
| :------: | :---------------: | :------------: | :--: | :-------------------: | :-----: | :------: |
| njord    | Apple M2 Chip     | Apple M2 Chip  | 32Go | MacOS                 | ⌨️      | 🟢️       |
| loki     | Intel i5 13600kf  | Nvidia 4070ti  | 32Go | NixOS                 | 🎮️      | 🟢️       |
| hvedrung | Intel i5 13600kf  | Nvidia 4070ti  | 32Go | FreeBSD (with nixbsd) | 🧨️      | 🔴️       |
| beowulf  |                   |                |      | NixOS                 | ☁️      | 🔴️       |
| nyx      | AMD Ryzen 3 3300X | Nvidia 1060    | 16GO | NixOS                 | 🎮️ / ⌨️ | 🟢️       |

🎮️ : Gaming
☁️ : Server
⌨️ : Development
🧨️ : Testing purpose

> [!NOTE]
> hvedrung host is the same desktop as loki, just another SSD used or is used inside a VM.

> [!NOTE]
> The i5 is the worst CPU i've got, so much problem with stability and other things, some patch applied can be link for it stability.

## 📦 - Structure

```
.
├── homes        # User home configuration (Not Home manager, just sim)
│   └── cosmeak      # Personal folders for dotfiles
├── hosts        # Host-specific configuration
│   ├── njord        # MacOS development laptop
│   ├── loki         # Nixos gaming desktop
│   └── hvedrung     # FreeBSD (only for testing purpose of nixbsd)
└── modules      # macOS and nix-darwin, NixOS, and shared configuration
    ├── shared       # Shared modules across all platforms
    ├── nixos        # Nixos modules
    ├── darwin       # MacOS modules
    └── bsd          # FreeBSD modules
```

## 💡 - Acknowledgments

These are the things that help me the most to understand Nix ecosystem and help me build my configuration from scratch.

- [elythh](https://github.com/elythh/flake)
- [Flakes book](https://nixos-and-flakes.thiscute.world/)
- [Nix Language](https://nix.dev/)
- [chenglab](https://github.com/eh8/chenglab/blob/main/modules/macos/base.nix)
