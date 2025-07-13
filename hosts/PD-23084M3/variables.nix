{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "princedimond";
  gitEmail = "princedimond@gmail.com";

  # Hyprland Settings
  extraMonitorSettings = "
    monitor = DP-2,1920x1080@60,-1920x0,1
    monitor = eDP-1,1920x1080@60,0x0,1
    monitor = DP-1,1920x1080@60,1920x0,1
    ";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "microsoft-edge"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "kitty"; # Set Default System Terminal
  keyboardLayout = "us";
  consoleKeyMap = "us";

  # For Nvidia Prime support
  intelID = "PCI:1:0:0";
  nvidiaID = "PCI:0:2:0";

  # Enable NFS
  enableNFS = true;

  # Enable Printing Support
  printEnable = true;

  # Set Stylix Image
  stylixImage = ../../wallpapers/nix-wallpaper-stripes-logo.png;

  # Set Waybar
  # Includes alternates such as waybar-curved.nix & waybar-ddubs.nix
  #waybarChoice = ../../modules/home/waybar/waybar-simple.nix;
  waybarChoice = ../../modules/home/waybar/waybar-ddubs.nix;

  # Set Animation style
  # Available options are:
  # animations-def.nix  (default)
  # animations-end4.nix (end-4 project)
  # animations-dynamic.nix (ml4w project)
  animChoice = ../../modules/home/hyprland/animations-def.nix;

  # Enable Thunar GUI File Manager
  thunarEnable = true;
}
