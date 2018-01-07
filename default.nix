#!/usr/bin/env nix-build

{ pkgs ? import <nixpkgs> {} }:
let generator = pkgs.stdenv.mkDerivation {
      name = "timput_com-generator";
      src = ./generator;
      phases = "unpackPhase buildPhase";
      buildInputs = [
        (pkgs.haskellPackages.ghcWithPackages (p: with p; [ hakyll ]))
      ];
      buildPhase = ''
        mkdir -p $out/bin
        ghc -O2 --make site.hs -o $out/bin/generator
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
