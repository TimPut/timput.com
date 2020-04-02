#!/usr/bin/env nix-build
let
pinnedPkgs = import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-20.03";
  # Commit hash for nixos-20.03 as of Thu Apr 02 14:36:07 MDT 2020
  url = https://github.com/nixos/nixpkgs/archive/2f6440eb09b7e6e3322720ac91ce7e2cdeb413f9.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0vb7ikjscrp2rw0dfw6pilxqpjm50l5qg2x2mn1vfh93dkl2aan7";
}) {};
in

{ pkgs ? pinnedPkgs }:


let generator = pkgs.stdenv.mkDerivation {
      name = "timput-generator";
      src = ./generator;
      phases = "unpackPhase buildPhase";
      buildInputs = [
        (pkgs.haskellPackages.ghcWithPackages (p: with p; [ hakyll ]))
      ];
      buildPhase = ''
        mkdir -p $out/bin
        ghc -O2 -dynamic --make site.hs -o $out/bin/generator
      '';
    };
in pkgs.stdenv.mkDerivation {
     name = "timput_com-site";
     src = ./site;
     phases = "unpackPhase buildPhase";
     buildInputs = [ generator ];
     buildPhase = ''
       LANG=en_US.UTF-8 generator build
       mkdir $out
       cp -r _site/* $out
     '';
   }
