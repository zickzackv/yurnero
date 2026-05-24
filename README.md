i# NixOS auf /dev/sda mit disko

Dieses Repo ersetzt Windows auf `/dev/sda` durch NixOS.
`/dev/sdb` bleibt unangetastet.

## Enthalten

- `flake.nix`: Flake-Einstiegspunkt
- `hosts/server/disko.nix`: GPT-Layout für `/dev/sda`
- `modules/base.nix`: Basis-Serverkonfiguration
- `modules/ssh.nix`: SSH-Setup mit Public-Key-Login
- `hosts/server/hardware-configuration.nix`: Platzhalter, vor Installation ersetzen

## Vorbereitungen

1. Public Key aus 1Password exportieren.
2. In `modules/ssh.nix` den Platzhalter-Key ersetzen.
3. Optional den Usernamen `admin` und den Hostnamen `server` anpassen.

## Geplanter Installationsablauf

### 1. Repo auf dem laufenden System bereitstellen

```bash
git clone <dein-repo> /root/nixos
cd /root/nixos
```

### 2. Sicherstellen, dass wirklich `/dev/sda` das Ziel ist

```bash
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT,MODEL
```

### 3. Partitionierung mit disko anwenden

```bash
sudo nix --experimental-features 'nix-command flakes' run github:nix-community/disko -- --mode disko ./hosts/server/disko.nix
```

### 4. Dateisysteme mounten und Hardware-Datei erzeugen

```bash
sudo mount /dev/disk/by-partlabel/root /mnt
sudo mount /dev/disk/by-partlabel/ESP /mnt/boot
sudo nixos-generate-config --root /mnt
```

Danach `/mnt/etc/nixos/hardware-configuration.nix` nach `hosts/server/hardware-configuration.nix` kopieren.

### 5. Installation aus der Flake

```bash
sudo nixos-install --flake .#server
```

### 6. Bootreihenfolge im UEFI prüfen

Nach der Installation sollte `systemd-boot` auf der EFI-Partition von `/dev/sda` liegen.
Gegebenenfalls `/dev/sda` im UEFI als erstes Boot-Ziel setzen.

## Nach dem ersten Boot

- Der Rechner sollte per SSH auf Port 22 erreichbar sein.
- Login mit dem User `admin` und deinem exportierten Public Key.
- Weitere NixOS-Generationen erscheinen im systemd-boot-Menü.

## Wichtige Hinweise

- Diese Konfiguration löscht `sda` vollständig.
- Vor dem Anwenden unbedingt prüfen, dass dort keine benötigten Daten mehr liegen.
- Für einen komplett headless Server ist ein testweiser erster Boot mit temporärem Monitor trotzdem sinnvoll.
