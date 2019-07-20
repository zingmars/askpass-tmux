Tmux-askpass
===

Based on [ssh-askpass-tmux](https://github.com/stronny/ssh-askpass-tmux).

When called, it opens a pane in the first active tmux instance it finds (if you only have one tmux instance active, that's the one you're using) and switches to it. Useful if you want to have ssh-agent verify each use of registered keys when forwarding your ssh-agent on a Linux system that doesn't have a GUI or, something like Mingw/Cygwin.

## Requirements

1. Tmux
2. Bash 4.0 or newer

## Usage

1. Place it somewhere accessable (i.e. `/opt/tmux-askpass` or `/usr/local/bin/tmux-askpass` etc.)
2. chmod 755 
3. Add the following to your shell's rc (replace `/location` with where you placed the script):
```
export SSH_ASKPASS="/location"
export DISPLAY=":0"
```
