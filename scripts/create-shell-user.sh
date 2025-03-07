#!/bin/bash
set -e

# Read the shell user password from the secret
shell_user_password=$(< /run/secrets/shell-user-password)

# Create a shell user for interactive login
echo "Creating a shell user for interactive login..."
useradd -m -s /bin/bash dev
echo "dev:$shell_user_password" | chpasswd

echo "Shell user creation script completed."