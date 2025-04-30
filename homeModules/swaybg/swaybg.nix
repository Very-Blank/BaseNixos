{config, pkgs, ...}:

{
  home.file."Pictures/wallpaper.png".source = ./wallpaper.png;
  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg background service";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      # Requisite = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/Pictures/wallpaper.png -m fill";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
