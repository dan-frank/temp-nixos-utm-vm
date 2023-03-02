{ config, lib, pkgs, ... }:
{
  imports = [
    "${fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
      sha256 = "sha256:0ahgyd2swkapimvf70ah2y55wpn2hdh1wymfh6492xrkv5x91sqz";
    }}/modules/vscode-server/home.nix"
  ];
  
  services.vscode-server.enable = true;

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
    extensions = with pkgs.vscode-extensions; [
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
}
