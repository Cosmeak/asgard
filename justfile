default:
    @just --list

nixos-switch:
    sudo nixos-rebuild switch --flake .

darwin-switch:
    sudo darwin-rebuild switch --flake .

clean:
    nix-store --optimize
    nix-collect-garbage -d
    sudo nix-collect-garbage -d

nix-size:
    du -sh /nix/store