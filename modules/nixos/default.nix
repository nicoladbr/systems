{ user, ...}: { config, lib, pkgs, ... } :

let
  nix = import ../nix;
in
{
  imports = [
      ./hardware-configuration.nix
      ./vmware-guest.nix
  ];

  disabledModules = [ "virtualisation/vmware-guest.nix" ];

  nix = nix;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "proxima"; 
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";

      displayManager = {
	defaultSession = "none+i3";
	lightdm.enable = true;
	sessionCommands = '' 
	  ${pkgs.xorg.xset}/bin/xset r rate 200 40
	'';
      };

      windowManager.i3 = {
	enable = true;
	package = pkgs.i3-gaps;
	extraPackages = with pkgs; [
	  i3status 
	  i3lock 
   	  i3blocks
	];
      };
    };
  };

  users.users.${user.username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = user.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      dmenu
    ];
  };

  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      iosevka
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  programs.zsh.enable = true;

  virtualisation.vmware.guest.enable = true;

  system.stateVersion = "23.11";
}
