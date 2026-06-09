{ ... }:
{
  disko.devices.disk.system = {
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

  disko.devices.disk.data-a = {
    type = "disk";
    device = "/dev/disk/by-id/wwn-0x5000c50113b23351";
    content = {
      type = "gpt";
      partitions.zfs = {
        size = "100%";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
    };
  };

  disko.devices.disk.data-b = {
    type = "disk";
    device = "/dev/disk/by-id/wwn-0x5000c5011367abdf";
    content = {
      type = "gpt";
      partitions.zfs = {
        size = "100%";
        content = {
          type = "zfs";
          pool = "data";
        };
      };
    };
  };

  disko.devices.zpool.data = {
    type = "zpool";
    mode = "mirror";
    mountpoint = "/mnt/data";

    options = {
      ashift = "12";
    };

    rootFsOptions = {
      compression = "zstd";
      atime = "off";
      xattr = "sa";
      acltype = "posixacl";
      canmount = "noauto";
    };
  };
}
