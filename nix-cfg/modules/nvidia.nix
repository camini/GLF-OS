{ config, ... }:
{
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = false;

      nvidiaSettings = false;
      modesetting.enable = true;
      dynamicBoost.enable = true;

      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        amdgpuBusId = "PCI:05:00:0";
        nvidiaBusId = "PCI:01:00:0";
        #sync.enable = true;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
