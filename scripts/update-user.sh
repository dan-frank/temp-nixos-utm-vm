#!/usr/bin/env bash

nix build \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  .#homeManagerConfigurations.user.activationPackage
./result/activate
