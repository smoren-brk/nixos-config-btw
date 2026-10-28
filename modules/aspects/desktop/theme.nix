{
  flake.modules.nixos.theme = { lib, ... }: {
    _module.args.theme = rec {
      name = "carbonfox";
      ghostty = "Carbonfox";

      # Carbonfox from EdenEast/nightfox.nvim
      colors = rec {
        bg0 = "#0c0c0c";
        bg1 = "#161616";
        bg2 = "#252525";
        bg3 = "#353535";
        bg4 = "#535353";
        fg0 = "#f9fbff";
        fg1 = "#f2f4f8";
        fg2 = "#b6b8bb";
        fg3 = "#7b7c7e";
        sel0 = "#2a2a2a";
        sel1 = "#525253";
        comment = "#6e6f70";
        black = "#282828";
        red = "#ee5396";
        green = "#25be6a";
        yellow = "#08bdba";
        blue = "#78a9ff";
        magenta = "#be95ff";
        cyan = "#33b1ff";
        white = "#dfdfe0";
        orange = "#3ddbd9";
        pink = "#ff7eb6";

        background = bg1;
        foreground = fg1;
        surface = bg2;
        hover = bg3;
        border = bg4;
        muted = fg3;
        secondary = fg2;
        selection = sel0;
        accent = blue;
      };

      bright = {
        black = "#484848";
        red = "#f16da6";
        green = "#46c880";
        yellow = "#2dc7c4";
        blue = "#8cb6ff";
        magenta = "#c8a5ff";
        cyan = "#52bdff";
        white = "#e4e4e5";
      };

      # Spicetify and Limine expect hex without '#'.
      raw = lib.mapAttrs (_: lib.removePrefix "#") colors;
      ansi = map (name: colors.${name}) ansiNames;
      ansiBright = map (name: bright.${name}) ansiNames;
      ansiNames = [
        "black"
        "red"
        "green"
        "yellow"
        "blue"
        "magenta"
        "cyan"
        "white"
      ];
    };
  };
}
