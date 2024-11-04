{
  imports = [
    ./hardware-configuration.nix

    ./modules/nh.nix
    ./modules/boot.nix
    ./modules/users.nix
    ./modules/fstrim.nix
    ./modules/network.nix
    ./modules/security.nix
    ./modules/pipewire.nix
    ./modules/bluetooth.nix
    ./modules/configuration.nix
  ];
}
