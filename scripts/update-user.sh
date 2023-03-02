#!/usr/bin/env bash

nix build \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  .#homeManagerConfigurations.dan.activationPackage
./result/activate
