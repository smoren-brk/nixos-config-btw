{
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    package = null;

    enableZshIntegration = true;
    systemd.enable = false;

    themes = {
      jx = {
        background = "161616";
        cursor-color = "f2f4f8";
        foreground = "f2f4f8";
        palette = [
          "0=#282828"
          "1=#ee5396"
          "2=#25be6a"
          "3=#08bdba"
          "4=#78a9ff"
          "5=#be95ff"
          "6=#33b1ff"
          "7=#dfdfe0"
          "8=#484848"
          "9=#f16da6"
          "10=#46c880"
          "11=#2dc7c4"
          "12=#8cb6ff"
          "13=#c8a5ff"
          "14=#52bdff"
          "15=#e4e4e5"
        ];
        selection-background = "3d3d3d";
      };
    };

    settings = {
      font-family = "0xProto Nerd Font";
      theme = "jx";
      quit-after-last-window-closed = false;
    };
  };

}
