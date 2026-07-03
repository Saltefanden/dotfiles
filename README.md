# Dotfiles

Repository containing my dotfiles. 

## Git submodules

$ git clone --recurse-submodules URL

If you forgot then use:

$ git submodule update --init --recursive

## Stow

From the project directory, run:

	> stow .

to setup. Use:

	> stow -D .

to tear down.

easy peasy


## Window management on linux

requires dwmblocks 


## Arch packagelist update hook:

If system is primary keep an updated list of packages in the dotfiles repository by placing the following file as a hook in /etc/pacman.d/hooks/packagelist.hook

This 

``` 
[Trigger]
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
When = PostTransaction
Exec = /bin/sh -c '/usr/bin/pacman -Qqent > /home/nckl/dotfiles/pkglist.txt; /usr/bin/pacman -Qqemt > /home/nckl/dotfiles/AUR_list.txt'
```

