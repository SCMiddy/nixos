{
  flake.nixosModules.powersave = {pkgs, lib, ...}: {
    services.tlp.enable = true;
    services.thermald.enable = true;
    powerManagement.powertop.enable = true;

    services.lact.enable = true;
  };
}
