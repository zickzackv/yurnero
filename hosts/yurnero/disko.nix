{...}: {
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
            mountOptions = ["umask=0077"];
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

  disko.devices.disk.tank-a = {
    type = "disk";
    device = "/dev/disk/by-id/wwn-0x5000c50113b23351";
    content = {
      type = "gpt";
      partitions.zfs = {
        size = "100%";
        content = {
          type = "zfs";
          pool = "tank";
        };
      };
    };
  };

  disko.devices.disk.tank-b = {
    type = "disk";
    device = "/dev/disk/by-id/wwn-0x5000c5011367abdf";
    content = {
      type = "gpt";
      partitions.zfs = {
        size = "100%";
        content = {
          type = "zfs";
          pool = "tank";
        };
      };
    };
  };

  disko.devices.zpool.tank = {
    type = "zpool";
    mode = "mirror";
    options.cachefile = "none";
    rootFsOptions = {
      compression = "zstd";
      atime = "off";
      xattr = "sa";
      acltype = "posixacl";
      "com.sun:auto-snapshot" = "false";
    };

    datasets = {
      # Dein NAS-Datenlayout
      "public" = {
        type = "zfs_fs";
        mountpoint = "/tank/public";
        options.mountpoint = "legacy";
        options.compression = "zstd";
      };

      "family" = {
        type = "zfs_fs";
        mountpoint = "/tank/familie";
        options.mountpoint = "legacy";
        options.compression = "zstd";
      };

      "users" = {
        type = "zfs_fs";
        mountpoint = null;
      };

      "users/andrea" = {
        type = "zfs_fs";
        mountpoint = "/tank/users/frau";
        options.mountpoint = "legacy";
        options.compression = "zstd";
      };

      "users/fabian" = {
        type = "zfs_fs";
        mountpoint = "/tank/users/fabian";
        options.mountpoint = "legacy";
        options.compression = "zstd";
      };

    };
  };
}
