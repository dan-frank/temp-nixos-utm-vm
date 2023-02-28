#!/usr/bin/env bash

nix build .#homeManagerConfigurations.zhen.activationPackage

# nix build .#homeManagerConfigurations.zhen.activationPackage --show-trace

./result/activate
