{self, inputs, ...}: 

{
  flake.nixosModules.vpn = { pkgs, lib, ... }: 
  
  {
    # Enable the background services
    services.tailscale.enable = true;
    services.cloudflare-warp.enable = true;

    environment.systemPackages = with pkgs; [
      tailscale
      tailscale-systray
      cloudflare-warp
    ];

    # Open the firewall for Tailscale's default port
    networking.firewall.allowedUDPPorts = [ 41641 ];

    # Cloudflare WARP can sometimes struggle with strict reverse path filtering
    # This relaxes it slightly.
    networking.firewall.checkReversePath = "loose";
  };
}