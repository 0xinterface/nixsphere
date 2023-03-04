{ config, pkgs, pkgs-unstable, lib, libs, ... }:
{

  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  
  home.sessionVariables = {
    EDITOR = "nvim";
    CLICOLOR = 1;
    VAULT_ADDR = "https://vault.narwhl.dev";
  };
  home.packages = with pkgs; [
    gnupg
    age
    tmux
    wget
    bat
    btop
    gping
    cfssl
    qemu
    terraform
    vault
    packer
    neofetch # fancy system + hardware info
    iperf
    sops
    yubikey-manager
    vscode
    neovim
    exa
    tree
    # better du alternative
    du-dust
    ripgrep
    zbar
    # NOTE `nodejs` is installed on various machines separately, as a specific version is needed for remote VSC
    # TODO figure out how to install a specific version of nodejs only for VSC
    # nodejs # Node 18
    # (yarn.override { nodejs = nodejs-18_x; })


    python38
    jq
    go

    # compression
    zip
    lz4
    git

  ] ++ lib.optionals stdenv.isDarwin [
    coreutils # provides `dd` with --status=progress
    wifi-password
  ] ++ lib.optionals stdenv.isLinux [
    iputils # provides `ping`, `ifconfig`, ...
    tailscale
    libuuid # `uuidgen` (already pre-installed on mac)
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  programs.dircolors = {
    enable = true;
  };

}
