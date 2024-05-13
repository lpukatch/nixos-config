{
  config,
  inputs,
  lib,
  pkgs,
  alejandra,
  ...
}: {
  imports = [
    ../../system/packages.nix
  ];

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luke = {
    isNormalUser = true;
    description = "luke";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Experimental
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/unstable";
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Overpass" "FiraCode" "Noto"];})
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = ["Noto Emoji"];
      };
    };
    enableDefaultPackages = true;
  };
  environment.systemPackages =
    (with pkgs; [
      wget
      gimp
      git
      vscode
      git
      nix-output-monitor
    ])
    ++ [alejandra.defaultPackage.x86_64-linux];
  programs.zsh = {
    enable = true;
  }; # Bootloader.
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/luke/nixos-config";
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # KDE Plasma 6 is now available on unstable
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # nix.gc = {
  #   automatic = true;
  #   dates = "weekly";
  #   persistent = true;
  #   options = "--delete-older-than 7d";
  # };
  nix.settings.auto-optimise-store = true;

  system.stateVersion = "23.11";
}
