{ config, pkgs, lib, ... }:

{
  programs.steam = {
    enable = true;
    # Run Steam (and therefore every game it launches) on the NVIDIA dGPU
    # via PRIME offload — same env vars as the `nvidia-offload` script.
    package = pkgs.steam.override {
      extraEnv = {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
      };
    };
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # Performance tweaks: use `gamemoderun %command%` in Steam launch options
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite # X11 support under niri (Steam is an X11 app)
    mangohud
    protonup-qt
  ];
}
