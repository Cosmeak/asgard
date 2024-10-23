<div align="center">
  <h1> Asgard </h1>
</div>

This configuration is under constant construction so some things may be remove or add accordings to my needs but i want to keep all even if it's not used anymore.

This repository follow the KISS principle at this moment, but feel free to propose improvement and to help me understand better how nix work.

> [!IMPORTANT]
> This configuration is make for our purpose, you can take inspiration and some configuration but do not expect it to work on your side.🙂
>
> Any damage caused by this configuration is not our responsibility. Use it at your own risks.

## ✨️ - Features

- [x] NixOS
- [x] Nix Darwin
- [ ] Nix BSD
- [ ] WSL
- [ ] Homelab with MicroVM
- [ ] Secrets management
- [x] Default on stable channel and have unstable as an overlay (take from [here](https://github.com/AlexNabokikh/nix-config))
- [ ] Dotfiles management
- [ ] Custom live ISO
- [ ] Auto-updating flakes
- [ ] Encrypted disks
- [ ] Secure Boot

## 💻 - Hosts

|  Hostname  |            Motherboard            |          CPU         |        GPU        |  RAM | OS  | Usage    | Status |
|:----------:|:---------------------------------:|:--------------------:|:-----------------:|:----:|:---:|:------- :|:------:|
|   `njord`  | -                                 | Apple M2 Pro Chip    | Apple M2 Pro Chip | 32Go | 🍎️  | ⌨        | 🟢️     |
|   `loki`   | ASUS ROG STRIX B760-I GAMING WIFI | Intel i5 13600kf     | Nvidia 4070ti     | 32Go | ❄️  | 🎮️ / 🎭️ | 🟢️     |
| `hvedrung` | ⤴️                                | ⤴️                   | ⤴️               | ⤴️   | 👹️  | 🧨️ / 🎭️ | 🔴️     |
|    `nyx`   | Aorus B450 Elite                  | AMD Ryzen 3 3300X    | Nvidia 1060       | 16GO | ❄️  | 🎮️ / ⌨️  | 🟢️     |
|  `beowulf` | HP ProDesk 400 G1 DM              | Intel Pentium G3250T | -                 | 8Go  | ❄️  | 💾️      | 🟠     |

<details>
  <summary>Legend</summary>

- 🎮️ : Gaming
- 💾️ : Server
- ☁️ : Virtual Machime
- ⌨️ : Coding
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
│  └── <user>@<host>   # Personal folders for dotfiles
├── hosts        # Host-specific configuration
├── lib          # Custom functions needed to help configure
├── modules      # macOS and nix-darwin, NixOS, and shared configuration
│  ├── shared       # Shared modules across all platforms
│  ├── nixos        # Nixos modules
│  ├── darwin       # MacOS modules
│  └── bsd          # FreeBSD modules
└── overlays     # Helping overlays for building wanted packages
```

## 💡 - Acknowledgments

These are the things that help me the most to understand Nix ecosystem and help me build my configuration from scratch.

### 📚️ - Learning

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
