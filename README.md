<div align="center">
  <h1> Asgard </h1>
</div>

This configuration is under constant construction so some things may be remove or add accordings to my needs but i want to keep all even if it's not used anymore.

This repository follow the KISS principle at this moment, but feel free to propose improvement and to help me understand better how nix work.

> [!IMPORTANT]
> This configuration is make for my purpose, you can take inspiration and some configuration but do not expect it to work on your side.🙂
>
> Any damage caused by this configuration is not my responsibility. Use at your own risk.

## ✨️ - Features

- [x] NixOS
- [x] Nix Darwin
- [ ] Nix BSD
- [ ] WSL
- [ ] Homelab with MicroVM
- [x] Multi flavor for DE / WM
- [ ] Secrets management
- [x] Default on stable channel and have unstable as an overlay (take from [here](https://github.com/AlexNabokikh/nix-config))
- [ ] Dotfiles managing
- [ ] Custom live ISO
- [ ] Auto-updating flakes
- [ ] Encrypted disks
- [ ] Secure Boot

## 💻 - Hosts

|  Hostname  |        CPU        |        GPU        | RAM  | OS  |   Usage   | Status |
| :--------: | :---------------: | :---------------: | :--: | :-: | :-------: | :----: |
|  `njord`   | Apple M2 Pro Chip | Apple M2 Pro Chip | 32Go | 🍎️ |    ⌨️     |  🟢️   |
|   `loki`   | Intel i5 13600kf  |   Nvidia 4070ti   | 32Go | ❄️  | 🎮️ / 🎭️ |  🟢️   |
| `hvedrung` |        ⤴️         |        ⤴️         |  ⤴️  | 👹️ | 🧨️ / 🎭️ |  🔴️   |
| `beowulf`  |                   |                   |      | ❄️  |    💾️    |  🔴️   |
|   `nyx`    | AMD Ryzen 3 3300X |    Nvidia 1060    | 16GO | ❄️  | 🎮️ / ⌨️  |  🟢️   |

<details>
  <summary>Legend</summary>

- 🎮️ : Gaming
- 💾️ : Server
- ☁️ : Virtual Machime
- ⌨️ : Development
- 🧨️ : Testing purpose
- 🎭️ : Dual Boot

- ❄️ : NixOS
- 🍎️ : MacOS
- 👹️ : FreeBSD with [NixBSD](https://github.com/nixos-bsd/nixbsd)
</details>

## 📦 - Structure

```
.
├── homes        # User home configuration
│  ├── <user>@shared   # Shared dotfiles between user configuration
│  └── <user>@<host>     # Personal folders for dotfiles
├── hosts        # Host-specific configuration
└── modules      # macOS and nix-darwin, NixOS, and shared configuration
    ├── shared       # Shared modules across all platforms
    ├── nixos        # Nixos modules
    ├── darwin       # MacOS modules
    └── bsd          # FreeBSD modules
```

## 💡 - Acknowledgments

These are the things that help me the most to understand Nix ecosystem and help me build my configuration from scratch.

📚️ - Learning

- [Flakes book](https://nixos-and-flakes.thiscute.world/)
- [Nix Language](https://nix.dev/)
- [Nix Tour](https://nixcloud.io/tour/?id=introduction/nix)
- [Simple Home Manager Explanation](https://github.com/Evertras/simple-homemanager)

### ✨️ - Dotfiles

You can retrieve more useful dotfiles inside my [dotfile star list](https://github.com/stars/Cosmeak/lists/useful-dotfiles).

The dotfiles listed below, are the one that really help me to build this are those from wich I took some code.

- [elythh](https://github.com/elythh/flake)
- [chenglab](https://github.com/eh8/chenglab)
- [AlexNabokikh](https://github.com/AlexNabokikh/nix-config)
