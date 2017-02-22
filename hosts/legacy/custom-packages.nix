{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-todo
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    bash-todo = pkgs.callPackage ../../packages/bash-todo {};
  };
}
