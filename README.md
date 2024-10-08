# Asgard

> [!WARNING]
> This configuration is only for my purpose, you can take inspiration and some code but don't install or use it as a base.🙂

## 💻 - Hosts

| Name     | OS                    | Usage       | Machine        |
| -------- | --------------------- | ----------- | -------------- |
| njord    | MacOS                 | Development | Macbook Pro M2 |
| loki     | NixOS                 | Gaming      | Desktop        |
| hvedrung | FreeBSD (with nixbsd) | Tests       | Desktop        |

| Machine | CPU        | GPU           | RAM  |
| ------- | ---------- | ------------- | ---- |
| Desktop | i5 13600kf | Nvidia 4070ti | 32Go |

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
