{
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/lib/bluetooth"
      "/var/lib/fprint"
      "/var/lib/nixos"
      "/var/lib/systemd"
    ];

    files = [
      "/etc/machine-id"
    ];

    users.luke = {
      directories = [
        # XDG user directories
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
        "Configs"

        ".config/chromium"
        ".config/Code"
        ".config/discord"
        ".config/streamlink-twitch-gui"
        ".cache/streamlink-twitch-gui"
        ".mozilla"

        ".config/Beeper"
        ".ssh"
      ];

      files = [
        ".zsh_history"
        ".zshrc"
      ];
    };
  };
}
