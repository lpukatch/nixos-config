{
  description = "NixOS configuration";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    home-manager = {
      url = github:nix-community/home-manager/release-23.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = github:the-argus/spicetify-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = github:misterio77/nix-colors;
    };

    nix-gaming = {
      url = github:fufexan/nix-gaming;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = github:Mic92/sops-nix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-shell.url = "github:Mic92/nixos-shell";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # vscode-server.url = github:nix-community/nixos-vscode-server;
    # nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    # nixos-vscode-server.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-colors,
    alejandra,
    ...
  } @ inputs: let
    inherit (self) outputs;

    system = "x86_64-linux";
    user = "luke";
  in {
    nixosConfigurations = import ./outputs/nixos.nix {inherit inputs system user nix-colors alejandra home-manager;};
    formatter = system: nixpkgs.legacyPackages.${system}.alejandra;
  };
  #     inherit (self) outputs;
  #     # Supported systems for your flake packages, shell, etc.
  #     systems = [
  #       "x86_64-linux"
  #     ];
  #     # This is a function that generates an attribute by calling a function you
  #     # pass to it, with each system as an argument
  #     forAllSystems = nixpkgs.lib.genAttrs systems;
  #   in {
  #     # Your custom packages
  #     # Accessible through 'nix build', 'nix shell', etc
  #     packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

  #     # Formatter for your nix files, available through 'nix fmt'
  #     # Other options beside 'alejandra' include 'nixpkgs-fmt'

  #     # Your custom packages and modifications, exported as overlays
  #     overlays = import ./overlays {inherit inputs;};
  #     # Reusable nixos modules you might want to export
  #     # These are usually stuff you would upstream into nixpkgs
  #     nixosModules = import ./modules/nixos;
  #     # Reusable home-manager modules you might want to export
  #     # These are usually stuff you would upstream into home-manager
  #     homeManagerModules = import ./modules/home-manager;

  #     # NixOS configuration entrypoint
  #     # Available through 'nixos-rebuild --flake .#your-hostname'
  # nixosConfigurations = {
  #       desktop = nixpkgs.lib.nixosSystem {
  #         specialArgs = {inherit inputs outputs nix-colors;};
  #         modules = [
  #           # > Our main nixos configuration file <
  #           ./hosts/desktop
  #           ./modules/nixos/fonts.nix
  #           ./pkgs/steam.nix
  #           {
  #             environment.systemPackages = [alejandra.defaultPackage.x86_64-linux];
  #           }
  #           home-manager.nixosModules.home-manager
  #           {
  #             home-manager.useGlobalPkgs = true;
  #             home-manager.useUserPackages = true;
  #             home-manager.users.luke = import ./home-manager;
  #           }
  #         ];
  #       };
  #     laptop = nixpkgs.lib.nixosSystem {
  #       specialArgs = {inherit inputs outputs nix-colors;};
  #       modules = [
  #         # > Our main nixos configuration file <
  #         ./hosts/laptop
  #         ./modules/nixos/fonts.nix
  #         {
  #           environment.systemPackages = [alejandra.defaultPackage.x86_64-linux];
  #         }
  #         home-manager.nixosModules.home-manager
  #         {
  #           home-manager.useGlobalPkgs = true;
  #           home-manager.useUserPackages = true;
  #           home-manager.users.luke = import ./home-manager;
  #         }
  #       ];
  #     };
  #   };
  # };
}
