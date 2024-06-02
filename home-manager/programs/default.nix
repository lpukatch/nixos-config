{
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [
    ./browsers.nix
    ./common.nix
    # ./git.nix
    # ./fonts.nix
    ./media.nix
    ./vscode
    ./zsh.nix
  ];
  nixpkgs = {
    overlays = [
      # outputs.overlays.additions
      # outputs.overlays.modifications
      inputs.nix-vscode-extensions.overlays.default
      # inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;

      permittedInsecurePackages = [
        "openssl-1.1.1w"
      ];
    };
  };
}
