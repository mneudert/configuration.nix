{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-todo
    gitcheck
    ievms
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    bash-todo = pkgs.callPackage ../../packages/bash-todo {};
    gitcheck  = pkgs.callPackage ../../packages/gitcheck {};
    ievms     = pkgs.callPackage ../../packages/ievms {};
  };
}
