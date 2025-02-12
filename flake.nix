{
  description = "basic helper-less zig flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages = rec {
          hello =
            let
              zigDeps = with pkgs; [ zig ponysay ];
            in pkgs.stdenv.mkDerivation {
                name = "hello";
                src = self;
                buildInputs = zigDeps;
                buildPhase = ''
                  export ZIG_GLOBAL_CACHE_DIR=$PWD/zig-cache
                  zig build-exe --name hello src/main.zig;
                '';
                installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
              };
          default = hello;
          docker = pkgs.dockerTools.buildImage {
            name = "hellllo";
            tag = "latest";
            copyToRoot = [hello pkgs.bash];
            config = {
              Cmd = [ "${hello}/bin/hello" ];
            };
          };
        };
      });
}
