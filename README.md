# DatamAIte

## Install non published version

nix profile install github:FreezyCGI/datamAIte?ref=main#datamaite

## Scheduled execution (NixOS)

Installing a package does not modify cron/system state in Nix. To run on a schedule, use the NixOS module from this flake.

```nix
# configuration.nix
{
  imports = [
    (builtins.getFlake "github:FreezyCGI/datamAIte?ref=main").nixosModules.default
  ];

  services.datamaite.enable = true;
  services.datamaite.schedule = "daily"; # systemd OnCalendar value
}
```

Apply:

```bash
sudo nixos-rebuild switch
systemctl status datamaite.timer
```
