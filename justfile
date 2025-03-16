hostname := "$HOSTNAME"

default:
    @just --list

rebuild hostname=hostname:
    #!/usr/bin/env sh
    if [[ "$OSTYPE" == "darwin"* ]]; then \
        darwin-rebuild switch --flake .#{{ hostname }}; \
    else \
        sudo nixos-rebuild switch --flake .#{{ hostname }}; \
    fi;

clean:
    nix-store --optimize
    nix-collect-garbage -d
    sudo nix-collect-garbage -d

nix-size:
    du -sh /nix/store
