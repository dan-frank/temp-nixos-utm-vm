#!/usr/bin/env bash

nix build \
	--extra-experimental-features nix-command \
	--extra-experimental-features flakes \
	.#darwinConfigurations.nixos-arm.system
./result/sw/bin/nixos-rebuild switch --flake .#nixos-arm
