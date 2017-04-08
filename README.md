# configuration.nix

NixOS configuration files.


## Repository Layout

### Backports

Packages copied from the [nixpkgs master](https://github.com/nixos/nixpkgs)
before being available in the configured channel.

### Dotfiles

Files copied to a user's home directory
(@see [`mne.nix`](https://github.com/mneudert/configuration.nix/blob/master/users/mne.nix)).

### Hosts

Full configuration based on hostname. Activates by replacing
`/etc/nixos/configuration.nix` with a symlink to the hosts configuration file.

### Packages

Packages not available in the official nixpkgs repository. Expect some hacks
to get it working without any care taken to make it look nice or adhere to
any quality standards.

### Shells

All locally available shells are placed here. The user `mne` has all shells from
the `generic` and `project` folder aliased for ease of use.

Templates are provided for copy & paste when something more extravagant is
required like starting a webserver or database. Includes moving all runtime
data (storage, configuration, ...) to the current working directory.

### System

Configuration at system level, like default locale.

### Users

Common user setup. Based on a `[username].[package].nix` naming.


## Caveats

This repository is intended to be placed under the path
`/data/projects/private/configuration.nix`. Placing it somewhere else will
break stuff.

Every host is connected to a file located in a companion repository
`/data/projects/secret/configuration.nix`. If you would have access to it you
would see private SSH keys, `/etc/hosts` configuration and the like. Just
ignore those ;)
