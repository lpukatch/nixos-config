{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-std.url = "github:chessai/nix-std";

    flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
    flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nur.url = "github:nix-community/NUR";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixpkgs-unstable,
    nixpkgs-stable,
    nix-colors,
    impermanence,
    nix-vscode-extensions,
    nur,
    alejandra,
    ...
  } @ inputs: let
    inherit (self) outputs;
    sharedConfig = hostname: nsystem:
      nixpkgs.lib.nixosSystem {
        system = nsystem;
        specialArgs = inputs;

        modules = [
          ./modules/nixos/common.nix
          ./pkgs/steam.nix
          ./hosts/${hostname}

          {networking.hostName = hostname;}
          impermanence.nixosModules.impermanence

          home-manager.nixosModules.home-manager
          {
            # home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs outputs;};
            home-manager.backupFileExtension = "bak";

            home-manager.users.luke = import ./home-manager;
          }
          # impermanence.nixosModule
          # { home-manager.users.luke.imports = [ impermanence.nixosModules.home-manager.impermanence ]; }

          # flake-programs-sqlite.nixosModules.programs-sqlite
          #stylix.nixosModules.stylix
          # chaotic.nixosModules.default

          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = nsystem;
                  config.allowUnfree = true;
                };
              })

              (final: prev: {
                stable = import nixpkgs-stable {
                  system = nsystem;
                  config.allowUnfree = true;
                };
              })
            ];
          }
        ];
      };
  in {
    nixosConfigurations = {
      laptop = sharedConfig "laptop" "x86_64-linux";
      desktop = sharedConfig "desktop" "x86_64-linux";
    };
  };
}
