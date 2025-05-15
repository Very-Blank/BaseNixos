{pkgs, ... }:

{
  imports = [
    ./systemModules/bundle.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Helsinki";

  services = {
    blueman.enable = true;
    displayManager.ly.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      audio.enable = true;

      alsa = {
        enable = true;
        support32Bit = true; 
      };

      jack.enable = true;
    };

    openssh.enable = true;
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    }; 
  };

  systemd.user.services.network-manager-applet = {
    after = [ "tray.service" ];
  };

  systemd.user.services.blueman-applet = {
    after = [ "tray.service" ];
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  users.users.blank = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "bluetooth" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  environment.systemPackages = [
    pkgs.home-manager
    pkgs.vim
    pkgs.wget
    pkgs.unzip
    pkgs.seatd
    pkgs.pavucontrol
  ];

  fonts = {
    packages = [
      pkgs.jetbrains-mono
      pkgs.noto-fonts
      pkgs.noto-fonts-emoji
      pkgs.twemoji-color-font
      pkgs.font-awesome
      pkgs.powerline-fonts
      pkgs.powerline-symbols
      pkgs.nerd-fonts._0xproto
    ];
  };


  system.stateVersion = "24.11";
}

