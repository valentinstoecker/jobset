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
          src = final.fetchFromGitHub {
            owner = "hyperrealm";
            repo = "libconfig";
            rev = "v1.8";
            hash = "sha256-Qb1R3qNqZby5/e6ckfcDJ5aT8shAA4f9VUhGyEiDoc8=";
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

