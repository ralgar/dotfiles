#!/bin/bash

# This script simply fetches a password entry for USERNAME@HOSTNAME, from
#   the Bitwarden vault, and prints it to stdout for use by `ssh-add`.

password="$(bw get password "$USER@$(</etc/hostname)")"
printf "%s" "$password"
