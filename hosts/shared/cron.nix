{
  config,
  lib,
  pkgs,
  ...
}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
    "0,15,30,45 * * * * togawalk /home/togawalk/dotfiles/home/dotfiles/eww/scripts/weather_info --getdata >>/tmp/cron-is-alive"
    ];
  };
}
