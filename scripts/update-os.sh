#!/usr/bin/env bash

nixos-rebuild switch --use-remote-sudo --flake '.#'

# nixos-rebuild switch --use-remote-sudo --flake '.#' --show-trace

