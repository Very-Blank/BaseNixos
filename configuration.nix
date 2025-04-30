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
    options = "--delete-older-than 2d";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Helsinki";

  services = {
    blueman.enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "catppuccin-macchiato";

      wayland = {
        enable = true;
        compositor = "weston";
      };

      settings = {
        Theme = {
          Current = "catppuccin-macchiato";
          CursorTheme = "Bibata-Original-Classic";
          CursorSize = 16;
        };
      };

      package = pkgs.kdePackages.sddm;
    };

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
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };

    tuxedo-drivers.enable = true;
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
    light = {
      enable = true;
    };
  };

  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "macchiato";
      font  = "0xProto Nerd Mono Font";
      fontSize = "14";
      # background = "${./wallpaper.png}";
      loginBackground = true;
    })
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

