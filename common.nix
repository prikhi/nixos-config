{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  # Boot Options
  boot = {
    loader.grub = {
      enable = true;
    };
  };

  networking = {
    # Use interface names like wlan0 instead of wlp2s0
    usePredictableInterfaceNames = false;
  };

  hardware = {
    enableAllFirmware = true;
    # Enable Full Acceleration for 32-bit programs.
    opengl.driSupport32Bit = true;
    pulseaudio.enable = true;
    sane.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  time.timeZone = "US/Eastern";

  environment.systemPackages = with pkgs; [
    # System
    slim
    awesome

    # Vim
    vim_configurable
    vimPlugins.YouCompleteMe
    aspell
    aspellDicts.en
    hunspell
    mythes

    # CLI User Apps
    cowsay
    fortune
    gitAndTools.gitFull
    htop
    iftop
    mutt
    newsbeuter
    ranger
    remind
    screen
    taskwarrior
    w3m
    wyrd
    zsh

    # GUI User Apps
    chromium
    compton
    firefoxWrapper
    gimp
    keepassx
    mcomix
    pencil
    pidgin
    pidginotr
    pinta
    rtorrent
    scrot
    unclutter
    zathura

    # Audio / Video
    ffmpeg
    mpv
    vlc
    pavucontrol
    pasystray

    # Python
    python
    python27Packages.pip
    python27Packages.ipython
    python27Packages.virtualenv
    python27Packages.virtualenvwrapper
    python3

    # General Development
    chromedriver
    clang
    cmake
    gcc
    lua
    nasm
    nox
    pkgconfig
    selenium-server-standalone
    stdenv
    valgrind

    # Theming
    dina-font
    gtk_engines
    hicolor_icon_theme
    lxappearance

    # Utilities
    atool
    glibcLocales
    hddtemp
    libnotify
    linuxPackages.cpupower
    lm_sensors
    ntfs3g
    p7zip
    psmisc
    rsync
    sshfsFuse
    unzip
    upower
    wget
    xdg-user-dirs
    xdg_utils
    xlibs.mkfontdir
    xlibs.xcursorthemes
    xlibs.xev
    xlibs.xprop

  ];

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };

    vim = {
      python = true;
      netbeans = false;
      ftNixSupport = true;
    };
  };

  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;
  };

  services = {
    acpid.enable = true;
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    memcached.enable = true;
    psd = {
      enable = true;
      users = [ "prikhi" ];
    };

    postgresql = {
        enable = true;
        package = pkgs.postgresql93;
    };

    xserver = {
      enable = true;
      layout = "us";

      displayManager.slim = {
        enable = true;
        defaultUser = "prikhi";
        autoLogin = true;
      };

      desktopManager.xterm.enable = false;

      windowManager = {
        awesome.enable = true;
        default = "awesome";
      };
    };
  };

  users.extraUsers.prikhi = {
    createHome = true;
    home = "/home/prikhi";
    shell = "${pkgs.zsh}/bin/zsh";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCulOEw9YrhFSFITZyAgndRr953EdgjU782RPvvjoNci3ACJJ8BFvN+QgxznDHKhiC9yR+zC1R7caOtHCi3NI4WHGhGvoNxvEmdsV803Og1SayQDh34uWmPLzvRHJsejGpfbWVpa0YTI5h4A/yzU2s2NDy956cEMPlQdS0lTc+YwWBKcH/U8prhkRH5KQzq7OTNpuAQAISR9Ue1FvdcY/bjq3aE/0+XY/68Nebyw0d99LjmepKO2Ksm0E4zsGIQBdzrYQGNjkcWOnQDnXXNXGoqU2njQqrObcqm7a5GfXAJA0idqQuxOX3k5Wc7xZ7ldx9XUs2HOZ1YFr8eueZPXuK1 prikhi@Lucy"
    ];
  };

  nix = {
    useChroot = true;
    trustedBinaryCaches = [
      "http://hydra.nixos.org"
      "http://cache.nixos.org"
    ];

    binaryCaches = [
      "http://hydra.nixos.org"
      "http://cache.nixos.org"
    ];

  };

}
