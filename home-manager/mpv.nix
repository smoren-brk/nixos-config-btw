{
  pkgs,
  ...
}:

{
  programs.mpv = {
    enable = true;
    package = null;

    bindings = {
      LEFT = "no-osd seek -2 exact";
      RIGHT = "no-osd seek 2 exact";
      c = "script-message osc-visibility cycle";
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
      volume = 75;

      osc = false;
    };

  };
}
