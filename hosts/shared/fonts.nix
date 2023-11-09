{
  config,
  lib,
  pkgs,
  ...
}: {
  fonts.fonts = with pkgs; [
    noto-fonts-emoji
    fira-code
    cozette
    (nerdfonts.override {fonts = ["JetBrainsMono" "FiraCode" "UbuntuMono" "AnonymousPro" "Mononoki"];})
  ];
}
