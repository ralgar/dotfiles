<!-- Project Title -->
# Dotfiles

A collection of my personal dotfiles for customizing *nix systems.



<!-- About the project -->
## About The Project

![Project Screenshot](screenshots/preview.png)

These dotfiles are aimed at power users, with a heavy focus on working in the terminal.

Some key features:
* Intuitive, keyboard-driven window manager, with many useful widgets.
* Highly customized shell, including informative prompt and completions.
* Highly customized text editor, which strives to be IDE-like.
* Cohesive look and feel. All major elements use the same color scheme.
* Cleans up many of the scattered dotfiles in `$HOME`.

And much more!

This repository is managed by [YADM (Yet Another Dotfiles Manager)](https://yadm.io), which is a Git wrapper for managing dotfiles.

### Built With

This repo contains dotfiles for the following projects:
* `alacritty`
* `awesome`
* `git`
* `gtk`
* `mpd`
* `ncmpcpp`
* `neofetch`
* `tmux`
* `ttf-meslo-nerd-font-powerlevel10k`
* `vim`
* `xorg`
* `yadm`
* `zsh`



<!-- Getting Started -->
## Getting Started

Simply install the [Prerequisites](#prerequisites), and follow the [Installation](#installation) instructions.

### Prerequisites

The only prerequisite is `yadm` (and its implicit `git`, of course).

**Note:** If you're not using an Arch-based system, you will need to install `ansible` as well.

### Installation

1. Clone the repo.
   ```sh
   yadm clone https://github.com/basschaser/dotfiles.git
   ```
2. Run the bootstrap sequence.
   ```sh
   yadm bootstrap
   ```



<!-- License -->
## License

Distributed under the GNU GPL-2.0 License. See `.github/LICENSE`, or the sidebar, for more info.



<!-- Acknowledgements -->
## Acknowledgements

Thanks to these amazing projects, which are used in these dotfiles:
* [Lain](https://github.com/lcpz/lain) - AwesomeWM Widgets
* [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh Prompt
