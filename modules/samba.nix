{pkgs,...}:
{
services.samba = {
  enable = true;
  openFirewall = true;
  package = pkgs.samba4Full; # wichtig für Windows Discoverability

  settings = {
    "global" = {
      "workgroup" = "WORKGROUP";
      "server string" = "nas";
      "netbios name" = "nas";
      "security" = "user";
      "hosts allow" = "192.168.178. 127.0.0.1 localhost";
      "hosts deny" = "0.0.0.0/0";
      "guest account" = "nobody";
      "map to guest" = "bad user";
    };

    "public" = {
      "path" = "/mnt/tank/public";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
      "comment" = "Public share";
    };

    "familie" = {
      "path" = "/mnt/tank/family";
      "browseable" = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "valid users" = "fabian andrea";
      "create mask" = "0644";
      "directory mask" = "0755";
      "comment" = "Family share";
    };

    "andrea" = {
      "path" = "/mnt/tank/users/andrea";
      "browseable" = "no";
      "read only" = "no";
      "guest ok" = "no";
      "valid users" = "andrea";
      "create mask" = "0600";
      "directory mask" = "0700";
      "comment" = "Private share for andrea";
    };

    "fabian" = {
      "path" = "/mnt/tank/users/fabian";
      "browseable" = "no";
      "read only" = "no";
      "guest ok" = "no";
      "valid users" = "fabian";
      "create mask" = "0600";
      "directory mask" = "0700";
      "comment" = "Private share for admin";
    };
  };
};

services.samba-wsdd = {
  enable = true;
  openFirewall = true;
};
}
