{
  flake.modules.nixos.jellyfin = { pkgs, ... }: {
    hardware.graphics.enable = true;

    environment.systemPackages = with pkgs; [
      jellyfin-mpv-shim
    ];

    systemd.tmpfiles.rules = [
      "d /media 0777 root root - -"
      "a+ /media - - - - d:u::rwx,d:g::rwx,d:m::rwx,d:o::rwx"
    ];

    services.jellyfin = {
      enable = true;
      openFirewall = false;

      hardwareAcceleration = {
        enable = true;
        type = "vaapi";
        device = "/dev/dri/renderD128";
      };

      transcoding = {
        enableHardwareEncoding = true;

        hardwareDecodingCodecs = {
          h264 = true;
          hevc = true;
          hevc10bit = true;
          vp9 = true;
          av1 = true;

          mpeg2 = false;
          vc1 = false;
          vp8 = false;
          hevcRExt10bit = false;
          hevcRExt12bit = false;
        };

        hardwareEncodingCodecs = {
          hevc = true;
          av1 = true;
        };

        throttleTranscoding = true;
      };
    };
  };
}
