#!/bin/bash

# Check for existing SSH keys
if [[ -f ~/.ssh/id_rsa && -f ~/.ssh/id_rsa.pub ]]; then
    echo "SSH key already exists."
else
    # Generate SSH key
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    echo "SSH key generated."
    
    # Add the SSH key to the ssh-agent
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

    echo "Copying the ssh key to the clipboard"
    cat ~/.ssh/id_rsa.pub | pbcopy
    echo "Click here and paste the key in the appropriate text box: https://github.com/settings/ssh/new"
fi