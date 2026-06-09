{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.power;
in {
  options = {
    modules.power.enable = mkEnableOption "laptop power management";
  };

  config = mkIf cfg.enable {
    powerManagement.enable = true;

    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
