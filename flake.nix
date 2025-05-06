{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      overlay = (prev: final: {
        libconfig = final.libconfig.overrideAttrs (old: {
          version = "1.8";
          src = final.fetchurl {
            url = "https://github.com/hyperrealm/libconfig/archive/refs/tags/v1.8.tar.gz";
            hash = "";
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

