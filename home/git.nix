{ config, pkgs, lib, ... }:
let
  inherit (config.home) user-info;
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    # userName = user-info.fullName;
    # userEmail = user-info.email;
    userName = "Daniel Lucas";
    userEmail = "dan.frank.lucas@gmail.com";
    ignores = [ ".metals" ".bloop" ];
    extraConfig = {
      color.ui = "auto";
      core = {
        editor = "${pkgs.neovim}/bin/nvim";
        trustctime = false;
        logAllRefUpdates = true;
        precomposeunicode = true;
        whitespace = "trailing-space,space-before-tab";
      };
      # github.user = user-info.github;
      github.user = "dan-frank";
      pull.rebase = "true";
      credential.helper = "store";
    };
  };
}
