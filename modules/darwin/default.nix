{ user, ...}: { config, lib, pkgs, ... } :

let
  nix = import ../nix;
in
{
  nix = nix;
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      iosevka
      mplus-outline-fonts.githubRelease
    ];
  };
  
  homebrew = {
    enable = true;
    casks  = [
      "1password"
      "google-chrome"
      "istat-menus"
      "monodraw"
      "obsidian"
      "orbstack"
      "raycast"
      #"rectangle"
      "spotify"
      "vmware-fusion"
      "whatsapp"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  system.stateVersion = 4;

  users.users.${user.username} = {
    home = "/Users/${user.username}";
  };
}
