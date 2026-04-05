# flake.nix - The entry point of the NixOS configuration
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # Helper for wrapping modules and applications
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  # Generate flake outputs using flake-parts and import-tree
  outputs = inputs: inputs.flake-parts.lib.mkFlake 
    {inherit inputs;}
    (inputs.import-tree ./modules);
}
