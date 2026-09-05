{ ... }:

{
  programs.quickshell = {
    enable = true;
    package = null;
  };

  xdg.configFile."quickshell".source = ./config;
}
