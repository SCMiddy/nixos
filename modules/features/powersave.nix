{
  flake.nixosModules.powersave = {pkgs, lib, ...}: {
    services.tlp = {
      enable = true;
      settings = {
        USB_AUTOSUSPEND = 0;
      };
    };

    services.thermald.enable = true;
#    powerManagement.powertop.enable = true;

    services.lact.enable = true;
  };
}
