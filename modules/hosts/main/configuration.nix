{ self, inputs, ... }: {

  # Default.nix
  flake.nixosConfigurations.main = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMain
    ];
  };

  flake.nixosModules.hostMain = { pkgs, config, ... }: {
    imports = [
      self.nixosModules.mainHardware
#      inputs.home-manager.nixosModules.default

      self.nixosModules.niri
      self.nixosModules.gtk
#      self.nixosModules.kitty
    ];

    boot = {
      # BootLoader
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      kernelPackages = pkgs.linuxPackages_latest;
    };
    
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # note check Troubleshooting section of nixos.org wiki NVIDIA section for solution to suspend issue with gnome
    # Condsider moving to diff file
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [  "nvidia" ];

    programs.gamemode.enable = true;

    hardware.nvidia.open = true;
    hardware.nvidia.modesetting.enable = true;

    hardware.nvidia.prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;

      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];

    nix.settings.download-buffer-size = 524288000; #500 MiB * 5

#    home-manager = {
#      extraSpecialArgs = { inherit inputs; };
#      users = {
#        "robing" = import ./home.nix;
#      };
#    };

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Australia/Brisbane";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };

    # Enable Automounting
    services.udisks2.enable = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
#    services.displayManager.gdm.enable = true;
#    services.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "au";
      variant = "";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.robing = {
      isNormalUser = true;
      description = "Robin G";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      #  thunderbird
      ];
    };

    # Install firefox.
    programs.firefox.enable = true;
    
    programs.steam.enable = true;

    programs.git = {
      enable = true;
      config.user = {
        name = "SCMiddy";
        email = "robinzeki5@gmail.com";
      };
    };


    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      lshw
      gpustat
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      foot
      yazi
      spotify
      prismlauncher

      reaper
  
      bibata-cursors

      git
      lazygit

      discord
    #  wget
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

  };
}

