{ config, pkgs, ...}:

{
  imports = [
    ./common.nix
  ];

  # Filesystem Configuration
  fileSystems."/" = {
      device = "/dev/disk/by-label/nexus_root";
      fsType = "ext4";
      label = "nexus_root";
    };

  # No swap devices
  swapDevices = [ ];

  boot = {
    initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" ];
    loader.grub = {
      version = 2;
      device = "/dev/sda";
    };
  };

  networking = {
    hostName = "Nexus";
    wireless.enable = false;
  };

  services = {
    virtualboxGuest.enable = true;
    xserver.videoDrivers = [ "virtualbox" ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  nix.maxJobs = 2;
}
