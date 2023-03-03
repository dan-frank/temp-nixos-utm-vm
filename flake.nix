{
  description = "Natural Transformation B.V. NixOS Developer System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; #nixos-22.11 unstable

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... } @ inputs:
    let 
      inherit (inputs.nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

      system = "aarch64-linux";

      homeManagerStateVersion = "22.11";
      nixosStateVersion = "22.11";

      userDan = {
        username = "dan";
        fullName = "Daniel Lucas";
        email = "dan.frank.lucas@gmail.com";
        github = "dan-frank";
      };

      # primaryUserInfo = userDan;

      nixpkgsConfig = with inputs; rec {
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
              extraGroups = [ "networkmanager" "wheel" ];
              shell = pkgs.zsh;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
              # home.user-info = config.users.primaryUser;
            };
          }
        )
      ];
    in {
      nixosConfigurations = rec {
        nixos-dan = makeOverridable nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs.inputs = inputs;
          modules = [
            ./system/nixos/host-dan
            {
              system.stateVersion = nixosStateVersion;
              users.primaryUser = userDan;
            }
            ./system/common.nix
            ./system/packages.nix
            ./modules/users.nix
          ];
        };
        # nixos-x86 = nixos-arm.override { system = "x86_64-linux"; };
      };

      homeManagerConfigurations = {
        dan = home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "aarch64-linux";
            inherit (nixpkgsConfig) config;
          };
          modules = [
            ./home/config-files.nix
            ./home/git.nix
            ./home/packages.nix
            ./home/shells.nix
            ./home/terminal.nix

            ./home/programs/bat.nix
            ./home/programs/neovim.nix
            ./home/programs/sbt.nix
            ./home/programs/vscode.nix
          ] ++ singleton ({ config, ... }: {
            home.username = config.home.user-info.username;
            home.homeDirectory = "/home/${config.home.username}";
            home.stateVersion = homeManagerStateVersion;
            home.user-info = userDan;
          });
        };
      };

      # nixosModules = {
      #   stateVersion = { system.stateVersion = nixosStateVersion; };

      #   common = import ./system/common.nix;
      #   packages = import ./system/packages.nix;

      #   users-primaryUser = import ./modules/users.nix;
      # };

      # homeManagerModules = {
      #   home-config-files = import ./home/config-files.nix;
      #   home-git = import ./home/git.nix;
      #   home-packages = import ./home/packages.nix;
      #   home-shells = import ./home/shells.nix;
      #   home-terminal = import ./home/terminal.nix;

      #   home-bat = import ./home/programs/bat.nix;
      #   home-neovim = import ./home/programs/neovim.nix;
      #   home-sbt = import ./home/programs/sbt.nix;
      #   home-vscode = import ./home/programs/vscode.nix;
      # };
    };
}
