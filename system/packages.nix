{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
    git
    vscode
  ];
}
