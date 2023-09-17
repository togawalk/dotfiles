{
  config,
  pkgs,
  ...
}: {
  imports = [./dotfiles ./theming.nix];

  home = {
    username = "togawalk";
    homeDirectory = "/home/togawalk";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        catppuccin.catppuccin-vsc
        pkief.material-product-icons
        bbenoist.nix
        github.github-vscode-theme
        vscodevim.vim
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "minimal-icons";
          publisher = "jacobwgillespie";
          version = "1.1.1";
          sha256 = "Pe6kdDY2uzSbieWKSjehAc0DV2zzKHg3oydyVbWA2eo=";
        }
        {
          name = "gruvbox-concoctis";
          publisher = "wheredoesyourmindgo";
          version = "10.30.27";
          sha256 = "crjpGzJqjfVWcuO4kaGqtrs4Izhvh1QlWU7uurteLl8=";
        }
      ];
  };

  home.packages = with pkgs; [
    alejandra
    stylua
    lua-language-server
    fd
    cmake
    ripgrep
    lazygit
    gnumake
    yarn
    postman
    chromium
    imagemagick
    bat
    bottom
    btop
    cargo
    cava
    cmatrix
    delta
    emacs
    eww-wayland
    exa
    firefox
    fish
    foot
    gcc
    gimp
    go
    grim
    hyprland
    id3v2 # command line id3v2 tag editor
    imv # image viewer
    jq # sed for JSON data
    kitty
    krita
    libnotify
    mpd # music player daemon
    mpvpaper
    ncmpcpp
    neovim
    nix-prefetch-github
    nixfmt
    nodejs
    obs-studio
    obsidian
    pamixer # pulseaudio command line mixer
    pavucontrol
    pipes
    psmisc # killall
    python311
    python311Packages.pip
    qt5ct # Qt5 configuration tool
    slurp
    socat # useful for connecting applications inside separate boxes
    starship
    swww # wallpaper daemon for wayland
    transmission-gtk
    tree
    tree-sitter # parser generator tool
    tty-clock
    wl-clipboard
    wtype
    xdg-utils
    yt-dlp
    zathura # document viewer
    mpv
    (rofi-wayland.override {plugins = [rofi-emoji rofi-calc];})

    # mako
    p7zip
    unzip
    webcord
    telegram-desktop
  ];

  home.file.".icons/default".source = "${pkgs.capitaine-cursors-themed}/share/icons/Capitaine Cursors (Palenight) - White";

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
