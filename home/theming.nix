# theming.nix
{ pkgs, ... }:
let
  catppuccin_name = "Catppuccin-Frappe-Standard-Blue-Dark";
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    size = "standard";
    variant = "frappe";
  };
in {
  gtk = {
    enable = true;

    theme = {
      name = catppuccin_name;
      package = catppuccin;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    font = {
      name = "JetBrainsMono NF";
      size = 13;
    };
  };

  home.file.".config/gtk-4.0/gtk.css".source =
    "${catppuccin}/share/themes/${catppuccin_name}/gtk-4.0/gtk.css";
  home.file.".config/gtk-4.0/gtk-dark.css".source =
    "${catppuccin}/share/themes/${catppuccin_name}/gtk-4.0/gtk-dark.css";

  home.file.".config/gtk-4.0/assets" = {
    recursive = true;
    source = "${catppuccin}/share/themes/${catppuccin_name}/gtk-4.0/assets";
  };
}
