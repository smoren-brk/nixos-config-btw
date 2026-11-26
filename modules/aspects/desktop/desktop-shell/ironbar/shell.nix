{ inputs, ... }:

{
  flake-file.inputs.ironbar = {
    url = "github:JakeStanger/ironbar";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.ironbar =
    { pkgs, theme, ... }:
    let
      ironbar = inputs.ironbar.packages.${pkgs.stdenv.hostPlatform.system}.default;
      python = pkgs.python3.withPackages (ps: [ ps.pygobject3 ]);
      niriLabel = name: accent: {
        type = "script";
        inherit name;
        mode = "watch";
        cmd = "exec ${python}/bin/python ${./niri-status.py} ${name} '${accent}'";
      };

      networkIcon = pkgs.writeShellScript "ironbar-network-icon" ''
        LC_ALL=C ${pkgs.networkmanager}/bin/nmcli -t -f TYPE,STATE device status |
          ${pkgs.gawk}/bin/awk -F: '
            $2 ~ /^connected/ && $1 == "ethernet" { wired = 1 }
            $2 ~ /^connected/ && $1 == "wifi"    { wifi = 1 }
            END {
              if (wired) print "󰈀"
              else if (wifi) print "󰖩"
              else print "󰖪"
            }'
      '';

      image = name: src: size: {
        type = "custom";
        inherit name;
        bar = [ { type = "image"; inherit src size; } ];
      };
    in
    {
      environment.systemPackages = [ ironbar ];
      local.wrappers.niri.settings.spawn-at-startup = [ [ "ironbar" ] ];

      environment.etc."ironbar/init.lua".source = ./init.lua;
      environment.etc."ironbar/config.json".text = builtins.toJSON {
        name = "top";
        position = "top";
        height = 40;
        anchor_to_edges = true;
        margin = { top = 8; left = 10; right = 10; };
        start = [
          (image "nixos" "icon:nix-snowflake" 20)
          (niriLabel "workspaces" theme.colors.pink)
          (niriLabel "application" theme.colors.secondary)
        ];
        end = [
          {
            type = "script";
            name = "network";
            cmd = networkIcon.outPath;
            interval = 5000;
          }
          {
            type = "clock";
            format = "%a %-d. %b %H:%M";
            format_popup = "%H:%M";
            disable_popup = true;
          }
        ];
      };

      environment.etc."ironbar/style.css".text = ''
        @define-color surface ${theme.colors.bg2};
        @define-color workspace_bg ${theme.colors.bg3};
        @define-color foreground ${theme.colors.fg1};
        @define-color secondary ${theme.colors.fg2};
      '' + builtins.readFile ./style.css;
    };
}
