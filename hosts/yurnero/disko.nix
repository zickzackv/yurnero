{ ... }:
{
  disko.devices = {
    disk = {
      system = {
        type = "disk";
        device = "/dev/disk/by-id/ata-KINGSTON_SUV400S37480G_50026B7766031305";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              priority = 2;
              name = "nixos-root";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
