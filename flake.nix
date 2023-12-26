{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  description = "Download and install KOReader on a Kobo device.";

  outputs = { self, nixpkgs, flake-utils }:
    let
      SYSTEMS = [ "x86_64-linux" ];
    in
    flake-utils.lib.eachSystem SYSTEMS (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      rec {
        packages = {
          ocp-koreader-kobo = pkgs.stdenv.mkDerivation {
            name = "ocp-koreader-kobo";
            src = pkgs.fetchurl {
              url =
                "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KOReader-v2023.10.zip";
              sha256 = "sha256-/gc0x5CgwoMBjXvwTSbdl+2j38NhCjpH5GsvXApCDig=";
            };

            # We don't want Nix to try to unpack this zip file, as the script
            # expects it to stay unextracted.
            dontUnpack = true;

            installPhase = ''
              mkdir -p $out
              # Remove the heading store hash from the file name as the install
              # script relies a file name format
              cp  $src $out/''${src#*-}
            '';
          };

          kobeau-reader = pkgs.stdenv.mkDerivation {
            name = "kobeau-reader";
            src = ./install.sh;
            phases = [ "installPhase" ];
            installPhase = ''
              mkdir -p $out/bin
              cp  $src $out/bin/install.sh
              chmod +x $out/bin/install.sh

              # The install script requires the OCP-KOReader-vXXXX.XX.zip file
              # to be located in the same directory as the script
              ln -s ${packages.ocp-koreader-kobo}/* $out/bin/
            '';

            meta.mainProgram = "install.sh";
          };

          default = packages.kobeau-reader;
        };

        apps.default = {
          type = "app";
          program = pkgs.lib.getExe packages.kobeau-reader;
        };
      }
    );
}
