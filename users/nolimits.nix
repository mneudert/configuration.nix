{ lib, ... }:

with lib;
{
  users.users.nolimits = {
    extraGroups = [ "users" ];
    isNormalUser = false;
    uid = 2000;
  };

  security.pam.loginLimits = [
    {
      domain = "nolimits";
      type = "soft";
      item = "nofile";
      value = "65536";
    }

    {
      domain = "nolimits";
      type = "hard";
      item = "nofile";
      value = "65536";
    }
  ];
}
