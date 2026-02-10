{ pkgs ? import <nixpkgs> {} }:
{
  hello-nix = import ./nix/hello.nix { inherit pkgs; };
}
