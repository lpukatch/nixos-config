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
  ];
}
