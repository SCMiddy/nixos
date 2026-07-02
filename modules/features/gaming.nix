{ self, inputs, ...}: {
  flake.nixosModules.gaming = { pkgs, lib, ...}: {

    hardware.graphics.enable = lib.mkDefault true;

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;

      steam = {
        enable = true;
        protontricks.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      steam-run
      dxvk

      mangohud

      prismlauncher

      lsfg-vk
      lsfg-vk-ui
    ];
  };
}



