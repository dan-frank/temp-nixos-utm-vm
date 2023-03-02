# Helpful
# - https://sourcegraph.com/github.com/cbrewster/nix-home/-/blob/home/neovim.nix
{ config, lib, pkgs, ... }:
let
  github-nvim-theme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "github-nvim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "b3f15193d1733cc4e9c9fe65fbfec329af4bdc2a";
      sha256 = "wLX81wgl4E50mRig9erbLyrxyGbZllFbHFAQ9+v60W4=";
    };
  };
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      syntax on
      set laststatus=2
      set softtabstop=2
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set autoindent
      set showmatch
      set number relativenumber
      set wrap
      set encoding=utf-8

      lua << EOF
      require('github-theme').setup({
          theme_style = 'dark',
          dark_float = true,
      })
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      # Languages
      vim-nix
      vim-scala

      # Themes
      github-nvim-theme
      rainbow_parentheses
      tagbar

      # Utility
      ctrlp
      # deoplete
    ];
  };
}
