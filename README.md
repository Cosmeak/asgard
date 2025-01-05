<div align="center">
  <h1> Asgard </h1>
</div>

This configuration is under constant construction so some things may be remove or add accordings to my needs but i want to keep all even if it's not used anymore.

This repository follow the KISS principle and the suckless idea at this moment, but feel free to propose improvement and to help me understand better how nix work.

> [!IMPORTANT]
> This configuration is make for our purpose, you can take inspiration and some configuration but do not expect it to work on your side.🙂
>
> Any damage caused by this configuration is not our responsibility. Use it at your own risks.

## ✨️ - Features

This repository want this to be multi-user and multi-host so there is some workaround to make things work like i want and keep it simple.

- [x] NixOS
- [x] Nix Darwin
- [ ] Nix BSD
- [ ] WSL
- [ ] Homelab with MicroVM
- [ ] Secrets management with Agenix
- [ ] Secure Boot with lanzaboot
- [ ] Persistant storage with impermanence
- [ ] Disk configuration with disko
- [ ] Encrypted disks
- [x] Default on stable channel and have unstable as an overlay (take from [here](https://github.com/AlexNabokikh/nix-config))
- [x] Home Manager for dotfiles management
- [ ] Custom live ISO
- [ ] Auto-updating flakes

## 💻 - Hosts

|  Hostname  |            Motherboard            |         CPU          |        GPU        | RAM  | OS  |   Usage   | Status |
| :--------: | :-------------------------------: | :------------------: | :---------------: | :--: | :-: | :-------: | :----: |
|  `njord`   |                 -                 |  Apple M2 Pro Chip   | Apple M2 Pro Chip | 32Go | 🍎️ |     ⌨     |  🟢️   |
|   `loki`   | ASUS ROG STRIX B760-I GAMING WIFI |   Intel i5 13600kf   |   Nvidia 4070ti   | 32Go | ❄️  | 🎮️ / 🎭️ |  🟢️   |
|   `nyx`    |         Aorus B450 Elite          |  AMD Ryzen 3 3300X   |    Nvidia 1060    | 16GO | ❄️  | 🎮️ / ⌨️  |  🟢️   |
| `beowulf`  |       HP ProDesk 400 G1 DM        | Intel Pentium G3250T |         -         | 8Go  | ❄️  |    💾️    |   🟠   |
|   `vali`   |                WSL                |   Intel i5-1135G7    |         -         | 16Go | ❄️  |    ⌨️     |   🟠   |

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
│  ├── _shared   # Shared dotfiles between user configuration
│  │  └── <username>
│  └── <system>
│  │  └── <hostname>
│  │  │  └── <username> # User host specific dotfiles
├── hosts        # Host-specific configuration
│  └── <system>
│  │  └── <hostname>
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

## Troubleshooting

- If the rebuild command failed because an experimental feature is disabled use this command
```sh
sudo -E NIX_CONFIG="experimental-features = nix-command flakes pipe-operators" nixos-rebuild switch --flake .
``` 
