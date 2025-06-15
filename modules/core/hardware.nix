{ inputs, pkgs, ... }:
let
  hyprland-pkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;  # This enables 32-bit RADV support automatically
      package = hyprland-pkgs.mesa;
      
      # RADV (Mesa) drivers are included by default - no extra packages needed!
      # Only add these if you need specific functionality:
      extraPackages = with pkgs; [
        # Video acceleration (recommended)
        libva
        libva-utils
        
        # OpenCL support (optional)
        # mesa.opencl
        
        # Only add AMDVLK if you have specific compatibility needs
        # amdvlk  # <-- REMOVE THIS for better gaming performance
      ];
      
      # 32-bit support (RADV included automatically)
      extraPackages32 = with pkgs; [
        # Only add AMDVLK 32-bit if you specifically need it
        # driversi686Linux.amdvlk  # <-- REMOVE THIS too
      ];
    };
    
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  # Force RADV driver (this ensures RADV is used over AMDVLK if both present)
  environment.variables = {
    AMD_VULKAN_ICD = "RADV";  # Force Mesa RADV driver
    RADV_PERFTEST = "aco";    # Enable ACO compiler for better performance
  };

  # Games Drive Mount
  fileSystems."/mnt/Games" = {
    device = "/dev/disk/by-uuid/85840f0f-0427-4897-a7ea-8fab0ade043e";
    fsType = "ext4";
    options = [
      "defaults"
      "users" 
      "nofail"
      "x-gvfs-show"
    ];
  };

  powerManagement.cpuFreqGovernor = "performance";
}
