{ config, pkgs, ... }:

{
  # Hybrid graphics: Intel UHD 630 (iGPU) + NVIDIA Quadro T2000 Mobile (Turing)
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # required by Steam / Proton / Wine
    extraPackages = with pkgs; [
      intel-media-driver # VA-API for the Intel iGPU
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;

    # Let the dGPU power down when idle (laptop battery)
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # PRIME render offload: desktop runs on Intel, games on NVIDIA via `nvidia-offload <cmd>`
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # from `lspci`: 00:02.0 Intel, 01:00.0 NVIDIA
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  boot.blacklistedKernelModules = [ "nouveau" ];
}
