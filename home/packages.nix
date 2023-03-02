{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    spice-gtk # VM
    
    mkpasswd

    firefox
    chromium
    # google-chrome
    # brave # browser
    gparted # disk
    peek # record gif

    # deluge # p2p download
    gnupg # Modern (2.1) release of the GNU Privacy Guard, a GPL OpenPGP implementation
    spectacle # screenshot
    aspellDicts.en # spelling check
    # slack # company chat
    # p7zip

    # Dev
    # glibc
    # openjdk11 # Java
    # jetbrains.idea-community
    # sbt
    # coursier
    # protobuf
    # maven

    rustup # Rust

    # terraform

    # influxdb2
    
    nodejs-14_x

    # docker-compose
    # kubectl # K8
    # kafkacat # kafka
    python39Packages.databricks-cli

    # awscli # AWS

    cachix
    nixfmt

    imagemagick # image editing
    gthumb

    # for making bootable USB
    # unetbootin
    # p7zip
    # mtools
    # geekbench # benchmark
    phoronix-test-suite # benchmark
    hyperfine # benchmark
    glmark2 # benchmark

    # obs-studio # video/stream

    # Useful CLI tools
    coreutils
    ripgrep
    vifm
    bottom
    tree
    less
  ];

  home.file = {
    ".hushlogin".text = "";
    ".p10k.zsh".source = link ./../dotfiles/p10k.zsh;
  };
}

