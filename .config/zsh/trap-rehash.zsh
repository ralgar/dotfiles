# Traps SIGUSR1, changing it to `rehash`
#   instead of terminating all zsh instances.
# This is triggered after pacman transactions.
TRAPUSR1() {
    rehash
}
