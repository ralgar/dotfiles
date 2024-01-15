#!/bin/bash

# This script simply fetches a password entry for USERNAME@HOSTNAME, from
#   the Bitwarden vault, and prints it to stdout for use by `ssh-add`.
#
# To use, export the following variables in your shell's environment:
#   - SSH_ASKPASS="$HOME/.ssh/get-pass.sh"
#   - SSH_ASKPASS_REQUIRE=force

password="$(bw get password "$USER@$(</etc/hostname)")"
printf "%s" "$password"
