# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  sekiroTheme = {
    splash = sekiroTheme.package + "/sekiro_2560x1440.png";
    package =
      pkgs.fetchFromGitHub
      {
        owner = "togawalk";
        repo = "sekiro-grub-theme";
        rev = "8224a6187f762f17a098fd2b3a4b134f5b577bbc";
        sha256 = "K43icoIZfP1NFAcGH0TKII/XjTuHkHKVEIiBjrliB6s=";
      }
      + "/Sekiro";
  };
  catppuccinTheme = {
    splash = catppuccinTheme.package + "/background.png";
    package =
      pkgs.fetchFromGitHub
      {
        owner = "catppuccin";
        repo = "grub";
        rev = "803c5df0e83aba61668777bb96d90ab8f6847106";
        sha256 = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
      }
      + "/src/catppuccin-mocha-grub-theme";
  };
  virtuaverseTheme = {
    splash = virtuaverseTheme.package + "/background.png";
    package =
      pkgs.fetchFromGitHub
      {
        owner = "Patato777";
        repo = "dotfiles";
        rev = "d6f96fa59327a936d335f01a7295815250f96ff7";
        sha256 = "18mra67kd20bld5zxlvb89ik8psr2pj0v9iaizqpd485sywgqwiq";
      }
      + "/grub/themes/virtuaverse";
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    plymouth.enable = true;
    kernelParams = ["quiet" "splash"];
    initrd.kernelModules = ["amdgpu"];

    loader = {
      timeout = -1;
      efi.canTouchEfiVariables = true;
      grub = {
        splashMode = "stretch";
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080";
        useOSProber = true;

        splashImage = catppuccinTheme.splash;
        theme = catppuccinTheme.package;
      };
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  # services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  # };

  services.xserver = {
    enable = true;
    displayManager = {
      # defaultSession = "none+awesome";
      defaultSession = "none+qtile";
      startx.enable = true;
    };

    windowManager.qtile.enable = true;

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };


  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.togawalk = {
    isNormalUser = true;
    description = "togawalk";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    plymouth
  ];

  fonts.fonts = with pkgs; [
    fira-code
    (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode" "UbuntuMono"];})
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      tumbler # generate thumbnails of images
      xfconf
      thunar-volman
    ];
  };

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
  system.stateVersion = "23.05"; # Did you read the comment?
}
