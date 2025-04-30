{nvim, ...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim" = {
    enable = true;
    source = nvim;
  };
}
