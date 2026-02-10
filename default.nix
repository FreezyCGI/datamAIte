{ pkgs ? import <nixpkgs> {} }:
{
  datamaite = import ./nix/datamaite.nix { inherit pkgs; };
}
