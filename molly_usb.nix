{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Filesystem Configuration
  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos_usb";
      fsType = "ext4";
      label = "nixos_usb";
      options = "defaults,relatime,noatime,discard";
    };
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = "nosuid,nodev,relatime,mode=1777";
  };

  # No swap devices
  swapDevices = [ ];

  # Boot Options
  boot = {
    extraModulePackages = [ pkgs.linuxPackages.broadcom_sta ];
    initrd.availableKernelModules = [
      "ata_piix"
      "ahci"
      "ohci_pci"
      "ehci_pci"
      "xhci_hcd"
      "usb_storage"
    ];
    kernelParams = [ "elevator=noop" ];
    loader.grub = {
      version = 1;
      device = "/dev/disk/by-label/nixos_usb";
    };
  };

  networking = {
    hostName = "Molly";
    # To add a network run:
    # wpa_passphrase 'mynetwork' 'mypassphrase' | grep -v '#psk="' >> /etc/wpa_supplicant.conf
    wireless.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "ati" "nvidia" "intel" "cirrus" "vesa" ];
    synaptics = {
      enable = true;
      twoFingerScroll = true;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  nix.maxJobs = 4;

}
