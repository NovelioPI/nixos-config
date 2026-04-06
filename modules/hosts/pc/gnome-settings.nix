{self, inputs, ...}: 

{
  flake.nixosModules.pcGnomeSettings = { config, pkgs, lib, ... }: 
  {
    services.desktopManager.gnome.extraGSettingsOverrides = ''
      # Accent color and dark mode preference
      [org.gnome.desktop.interface]
      accent-color='pink'
      color-scheme='prefer-dark'

      # Configure keyboard layouts
      [org.gnome.desktop.input-sources]
      sources=[('xkb', 'us'), ('ibus', 'mozc-jp')]
      show-all-sources=true

      [org.gnome.desktop.background]
      color-shading-type='solid'
      picture-options='zoom'
      picture-uri='file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg'
      picture-uri-dark='file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg'
      primary-color='#241f31'
      secondary-color='#000000'

      # GNOME Shell Extensions and Favorite Apps
      [org.gnome.shell]
      disabled-extensions=@as []
      enabled-extensions=['clipboard-indicator@tudmotu.com', 'warptoggle@mrvladus.github.io', 'tailscale-status@maxgallup.github.com', 'runcat@kolesnikov.se', 'blur-my-shell@aunetx', 'docker@stickman_0x00.com', 'search-light@icedman.github.com', 'paperwm@paperwm.github.com', 'pomodoro-timer@Oguzhankokulu.github.com', 'dash-to-dock@micxgx.gmail.com']
      favorite-apps=['org.gnome.Nautilus.desktop', 'google-chrome.desktop', 'antigravity.desktop', 'org.gnome.Console.desktop', 'com.github.dagmoller.whatsapp-electron.desktop', 'slack.desktop', 'obsidian.desktop']

      [org.gnome.shell.extensions.clipboard-indicator]
      display-mode=0  
      
      [org.gnome.shell.extensions.dash-to-dock]
      dock-position='BOTTOM'
      dash-max-icon-size=32

      [org.gnome.shell.extensions.paperwm]
      gesture-horizontal-fingers=3
      gesture-workspace-fingers=3
      horizontal-margin=10
      open-window-position=0
      restore-attach-modal-dialogs='true'
      restore-edge-tiling='true'
      restore-workspaces-only-on-primary='true'
      selection-border-radius-bottom=10
      selection-border-radius-top=10
      selection-border-size=5
      show-workspace-indicator=true
      vertical-margin=10
      vertical-margin-bottom=10
      window-gap=10

      [org.gnome.shell.extensions.runcat]
      invert-speed=true

      [org.gnome.shell.extensions.search-light]
      background-color=(0.20392157137393951, 0.20392157137393951, 0.21568627655506134, 1.0)
      border-radius=2.6210045662100456
      entry-font-size=0
      font-size=0
      popup-at-cursor-monitor=true
    '';

    environment.systemPackages = with pkgs; [
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.warp-toggle
      gnomeExtensions.tailscale-status
      gnomeExtensions.runcat
      gnomeExtensions.blur-my-shell
      gnomeExtensions.docker
      gnomeExtensions.search-light
      gnomeExtensions.paperwm
      gnomeExtensions.pomodoro-timer
      gnomeExtensions.dash-to-dock
    ];
  };
}