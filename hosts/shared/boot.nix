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

  # Bootloader.
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

}
