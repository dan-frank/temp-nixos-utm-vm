{ config, lib, pkgs, ... }:

let

  sbt-overlay = self: super: {
    sbt = super.sbt.override { jre = super.jdk11; };
  };
  
in {

  imports = [
    "${fetchTarball {
        url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
        sha256 = "sha256:0ahgyd2swkapimvf70ah2y55wpn2hdh1wymfh6492xrkv5x91sqz";
      }}/modules/vscode-server/home.nix"
  ];
  
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  # fonts = {
  #   enableFontDir = true;
  #   enableGhostscriptFonts = false;
  #   fonts = with pkgs; [
  #     corefonts
  #     symbola
  #     font-awesome-ttf
  #     libertine
  #     terminus_font
  #     ubuntu_font_family
  #     liberation_ttf
  #     freefont_ttf
  #     source-code-pro
  #     inconsolata
  #     vistafonts
  #     dejavu_fonts
  #     freefont_ttf
  #     unifont
  #     cm_unicode
  #     ipafont
  #     baekmuk-ttf
  #     source-han-sans-japanese
  #     source-han-sans-korean
  #     source-han-sans-simplified-chinese
  #     source-han-sans-traditional-chinese
  #     source-sans-pro
  #     source-serif-pro
  #     fira
  #     fira-code
  #     fira-mono
  #     hasklig
  #   ];
  # };
  
  home.stateVersion = "22.11";
  home.username = "dan";
  home.homeDirectory = "/home/dan";

  home.sessionVariables = {
    HAVE_NT_DATA_SCIENCE_CREDENTIALS = 1;
  };

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
    ripgrep
    tree
  ];

  programs.bash = {
    initExtra = ''
      eval "$(direnv hook bash)"
    '';
  };

  services.vscode-server.enable = true;

  # programs.google-chrome.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 360000;
    defaultCacheTtlSsh = 360000;
    enableSshSupport = true;
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "dan-frank";
    userEmail = "dan.frank.lucas@gmail.com";
    ignores = [ ".metals" ".bloop" ];
    extraConfig = {
      credential.helper = "store";
      # credential.helper = "cache --timeout=360000"; #360000
    };

  };

  programs.sbt = {
    enable = true;
    package = pkgs.sbt;
  };

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;  #pkgs.vscode.fhs;
    userSettings = {
      "window.zoomLevel" = 1;
      "git.autofetch" = false;
      "diffEditor.ignoreTrimWhitespace" = true;
      "gitlens.views.lineHistory.enabled" = true;
      "gitlens.advanced.messages" = {
        "suppressFileNotUnderSourceControlWarning" = true;
      };
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/.factorypath" = true;
      };
      "files.watcherExclude" = {
        "**/.bloop" = true;
        "**/.metals" = true;
        "**/.ammonite" = true;
      };
      # "remote.SSH.defaultExtensions" =
      #   [ "eamodio.gitlens" "scalameta.metals" "ms-python.python" ];
      # "metals.javaHome" = "/home/dan/.nix-profile";
      "metals.javaHome" = "/home/dan/.nix-profile";
      "java.semanticHighlighting.enabled" = true;
      "python.jediEnabled" = true;
      "python.linting.pylintEnabled" = false;
      "python.linting.enabled" = true;
      "python.linting.flake8Enabled" = false;
    };
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        # ms-python.python
        matklad.rust-analyzer
        # scala-lang.scala
        # scalameta.metals
        # ms-vsliveshare.vsliveshare
        ms-vscode-remote.remote-ssh
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # {
        #   name = "Nix";
        #   publisher = "bbenoist";
        #   version = "1.0.1";
        #   sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
        # }
        {
          name = "metals";
          publisher = "scalameta";
          version = "1.11.0";
          sha256 =
            "zrWgUr/sndh6WUpnMMYoWWrH4t56Vb3hhp2Z8EB9iig=";
        }
        {
          name = "scala";
          publisher = "scala-lang";
          version = "0.5.3";
          sha256 = "0isw8jh845hj2fw7my1i19b710v3m5qsjy2faydb529ssdqv463p";
        }
      ];
  };

#   programs.ssh = { 
#     enable = true; 
#     extraConfig = ''
#     Host gitlab.com
#       UpdateHostKeys no
#     '';
#   };

  services.lorri.enable = true;
  programs.direnv.enable = true;

#   services.redshift = {
#     enable = true;
#     temperature.day = 5500;
#     settings.redshift.brightness-day = "0.8";
#     temperature.night = 3000;
#     settings.redshift.brightness-night = "0.6";
#     latitude = "52.3702";
#     longitude = "4.8952";
#     provider = "manual"; # geoclue2
#   };
}
