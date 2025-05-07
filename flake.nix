{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      overlay = prev: final: {
        libconfig = final.libconfig.overrideAttrs (old: {
          version = "1.8";
          src = final.fetchurl {
            url = "https://hyperrealm.github.io/libconfig/dist/libconfig-1.8.tar.gz";
            hash = "sha256-BR4V3Q6QfESQXzF5M/VIcxTypW6MZybIMEzpkIhIUKo=";
          };
        });
      };
      pkgs = nixpkgs.legacyPackages.x86_64-linux.extend overlay;
    in
    {
      packages.x86_64-linux = {
        inherit (pkgs)
          hello
          cowsay
          libconfig
          readline
          clang
          go
          ;
      };

      hydraJobs = {
        inherit (self)
          packages
          ;
      };
    };
}
