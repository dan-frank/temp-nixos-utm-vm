{
  description = "Natural Transformation B.V. NixOS Developer System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; #nixos-22.11 unstable
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }: # inputs@
  let 
    system = "aarch64-linux";
    homeManagerStateVersion = "22.11";
    nixosStateVersion = "22.11";

    primaryUserInfo = {
      username = "dan";
      fullName = "Daniel Lucas";
      email = "dan.frank.lucas@gmail.com";
      github = "dan-frank";
    };

    nixpkgsConfig = with inputs; rec {
      inherit system;
      config = { allowUnfree = true; };
    };

    nixosCommonModules = attrValues self.nixosModules ++ [
      home-manager.nixosModules.home-manager
      ({ config, lib, pkgs, ... }:
        let
          inherit (config.users) primaryUser;
        in
        rec {
          nixpkgs = nixpkgsConfig;
          users.users.${primaryUser.username} = {
            home = "/home/${primaryUser.username}";
            isNormalUser = true;
            isSystemUser = false;
            initialPassword = "helloworld";
            extraGroups = [ "wheel" ];
            shell = pkgs.zsh;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.users.${primaryUser.username} = {
            imports = attrValues self.homeManagerModules;
            home.stateVersion = homeManagerStateVersion;
            home.user-info = config.users.primaryUser;
          };
        }
      )
    ];
  in
  {
    nixosConfigurations = rec {
      nixos-x86 = makeOverridable nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs.inputs = inputs;
        modules = nixosCommonModules ++ [
          ./configuration.nix
          {
            users.primaryUser = primaryUserInfo;
          }
        ];
      };
      nixos-arm = nixos-x86.override { system = "aarch64-linux"; };
    };

    homeConfigurations = {
      dan = home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs-unstable {
          # system = "x86_64-linux";
          inherit system;
          inherit (nixpkgsConfig) config overlays;
        };
        modules = attrValues self.homeManagerModules ++ singleton ({ config, ... }: {
          home.username = config.home.user-info.username;
          home.homeDirectory = "/home/${config.home.username}";
          home.stateVersion = homeManagerStateVersion;
          home.user-info = primaryUserInfo;
        });
      };
    };

    nixosModules = {
      stateVersion = { system.stateVersion = nixosStateVersion; };

      # common = import ./system/common.nix;
      # packages = import ./system/packages.nix;

      # users-primaryUser = import ./schema/users.nix;
    };

    homeManagerModules = {
      home-config = import ./home.nix;
      # home-config-files = import ./home/config-files.nix;
      # home-git = import ./home/git.nix;
      # home-packages = import ./home/packages.nix;
      # home-shells = import ./home/shells.nix;
      # home-terminal = import ./home/terminal.nix;

      # home-bat = import ./home/programs/bat.nix;
      # home-neovim = import ./home/programs/neovim.nix;
      # home-vscode = import ./home/programs/vscode.nix;
    };
  };
}
