{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      overlay = prev: final: {
        libconfig = prev.libconfig.overrideAttrs {
          src = prev.fetchurl {
            url = "http://hyperrealm.github.io/libconfig/dist/libconfig-1.8.tar.gz";
            hash = "";
          };
        };
      };
      pkgs = nixpkgs.legacyPackages.x86_64-linux.extend overlay;
    in
    {
      packages.x86_64-linux = {
        inherit (pkgs) hello cowsay ffmpeg;
      };

      hydraJobs = {
        inherit (self)
          packages
          ;
      };
    };
}
