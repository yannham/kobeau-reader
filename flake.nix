{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    ocp-koreader-kobo = {
      url = "https://storage.gra.cloud.ovh.net/v1/AUTH_2ac4bfee353948ec8ea7fd1710574097/kfmon-pub/OCP-KOReader-v2023.10.zip";
      flake = false;
    };
  };

  description = "Download and install KOReader on a Kobo device.";

  outputs = { self, nixpkgs, flake-utils, stdenv }:
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
          kobeau-reader = stdenv.mkDerivation {
            name = "kobeau-reader";
            src = ./install.sh;
            phases = ["installPhase"];
            installPhase = ''
              mkdir -p $out/bin
              cp -r $src/* $out/bin
              cp -r \${ocp-koreader-kobo}/KOReader $out/bin
            '';
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
