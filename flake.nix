{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      overlay = (prev: final: {
        libconfig = prev.libconfig.overrideAttrs (old: {
          version = "1.8";
        });
      });
      pkgs = nixpkgs.legacyPackages.x86_64-linux.extend overlay;
    in
    {
      packages.x86_64-linux = {
        inherit (pkgs) hello cowsay ffmpeg libconfig;
      };

      hydraJobs = {
        inherit (self)
          packages
          ;
      };
    };
}

