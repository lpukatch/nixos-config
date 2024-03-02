{
  inputs,
  system,
  nix-colors,
  alejandra,
  user,
  home-manager,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
  # pkgs = import inputs.nixpkgs {
  #   inherit system;
  #   # config = {
  #   #   allowUnfree = true;
  #   # };
  #   overlays = [
  #     (import ../overlays)
  #   ];
  # };
in {
  laptop = nixosSystem {
    inherit system;
    specialArgs = {inherit inputs nix-colors alejandra;};
    modules = [
      ../modules/nixos/common.nix
      ../hosts/laptop

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.luke = import ../home-manager;
      }
    ];
  };
  desktop = nixosSystem {
    # inherit pkgs system;
    specialArgs = {inherit inputs;};
    modules = [
      ./hosts/desktop
      ./modules/nixos/fonts.nix
      ./pkgs/steam.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.luke = import ../home-manager;
      }
    ];
  };
}
