{
  config,
  pkgs,
  ...
}: {

  imports = [
    ./boot.nix
    ./fonts.nix
    ./cron.nix
  ];

  networking.hostName = "coma"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.togawalk = {
    isNormalUser = true;
    description = "togawalk";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
  };

  virtualisation.docker.enable = true;

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
    LC_TIME = "en_US.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    python311
    python311Packages.pip
    bc
    jq
    vim
    git
    wget
    plymouth
  ];

  environment.sessionVariables = rec {
    PATH = [
      "/home/togawalk/.cargo/bin"
      "/home/togawalk/.local/bin"
    ];
  };


}
