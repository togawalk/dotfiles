# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../shared
  ];

  virtualisation.docker.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  # services.xserver = {
  #  layout = "us";
  #  xkbVariant = "";
  # };

  # services.cron = {
  #   enable = true;
  #   systemCronJobs = [
  #   "0,15,30,45 * * * * togawalk /home/togawalk/dotfiles/home/dotfiles/eww/scripts/weather_info --getdata >>/tmp/cron-is-alive"
  #   ];
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
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bc
    jq
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    plymouth
  ];

  # fonts.fonts = with pkgs; [
  #   noto-fonts-emoji
  #   fira-code
  #   cozette
  #   (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode" "UbuntuMono" "AnonymousPro" "Mononoki"];})
  # ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      tumbler # generate thumbnails of images
      xfconf
      thunar-volman
    ];
  };

  environment.sessionVariables = rec {
    PATH = [
      "/home/togawalk/.cargo/bin"
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
