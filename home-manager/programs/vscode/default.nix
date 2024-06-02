{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-marketplace; [
      akamud.vscode-theme-onedark
      akamud.vscode-theme-onelight
      coq-community.vscoq1
      eamodio.gitlens
      ms-vscode.sublime-keybindings
      justusadam.language-haskell
      mgt19937.typst-preview
      nvarner.typst-lsp
      richie5um2.vscode-sort-json
      skellock.just
      vscode-icons-team.vscode-icons
      kamadorueda.alejandra
      jnoortheen.nix-ide
    ];
    userSettings = import ./user-settings.nix;
  };
}
