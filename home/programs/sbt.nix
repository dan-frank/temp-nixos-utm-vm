{ config, lib, pkgs, ... }:
{
  programs.sbt = {
    enable = true;
    package = pkgs.sbt;
  };

  services.lorri.enable = true;
  programs.direnv.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 360000;
    defaultCacheTtlSsh = 360000;
    enableSshSupport = true;
  };
}