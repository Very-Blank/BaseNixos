{nvim, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages =  [
      pkgs.lua-language-server
    ];
  };

  xdg.configFile."nvim" = {
    enable = true;
    source = nvim;
  };
}
