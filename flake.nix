{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
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
