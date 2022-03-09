<!-- Project Title -->
# Dotfiles

A collection of my personal dotfiles for customizing *nix systems.



<!-- About the project -->
## About

![Project Screenshot](screenshots/preview.png)

These dotfiles are aimed at power users, with a heavy focus on working in the terminal.

**Some key features:**
* Intuitive, keyboard-driven window manager, with many useful widgets.
* Highly customized shell, including informative prompt and completions.
* Highly customized text editor, which strives to be IDE-like.
* Cohesive look and feel. All major elements use the same color scheme.
* Cleans up many of the scattered dotfiles in `$HOME`.

This repository is managed by [YADM (Yet Another Dotfiles Manager)](https://yadm.io), which is a Git wrapper for managing dotfiles.



<!-- Installation -->
## Installation

1. Clone this repository.
```sh
$ git clone --recurse-submodules https://github.com/ralgar/dotfiles.git
```
2. Manually install any dotfiles you want, with the exception of my Git config which should be discarded.



<!-- License -->
## License

Distributed under the GNU GPL-2.0 License. See `.github/LICENSE`, or the sidebar, for more info.



<!-- Acknowledgements -->
## Acknowledgements

Thanks to these amazing projects, which are used in these dotfiles:
* [Lain](https://github.com/lcpz/lain) - The code from which I hacked up the AwesomeWM widgets.
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - The incredible Zsh prompt.
