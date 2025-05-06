{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      overlay = (prev: final: {
        libconfig = prev.libconfig.overrideAttrs (old: {
          src = prev.fetchurl {
            url = "https://hyperrealm.github.io/libconfig/dist/libconfig-1.8.tar.gz";
            hash = "00000000000000000000000000000000000000000000000000000000";
          };
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

