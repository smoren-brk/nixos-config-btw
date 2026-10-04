{
  flake.modules.nixos.mpv = { pkgs, ... }: {
    hardware.graphics.enable = true;

    environment.systemPackages = with pkgs; [
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
    ];
  };

  flake.modules.homeManager.mpv = {
    programs.mpv = {
      enable = true;
      package = null;

      bindings = {
        LEFT = "no-osd seek -2 exact";
        RIGHT = "no-osd seek 2 exact";
      };

      config = {
        sub-auto = "fuzzy";
        sub-file-paths = "**";

        gpu-api = "vulkan";
        hwdec = "vaapi";
        gpu-context = "waylandvk";

        slang = "enm,en,eng,de,deu,ger";
        alang = "ja,jp,jpn,en,eng,de,deu,ger";

        audio-file-auto = "fuzzy";
        audio-pitch-correction = true;
        volume-max = 150;
        volume = 100;

        background-color = "#000000";
        osd-back-color = "#000000";
        osd-border-color = "#000000";
        osd-color = "#ffffff";
        osd-shadow-color = "#000000";

        cache = "yes";
        demuxer-max-bytes = "2G";
        demuxer-max-back-bytes = "1G";
      };

    };
  };
}
