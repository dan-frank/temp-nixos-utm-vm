# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "mac";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan = {
    isNormalUser = true;
    description = "Daniel Lucas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmr/PcOIiVfCw/FpWkgBGEmEsrwdc0qTn1TlxBeN6dQu0qhz1EnJs61InjpYrqVPkUdwAOquTSOwfJ2hZcqJGx3ghJplWHjoJsdXCE38oM18LGFGYqDTr/3yu9GbsFllKuZOixdw3IlwJgp9TNGriXnqGqxDFDPgC7vOVXZ6i3jlO+z/0ClxaqT7IMf1lTnYdBYSPNURVWDwY50CZmkh5A+9ZuTwPse63pjvfLj2uwobvN4jZmBnB+/UH9WM4nXHKfXUZjgjRPZuAqJKmtSPoxAjuMf4bPah+tJAqi5ohSJNB5f6qeFRHno482ttDK40NmoMOWS+vsdra3/fXlEegLPwwrCzNqz0tOqxDd2uhXpERCDhD4giTAFIsEdI1Ss88wKL0axUTk2dioDcnfmVkNbDgkU814b7w9sXJK00pk4GzqapakldFkpGJB/ptOWFzdpBjbV3g9DHIopMj/UWWOBlDS0+F/+L4UnR/VYX8F4OIG8KGBvpGjn0HhnhoeTKD2Fd/Qz53ldgPLL5H8TydNbtFe0xGyj3zMXadnuOuULQtfpRDTS9RwBzQyiQU7pHKw4OgAGb66ecsvkI1JGJeGwlSnhFHI1wtP7iRL+Jyvw31lWIGRzf7QFX18i5UqfZzXN0wa4U+SuvSZzWRnRR3dPgxNOwIZnxSdRBpiFwOe6Q== dan@Daniels-MacBook-Pro.local"
    ];
  };
  users.users.zhen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user.

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLY+TrKSLyPIAFM4qjVJQOMC+7wjrovNc6ylsml+dyXHjo+KA1cADf2f8lH+PzRDGYaNHOqBKPVmpnXnQef+HdEfZr+gfB91iMLFQH/sFY7vdDJ4rmuShl1n7XYhsWI+/dakB3qrEmzl8uBiyA8WNf1uOy/dAzQQTy+wwLGA8r9I+vRu98UYffgu4cY8jkwxLjZvzzCKcCoWxVKYx4jD7K9uotuV+k1fksWzbkmgdmOLtiG3p2GhlavxG1ztH7lmvdu1VI/ydH9gu3p3q01V3YMLwvApMv2p22fsqPPu8GUkgxnTVjHgEZ/mmEN+OZSgUNjzdUFQif6mlUgC7Wx5WN"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn/87gO7nwyVgjp9TxhhKcngbnP+Tuz5s8nGYU0h2B3655e4FyHI5sK2MdCz6I5HyPg5ttLS8hGCH8d7T9GwpUIbEbmPHgIH9URcNeQvG+Zc3BbrTmAqHQN7wiM82dCI3tfA6qrTQar97Qtfx/LPzHNv7GUMnT6eFcbJZ9WHZG+Q/DgDYTtCM/RDJm/E4gZbeupH4IQ0oAtInjhDgKjA8Wkym239EsNqpdJEDUdrCGHMavD9hPZREncfNgEFaf7GNh1z259ZhdI7b/b102tO3LD0KgbAOpw00LRXgy68buxQJI9RuhPncpY2EJvLZIF97GUnx7fml3pzp4UFENHmQvOzjcuOEcb0zsrwzD3332f1OuUwJ6v1jayMTzXfil2SKqItzDscXN4EqyiHndXpoio3CKPVZT51dQU9VQkAdzkgSuvbmgeRzBQHKEHIiKL3WEcv8PrB1Wx5BwpeKxGoFn5qE1O1OU5sMk37qzmNSlx7bd46NrkdXiMoE3Z+lwUCbib4hpTQN/YFddwNQ2lFD6iLMXUcNsN4DxV/fA4JBwCSjHngIn95Z5UFA8zSSE6DM8Tpml6Ulgpz7bo37zND/MbKcd0Ncv87E23ET2jk6GqDGO2r8VpIBwNg+rCmIdd6wGGs7gonUN8UFOFVQlKjWV4DP3iddeSUDEHHd4kj9IXQ== zhenhaolee@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNoHIzSTioWmYu89667bXzWLLQtBoPAPxQ10/JnXXfW9NELp8+Tg9WUPa8IN0GwVVyBIDaHkTclP3O0HdTKK2BCMehy/NW1wFm6VyNjoJ7sYrPmaaZ/F1KeOcBiNCJ7qa47zFnMmYAxYIV2TJh+UtycCGBBXr+qsUyWTLDXZ6Z7cmq24fIOufaUYQmfSyuXssDasMW5/M2x0WTuWK6QLBuYPVNla2RG0Amau2GpPRPoS6n3tHH7Ei0jMVJrf3VY9FFDi6DspyhLsSm58B4bax3WRZm25cPKakO4hA74Kf0eLCWwnvym3z6Q8IPIElxrYi/P4SX6pDNbB6rbq/5iF84NI7XG8QbH1IJ2CXCYWvgOE/g6ADAz0Q05GTTARjfwqP1K6CCv69qqk2rCYviokq3bl3fTv7kMOQH74pLcd3Kaf8Rl4FI09zxtFJ5XGWCLxyxK2HX0qhFs1RUWuEmomrEochsr3fOAcmpjIqLn5ViIH3gsbEb+iW4/2u6hbgEjBaHgxO/Y4eJa4CX6mZkmWtUJKDv54zvEIEA2V1Oqr8kw6QQcKl+J+3TxJKRoMqKHjRMv7a3inMcJEQscz5qCx8E7Al+nyzK/OB/Ry0D4ck/7Wy4ZhoJ6gzfb+ozV/sr9ibFAh1N/98oy3f4IfTsq/6/sCJKdmj1N0HNDXXOvG/YQw== zhenhaolee@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzJslrYMSPYHQsUvDh6Bl1lGGKJxNyCdRcMcECeqN9hJ4C6gU5ANTKpOlc1khXp9RuqMnexDvV/l+/qMY2+2bRDVuLCdx0fjs2gya35YrQoPW1wSwo+v+hiwr/oj6H0rNv8JHHIE4iCFaU7PIvvjNKP57Koj8TaU5yebeM7MGnj/nq9YrHo5T7qD+PqUDwrWZ6iYm1pDvcBK5c0UoCspZeIJvsxx5vSeqZO2xkCAI0+8pvGB3gIwDenDc+itVYbZnONU4LuYdsHMqegNry+xK9wmS1tVx0AdXHOOhpPSEoSVdsSbWIaXhJnmlr4qfCukqA0EzIlBhv66xaJfvtYboVcf5OHdYOHq7yYBb0Dg94lmJp1BgHhE8nc7OJVZLaVgRH4bpLNWiVjsmX+AFzXt2Cmst98KeetRnz9SNtymuouoCHm8jKbda2fSZPcjA2qrofPkU/wmPP09hp86JR85sOZqrU1SC3W5y2Czj7kcHNpe5Q6bsIx80sgphwVeIenmc= zhen@Zhenhaos-MacBook-Pro.local"
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dan";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9000 9001 9002 9003 9004 9005 9006 9007 9008 9009 ];
  networking.firewall.allowedUDPPorts = [ 51820 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.100.0.5/24" ];
      privateKeyFile = "/home/zhen/wireguard-keys/private";
      
      peers = [
        {
          publicKey = "Cq1XjSaGaa4kL5uXKrxz+j6Y4yEjshkUVbMSlFFi3mM=";
          # presharedKeyFile = "/root/wireguard-keys/preshared_from_peer0_key";
          allowedIPs = [ "10.100.0.1/24" "192.168.1.0/23" "::/0" ];
          endpoint = "77.60.203.42:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

