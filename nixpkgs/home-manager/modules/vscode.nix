{ config, pkgs, pkgs-unstable, libs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      hashicorp.terraform
      eamodio.gitlens
      ms-vscode-remote.remote-ssh
      golang.go
      bbenoist.nix
      bradlc.vscode-tailwindcss
      esbenp.prettier-vscode
    ];
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
  };
}
