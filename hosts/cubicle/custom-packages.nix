{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-todo
    gitcheck
    iecompanion
    ievms
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    bash-todo   = pkgs.callPackage ../../packages/bash-todo {};
    gitcheck    = pkgs.callPackage ../../packages/gitcheck {};
    iecompanion = pkgs.callPackage ../../packages/iecompanion {};
    ievms       = pkgs.callPackage ../../packages/ievms {};
  };
}
