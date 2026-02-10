{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "datamaite";
  version = "0.1.0";

  src = ../.;

  buildInputs = [ pkgs.bash ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/hello.sh $out/bin/datamaite
    chmod +x $out/bin/datamaite
  '';

  meta = with pkgs.lib; {
    description = "Simple Nix test package that prints a message";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
