{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";

    physfs_src.url = "https://icculus.org/physfs/downloads/physfs-3.0.2.tar.bz2";
    physfs_src.flake = false;
  };

  outputs = { self, nixpkgs, tinycmmc, physfs_src }:
    tinycmmc.lib.eachWin32SystemWithPkgs (pkgs:
      {
        packages = rec {
          default = physfs;

          physfs = pkgs.stdenv.mkDerivation {
            pname = "physfs";
            version = "3.0.2";

            src = physfs_src;

            nativeBuildInputs = [
              pkgs.buildPackages.cmake
            ];
          };
        };
      }
    );
}


