{ inputs, ... }:

{
  flake.modules.nixos.mpv = { pkgs, lib, ... }: {
    hardware.graphics.enable = true;

    environment.systemPackages = [
      (inputs.wrappers.wrapperModules.mpv.apply {
        inherit pkgs;

        scripts = [ pkgs.mpvScripts.mpris ];

        "input.conf".content = ''
          LEFT no-osd seek -2 exact
          RIGHT no-osd seek 2 exact
        '';

        "mpv.conf".content = lib.generators.toKeyValue { } {
          gpu-api = "vulkan";
          hwdec = "vaapi";
          gpu-context = "waylandvk";

          volume-max = 150;
          volume = 100;

          cache = "yes";
          demuxer-max-bytes = "2G";
          demuxer-max-back-bytes = "1G";

          background-color = ''"#1a1b26"'';
          osd-back-color = ''"#1a1b26"'';
          osd-border-color = ''"#1a1b26"'';
          osd-color = ''"#c0caf5"'';
          osd-shadow-color = ''"#1a1b26"'';

          slang = "enm,en,eng,de,deu,ger";
          alang = "ja,jp,jpn,en,eng,de,deu,ger";
        };

      }).wrapper
    ];
  };
}
