{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zip
    unzip
    beeper
    # utils
    # ripgrep
    # yq-go # https://github.com/mikefarah/yq
    # htop

    # misc
    # libnotify
    # wineWowPackages.wayland
    # xdg-utils
    # graphviz

    # productivity
    # obsidian

    # IDE
    insomnia

    # cloud native
    # docker-compose
    # kubectl

    nodejs
    nodePackages.npm
    nodePackages.pnpm
    yarn
    cura
    moonlight-qt
    # # db related
    # dbeaver
    # mycli
    # pgcli
  ];

  programs = {
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      extraConfig = "set-option -g mouse on";
    };

    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    ssh.enable = true;
    aria2.enable = true;

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
  services = {
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
