{
  nix-colors,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./terminals/wezterm.nix
    #   ./fcitx5
    #   ./i3
    ./programs
    ./git.nix
    #   ./rofi
    #   ./shell
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "luke";
    homeDirectory = "/home/luke";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
