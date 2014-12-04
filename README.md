NixOS Configuration
====================

Right now this only contains the configuration for my NixOS persistant USB
installation.

Eventually it will be abstracted discrete laptop, desktop, persistant USB and
VM configurations.

Install
-------

I just make a symlink:

    cd /etc/nixos
    git clone http://bugs.sleepanarchy.com/nixos-config.git
    ln -s nixos-config/configuration.nix configuration.nix

But you'll probably want to override some options, so you could include a file
into in your own `configuration.nix`:

    imports = [
      ./nixos-config/configuration.nix
    ];

    boot.loader.grub.version = 1;
    . . .
