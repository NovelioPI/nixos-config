# gaming.nix - Gaming optimizations and Steam setup
{self, inputs, ...}: 

{
  flake.nixosModules.gaming = { pkgs, lib, ... }: 
  
  {
    programs.steam.enable = true;
    programs.steam.gamescopeSession.enable = true;
    
    environment.systemPackages = with pkgs; [
      lutris
      pciutils
      mangohud
    ];  

    programs.gamemode.enable = true;    
  };
}