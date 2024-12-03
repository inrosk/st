{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  packages = [ my.st ];

  buildInputs = [ ];

  shellHook = ''
    # .
  '';
}
