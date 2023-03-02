{ config, pkgs, lib, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  home.sessionVariables = {
    HAVE_NT_DATA_SCIENCE_CREDENTIALS = 1;
  };
  
  xdg = {
    enable = true;
    configHome = "${homeDirectory}/.config";
    dataHome = "${homeDirectory}/.local/share";
    cacheHome = "${homeDirectory}/.cache";
  };
}

