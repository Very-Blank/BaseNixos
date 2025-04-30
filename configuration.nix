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

    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
        { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
      ];
    };

    openssh.enable = true;
  };

  programs = {
    light.enable = true;
    zsh.enable = true;
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

  environment.systemPackages = [
    pkgs.home-manager
    pkgs.vim
    pkgs.wget
    pkgs.unzip
    pkgs.seatd
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
      (pkgs.nerdfonts.override { fonts = [ "0xProto" ]; })
    ];
  };


  system.stateVersion = "24.11";
}

