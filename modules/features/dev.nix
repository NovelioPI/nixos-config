# dev.nix - Development environment and tools
{self, inputs, ...}: 

{
  flake.nixosModules.dev = { pkgs, lib, ... }: 
  
  {
    environment.systemPackages = with pkgs; [
      antigravity # Choose your own IDE
      dbeaver-bin
      docker
      docker-compose
      uv
      nodejs
    ];

    virtualisation.docker.enable = true;
  };
}