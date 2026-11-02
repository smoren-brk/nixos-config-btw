# Loki's existing layout; used only to generate its mount configuration.
# Do not run Disko's destroy/format modes to adopt an existing installation.
{ inputs, ... }:
let
  disk = "/dev/disk/by-id/nvme-KINGSTON_SNV3S1000G_50026B76875ACBF6";
in
{
  flake.modules.nixos.host-loki = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.main = {
      type = "disk";
      device = disk;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            # Existing 1 GiB EFI partition; boundaries are in 512-byte sectors.
            start = "2048s";
            end = "2099199s";
            type = "EF00";
            label = "";
            device = "${disk}-part1";
            content = {
              type = "filesystem";
              format = "vfat";
              extraArgs = [
                "-F"
                "32"
                "-n"
                "NIXBOOT"
              ];
              mountpoint = "/boot";
              mountOptions = [
                "fmask=0022"
                "dmask=0022"
              ];
            };
          };
          root = {
            priority = 2;
            start = "2099200s";
            end = "1953521663s";
            # Linux x86-64 root partition, matching the current GPT type.
            type = "4f68bce3-e8cd-4db1-96e7-fbcaf984b709";
            label = "";
            device = "${disk}-part2";
            content = {
              type = "btrfs";
              extraArgs = [
                "-L"
                "NIXROOT"
              ];
              mountpoint = "/";
              # Mount the existing top-level subvolume; no separate home/nix subvolumes.
              mountOptions = [
                "subvol=/"
                "noatime"
                "compress=zstd"
                "ssd"
                "space_cache=v2"
              ];
            };
          };
        };
      };
    };
  };
}
