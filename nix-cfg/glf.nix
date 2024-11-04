{ lib, config, pkgs, ... }:

{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraPackages = with pkgs;[
      gamescope
    ];
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  
}
