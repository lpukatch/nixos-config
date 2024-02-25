{
  pkgs,
  config,
  inputs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    neofetch
    htop
    btop
    lm_sensors
    unrar
    libnotify
    eza
    cowsay
    lsd
    lshw
    symbola
    material-icons
    brightnessctl
    networkmanagerapplet
    yad
    nh
  ];

  programs = {
    steam.gamescopeSession.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    # mtr.enable = true;
  };
}
