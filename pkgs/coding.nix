{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscode-fhs
  ];

  home-manager.users.luke.programs = {
    vscode = {
      enable = true;
      package = pkgs.vscodium;

      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions;
        [
          jnoortheen.nix-ide

          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          roman.ayu-next
          ms-vscode.cpptools
          #ms-python.python
          #ms-python.vscode-pylance
          #ms-azuretools.vscode-docker
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "mayukaithemevsc";
            publisher = "GulajavaMinistudio";
            version = "3.2.3";
            sha256 = "a0f3c30a3d16e06c31766fbe2c746d80683b6211638b00b0753983a84fbb9dad";
          }
        ];

      userSettings = {
        "workbench.iconTheme" = "catppuccin-macchiato";
        "workbench.colorTheme" = "Mayukai Semantic Mirage";

        "editor.fontFamily" = "'Fira Code', 'Droid Sans Mono', 'monospace', monospace";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "nixpkgs-fmt";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {"command" = ["nixpkgs-fmt"];};
          };
        };

        "git.enableCommitSigning" = true;
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 100;
      };
    };
  };
}
