{ config, pkgs, lib, ... }:
let
  # fontFamily = "Terminus (TTF)";
  fontFamily = "TerminessTTF Nerd Font";

  github-dark = {
    primary = {
      background = "0x24292E";
      foreground = "0xe0e2e4";
    };
    normal = {
      black = "0x474646";
      red = "0xf97583";
      green = "0x85e89d";
      yellow = "0xffab70";
      blue = "0x79b8ff";
      magenta = "0xb392f0";
      cyan = "0x9ecbff";
      white = "0xe0e2e4";
    };
    bright = {
      black = "0x282828";
      red = "0xfdaeb7";
      green = "0xbef5cb";
      yellow = "0xfff5b1";
      blue = "0xc8e1ff";
      magenta = "0xd1bcf9";
      cyan = "0xb3f0ff";
      white = "0xe1e4e8";
    };
  };

  jellybeans = {
    primary = {
      background = "0x121212";
      foreground = "0xdedede";
    };
    cursor = {
      text = "0xffffff";
      cursor = "0xffa460";
    };
    normal = {
      black = "0x929292";
      red = "0xe27373";
      green = "0x94b979";
      yellow = "0xffba7b";
      blue = "0x97bedc";
      magenta = "0xe1c0fa";
      cyan = "0x00988e";
      white = "0xdedede";
    };
    bright = {
      black = "0xbdbdbd";
      red = "0xffa1a1";
      green = "0xbddeab";
      yellow = "0xffdca0";
      blue = "0xb1d8f6";
      magenta = "0xfbdaff";
      cyan = "0x1ab2a8";
      white = "0xffffff";
    };
  };

  quiet = {
    primary = {
      background = "0x000000";
      foreground = "0xdadada";
    };
    normal = {
      black = "0x000000";
      red = "0xd7005f";
      green = "0x00af5f";
      yellow = "0xd78700";
      blue = "0x0087d7";
      magenta = "0xd787d7";
      cyan = "0x00afaf";
      white = "0xdadada";
    };
    bright = {
      black = "0x707070";
      red = "0xff005f";
      green = "0x00d75f";
      yellow = "0xffaf00";
      blue = "0x5fafff";
      magenta = "0xff87ff";
      cyan = "0x00d7d7";
      white = "0xffffff";
    };
  };

  slate = {
    primary = {
      background = "0x262626";
      foreground = "0xffffff";
    };
    normal = {
      black = "0x000000";
      red = "0xff0000";
      green = "0x5f8700";
      yellow = "0xffff00";
      blue = "0x87d7ff";
      magenta = "0xd7d787";
      cyan = "0xffd7af";
      white = "0x666666";
    };
    light = {
      black = "0x333333";
      red = "0xffafaf";
      green = "0x00875f";
      yellow = "0xffd700";
      blue = "0x5f87d7";
      magenta = "0xafaf87";
      cyan = "0xff8787";
      white = "0xffffff";
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "0xffffff";
      };
      # ??? https://sourcegraph.com/github.com/NeQuissimus/DevSetup/-/blob/users/nequi/home/alacritty.nix
      selection.save_to_clipboard = true;
      # shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        dynamic_title = false;
        decorations = "Buttonless"; # Full | Transparent | Buttonless | None
        opacity = 1.00;
        padding = {
          x = 10;
          y = 10;
        };
      };
      scrolling.history = 10000;
      mouse = {
        hints = {
          launcher = {
            program = "open"; # Mac only -> need !isDarwin alt option
            modifiers = "Command";
          };
        };
      };
      key_bindings = [
        { key = "Key0"; mods = "Alt"; chars = "º"; }
        { key = "Key1"; mods = "Alt"; chars = "¡"; }
        { key = "Key2"; mods = "Alt"; chars = "€"; }
        { key = "Key3"; mods = "Alt"; chars = "#"; }
        { key = "Key4"; mods = "Alt"; chars = "¢"; }
        { key = "Key5"; mods = "Alt"; chars = "∞"; }
        { key = "Key6"; mods = "Alt"; chars = "§"; }
        { key = "Key7"; mods = "Alt"; chars = "¶"; }
        { key = "Key8"; mods = "Alt"; chars = "•"; }
        { key = "Key9"; mods = "Alt"; chars = "ª"; }
        { key = "N"; mods = "Command|Shift"; action = "SpawnNewInstance"; }
      ];
      colors = github-dark;
      font = {
        normal.family = "${fontFamily}";
        bold.family = "${fontFamily}";
        italic.family = "${fontFamily}";
        bold_italic.family = "${fontFamily}";
        size = 17;
      };
    };
  };
}
