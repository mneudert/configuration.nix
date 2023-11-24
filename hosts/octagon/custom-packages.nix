{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ bash-todo gitcheck ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    bash-todo = pkgs.callPackage ../../packages/bash-todo { };
    gitcheck = pkgs.callPackage ../../packages/gitcheck { };
  };
}
