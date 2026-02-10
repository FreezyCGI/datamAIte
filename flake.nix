{
  description = "datamAIte";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          datamaite = import ./nix/datamaite.nix { inherit pkgs; };
        in
        {
          inherit datamaite;
          default = datamaite;
        });

      apps = forAllSystems (system: {
        datamaite = {
          type = "app";
          program = "${self.packages.${system}.datamaite}/bin/datamaite";
        };
        default = self.apps.${system}.datamaite;
      });

      nixosModules.default = import ./nix/module.nix;
    };
}
