{
  inputs = { nixpkgs.url = "nixpkgs/nixos-unstable"; };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      systems = [ "aarch64-linux" "x86_64-linux" ];
    in
    rec {

      # Generate iso configurations for each system
      iso = builtins.mapAttrs (name: config: config.config.system.build.isoImage) nixosConfigurations;
      # Generate nixosConfigurations for each system
      nixosConfigurations = builtins.foldl' (acc: system: acc // (nixosConfigurationsForAllSystems system)) { } systems;

      nixosConfigurationsForAllSystems = system: {
        "offline-installer-${system}" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;

          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix"
            ./nix-cfg/configuration.nix

            {
              nixpkgs.overlays = [
                (self: super: {
                  calamares-nixos-extensions = super.calamares-nixos-extensions.overrideAttrs (oldAttrs: {
                    patches = oldAttrs.patches or [ ] ++ [
                      ./patches/welcome.patch
                      ./patches/nixos.patch
                    ];
                  });
                })
              ];
            }

            ({ config, ... }: {
              isoImage = {
                contents = [
                  {
                    source = ./nix-cfg;
                    target = "/nix-cfg";
                  }
                ];
                includeSystemBuildDependencies = true; # ISO OFFLINE
                storeContents = [ config.system.build.toplevel ];
                squashfsCompression = "gzip -Xcompression-level 1";
              };
            })
          ];
        };
      };
    };
}
