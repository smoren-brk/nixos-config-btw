{ inputs, ... }:

{
  flake.modules.nixos.mpv = { pkgs, ... }: {
    hardware.graphics.enable = true;

    environment.systemPackages = [
      (inputs.wrappers.wrapperModules.mpv.apply {
        inherit pkgs;

        scripts = [ pkgs.mpvScripts.mpris ];

        "input.conf".content = ''
          LEFT no-osd seek -2 exact
          RIGHT no-osd seek 2 exact
        '';

        "mpv.conf".content = ''
          gpu-api=vulkan
          hwdec=vaapi
          gpu-context=waylandvk

          volume-max=150
          volume=100

          cache=yes
          demuxer-max-bytes=2G
          demuxer-max-back-bytes=1G

          background-color=#1e1e2e
          osd-back-color=#1e1e2e
          osd-border-color=#1e1e2e
          osd-color=#cdd6f4
          osd-shadow-color=#1e1e2e

          slang=enm,en,eng,de,deu,ger
          alang=ja,jp,jpn,en,eng,de,deu,ger
        '';

      }).wrapper
    ];
  };
}
