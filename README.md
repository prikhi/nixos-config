NixOS Configuration
====================

NixOS configuration files for a persistant USB install and a virtualbox VM.

Install
-------

I just make a symlink:

    cd /etc/nixos
    git clone http://bugs.sleepanarchy.com/nixos-config.git
    ln -s nixos-config/nexus_vm.nix configuration.nix

But if you want to override some options, you could include a file into in your
own `configuration.nix`:

    imports = [
      ./nixos-config/common.nix
    ];

    boot.loader.grub.version = 1;
    . . .
