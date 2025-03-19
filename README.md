<div align="center">
  <h1> dotfiles </h1>
</div>

This configuration is under constant construction so some things may be remove or add accordings to my needs but i want to keep all even if it's not used anymore.

This repository follow the KISS principle and the suckless idea at this moment, but feel free to propose improvement.

> [!IMPORTANT]
> Since this configuration is made for my own needs, you can take inspiration and some configuration but do not expect it to work on your side.
>
> Any damage caused by this configuration is not my responsibility, so use it at your own risks.

## ✨️ - Features

This repository want this to be multi-user and multi-host so there is some workaround to make things work like i want and keep it simple.

- [x] NixOS
- [x] Nix Darwin
- [ ] Nix BSD
- [ ] WSL
- [ ] MicroVM for servers
- [ ] Secrets management
- [ ] Secure Boot
- [ ] Persistant storage
- [ ] Disk configuration
- [ ] Encrypted disks
- [ ] Home management
- [ ] Custom live ISO
- [ ] Auto-updating flakes

## 💻 - Hosts

|  Hostname    | Motherboard                       | CPU                  | GPU               | RAM  | OS  | Usage    | Status |
| :----------- | :-------------------------------- | :------------------- | :---------------- | :--: | :-: | :------: | :----: |
|  `hydrogen`  | ASUS ROG STRIX B760-I GAMING WIFI | Intel i5 13600kf     | Nvidia 4070ti     | 32Go | ❄️  | 🎮️      | 🟢️     |
|  `helium`    | -                                 | Apple M2 Pro         | Apple M2 Pro      | 32Go | 🍎️  | ⌨️      | 🟢️     |
|  `lithium`   | Raspberry Pi4 b+                  | -                    | -                 | 1Go  | ❄️  | 🧨️      | 🟠     |
|  `beryllium` | WSL                               | Intel i5-1135G7      | -                 | 8Go  | ❄️  | ⌨️      | 🟢️     |
|  `boron`     | Aorus B450 Elite                  | AMD Ryzen 3 3300X    | Nvidia 1060       | 16Go | ❄️  | 🎮️ / ⌨️ | 🔴     |
|  `carbon`    | HP ProDesk 400 G1 DM              | Intel Pentium G3250T | -                 | 8Go  | ❄️  | 💾️      | 🔴     |
|  `nitrogen`  | MSI B450-A Pro Max                | AMD Ryzen 5 3600x    | Nvidia 1660ti     | 16Go | ❄️  | 🎮️      | 🔴     |

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

## 📦 - Folder structure

```
.
├── users # User home configuration
│  │  ├── commons
│  │  └── <hostname>
├── config # Host-specific configuration
│  └── <os> # Darwin or NixOS
│  │  └── <hostname>
├── lib # Custom functions needed to help configure
├── modules # macOS and nix-darwin, NixOS, and shared configuration
│  ├── commons
│  ├── nixos
│  ├── darwin
│  └── bsd
├── overlays
└── templates
```

### 📚️ - Acknowledgments

These are the things that help me the most to understand Nix ecosystem and help me build my configuration from scratch.

You can retrieve dotfiles that inspired me inside my [`dotfiles` star list](https://github.com/stars/Cosmeak/lists/useful-dotfiles).

- [Flakes book](https://nixos-and-flakes.thiscute.world/)
- [Nix Language](https://nix.dev/)
- [Nix Tour](https://nixcloud.io/tour/?id=introduction/nix)

## 🐛 - Troubleshooting

- If the rebuild command failed because an experimental feature is disabled use this command:
```sh
sudo -E NIX_CONFIG="experimental-features = nix-command flakes pipe-operators" nixos-rebuild switch --flake .
```
