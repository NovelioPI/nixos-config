# configuration.nix - Main system configuration for the PC host
{ self, inputs, ...}:

let
  vars = import (self + "/vars.nix");
in
{
  flake.nixosModules.pcConfiguration = { config, pkgs, ... }:
  
  {
    imports =
      [
        self.nixosModules.pcHardware
        self.nixosModules.pcGnomeSettings
        self.nixosModules.cli
        self.nixosModules.dev
        self.nixosModules.vpn
        self.nixosModules.apps
        self.nixosModules.gaming
      ];

    # Enable experimental features for Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.systemPackages = with pkgs; [
      wget
      gnome-tweaks
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.plymouth.enable = true;
    boot.kernelParams = [ "quiet" "splash" "loglevel=3" ];
    boot.plymouth.theme = "bgrt";

    # Networking and Hostname
    networking.hostName = vars.hostname;
    networking.networkmanager.enable = true;

    time.timeZone = vars.timezone;

    i18n.defaultLocale = vars.locale;

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.flatpak.enable = true;

    hardware.graphics = {
      enable = true; # Enable hardware graphics acceleration
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [ vars.vgaType ];

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users."${vars.username}" = {
      isNormalUser = true;
      description = vars.fullName;
      extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
      packages = with pkgs; [];
    };

    programs.firefox.enable = true;
    nixpkgs.config.allowUnfree = true;
    
    # Do not change this value after the initial installation
    system.stateVersion = "25.11";
  };
}