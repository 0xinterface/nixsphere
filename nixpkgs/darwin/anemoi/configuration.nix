{ pkgs, config, lib, ... }:
{
  services.nix-daemon.enable = true;

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults = {
    NSGlobalDomain.InitialKeyRepeat = 10;
    NSGlobalDomain.KeyRepeat = 1;
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    trackpad.TrackpadThreeFingerDrag = true;
    trackpad.Clicking = true;
  };
  users.users.admin = {
    home = "/Users/admin";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  users.users.root = {
    home = "/var/root";
    shell = "${pkgs.zsh}/bin/zsh";
  };
  
  programs.zsh.enable = true;

  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.admin = { pkgs, ... }: {
    home.stateVersion = "22.11";
    imports = [
      ../../home-manager/modules/git.nix
      ../../home-manager/modules/common.nix
      ../../home-manager/modules/zsh.nix
    ];
  };
  
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    casks = [
      "1password"
      "audio-hijack"
      "bartender"
      "cloudflare-warp"
      "figma"
      "iina"
      "istat-menus"
      "iterm2"
      "keka"
      "loopback"
      "raycast"
      "visual-studio-code"
      "transmit"
    ];
  };
  
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    inter
    fira-code
    (nerdfonts.override { fonts = [ "JetBrainsMono" "BitstreamVeraSansMono" ]; })
  ];
}
