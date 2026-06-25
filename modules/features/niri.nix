{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 0;

        outputs = {
          "eDP-1" = {
            mode = "1920x1080@144.149";
          };
          "Dell Inc. DELL AW2518HF KD1TF8890CNU" = {
            mode = "1920x1080@143.981";
          };
          "Dell P2421" = {
            mode = "1920x1200@60";
          };
        };
        
        layout = {
          focus-ring.off = _: {};
        };

        cursor = {
          xcursor-theme = "Bibata-Modern-Classic";
          xcursor-size = 20;
        };

        binds = {
          "Mod+Return".spawn-sh = "${lib.getExe self'.packages.mykTerm}";
          "Mod+Space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+L".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";

          "Mod+Q".close-window = _: {};
          "Mod+F".maximize-column = _: {};
          "Mod+G".fullscreen-window = _: {};
          "Mod+Shift+F".toggle-window-floating = _: {};
          "Mod+C".center-column = _: {};

          "Mod+O".toggle-overview = _: {};

          "Mod+Left".focus-column-left = _: {};
          "Mod+Right".focus-column-right = _: {};
          "Mod+Up".focus-window-up = _: {};
          "Mod+Down".focus-window-down = _: {};

          "Mod+Ctrl+Left".move-column-left = _: {};
          "Mod+Ctrl+Right".move-column-right = _: {};
          "Mod+Ctrl+Up".move-window-up = _: {};
          "Mod+Ctrl+Down".move-window-down = _: {};

          "Mod+Shift+Left".move-workspace-to-monitor-left = _: {};
          "Mod+Shift+Right".move-workspace-to-monitor-right = _: {};

          

          "Mod+1".focus-workspace = "w0";
          "Mod+2".focus-workspace = "w1";
          "Mod+3".focus-workspace = "w2";
          "Mod+4".focus-workspace = "w3";
          "Mod+5".focus-workspace = "w4";
          "Mod+6".focus-workspace = "w5";
          "Mod+7".focus-workspace = "w6";
          "Mod+8".focus-workspace = "w7";
          "Mod+9".focus-workspace = "w8";
          "Mod+0".focus-workspace = "w9";

          "Mod+Shift+1".move-column-to-workspace = "w0";
          "Mod+Shift+2".move-column-to-workspace = "w1";
          "Mod+Shift+3".move-column-to-workspace = "w2";
          "Mod+Shift+4".move-column-to-workspace = "w3";
          "Mod+Shift+5".move-column-to-workspace = "w4";
          "Mod+Shift+6".move-column-to-workspace = "w5";
          "Mod+Shift+7".move-column-to-workspace = "w6";
          "Mod+Shift+8".move-column-to-workspace = "w7";
          "Mod+Shift+9".move-column-to-workspace = "w8";
          "Mod+Shift+0".move-column-to-workspace = "w9";

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

          "Mod+WheelScrollDown".focus-column-left = _: {};
          "Mod+WheelScrollUp".focus-column-right = _: {};
          "Mod+Ctrl+WheelScrollDown".focus-workspace-down = _: {};
          "Mod+Ctrl+WheelScrollUp".focus-workspace-up = _: {};
        };
      };
    };
  };
}
