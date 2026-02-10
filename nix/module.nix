{ config, lib, pkgs, ... }:
let
  cfg = config.services.datamaite;
in
{
  options.services.datamaite = {
    enable = lib.mkEnableOption "datamaite scheduled job";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./datamaite.nix { };
      description = "The datamaite package to run.";
    };

    schedule = lib.mkOption {
      type = lib.types.str;
      default = "hourly";
      example = "*-*-* 03:00:00";
      description = ''
        systemd OnCalendar schedule for the datamaite timer.
        Examples: "hourly", "daily", "*-*-* 03:00:00".
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.datamaite = {
      description = "Run datamaite";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${cfg.package}/bin/datamaite";
      };
    };

    systemd.timers.datamaite = {
      description = "Schedule datamaite";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = cfg.schedule;
        Persistent = true;
      };
    };
  };
}
