{ config, lib, pkgs, ... }:
let
  sbt-overlay = self: super: {
    sbt = super.sbt.override { jre = super.jdk11; };
  };
in {
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