{
  pkgs,
  inputs,
  ...
}:

{
  prefix = pkgs.buildEnv {
    name = "system-nix-prefix";
    paths = [ inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };
  graphicsDrivers = pkgs.buildEnv {
    name = "system-nix-graphics-driver";
    paths = with pkgs; [
      mesa
      libvdpau-va-gl
      intel-media-driver
    ];
  };
}
