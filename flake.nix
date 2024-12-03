{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... }:
    let
      inherit (self) outputs;

      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      # pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});

      overlays = final: _prev: { my = outputs.packages."${final.system}"; };

      pkgs = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ overlays ];
        });
    in {
      packages = forAllSystems
        (system: { st = pkgs.${system}.callPackage ./st.nix { }; });

      devShells = forAllSystems (system: {
        default = pkgs.${system}.callPackage ./shell.nix { };
        # .
      });
    };
}
