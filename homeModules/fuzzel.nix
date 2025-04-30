{...}:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        "dpi-aware" = "no";
        "icon-theme" = "Papirus";
        width = 40;
        font = "0xProtoNerdFont:weight=normal:size=14";
        "line-height" = 15;
        "vertical-pad" = 8;
        "horizontal-pad" = 20;
        fields = "name,generic,comment,categories,filename,keywords";
        terminal = "foot -e";
        prompt = "❯   ";
        "show-actions" = "yes";
        "exit-on-keyboard-focus-loss" = "yes";
      };

      colors = {
        background = "282a36fa";
        selection = "3d4474fa";
        border = "fffffffa";
      };

      border = {
        radius = 20;
      };

      dmenu = {
        "exit-immediately-if-empty" = "yes";
      };
    };
  };
}
