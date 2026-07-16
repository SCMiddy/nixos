{ self, inputs, ...}: {
  flake.wrapperModules.kitty = { config, lib, ... }: {
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    config = {
      args = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      settings = {
        enable_audio_bell = "no";

        font_size = 15;
        font_family = "JetBrainsMono Nerd Font";


        # ts not working
        themeFile = "Catpuccin-Macchiato";

        cursor_text_color = "background";

        allow_remote_control = "yes";
        shell_integration = "enabled";

        cursor_trail = 3;

        map = [
          "alt+1 goto_tab 1"
          "alt+2 goto_tab 2"
          "alt+3 goto_tab 3"
          "alt+4 goto_tab 4"
          "alt+5 goto_tab 5"
          "alt+6 goto_tab 6"
          "alt+7 goto_tab 7"
          "alt+8 goto_tab 8"
          "alt+9 goto_tab 9"
          "ctrl+shift+w close_tab"
          "ctrl+t new_tab_with_cwd"
          "ctrl+shift+t new_tab"
        ];

        background = "#242424";
        foreground = "#fbf1c7";

        cursor = "#fbf1c7";

        selection_foreground = "#504945"; 
        selection_background = "#3c3836";

        active_tab_foreground = "#b8bb26";
        active_tab_background = "#665c54";
        inactive_tab_background = "#3c3836";

        color0 = "#242424"; #bg
        color8 = "#504945";
        color1 = "#fb4934"; # red
        color9 = "#fb4934"; # red
        color2 = "#b8bb26"; # green
        color10 = "#b8bb26"; # green
        color3 = "#fabd2f"; # yellow
        color11 = "#fabd2f"; # yellow
        color4 = "#7daea3"; # blue
        color12 = "#7daea3"; # blue
        color5 = "#e089a1"; # magenta
        color13 = "#e089a1"; # magenta
        color6 = "#8ec07c"; # cyan
        color14 = "#8ec07c"; # cyan
        color7 = "#665c54";
        color15 = "#665c54";
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.mykTerm =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrapperModules.kitty];
      }).wrapper;
  };
}
