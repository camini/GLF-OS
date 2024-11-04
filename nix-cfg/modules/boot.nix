{ pkgs, ... }:
{

  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      timeout = 3;
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
    # pkgs.linuxPackages 
    # pkgs.linuxPackages_zen 
    # pkgs.linuxPackages_xanmod_latest
  };
}
