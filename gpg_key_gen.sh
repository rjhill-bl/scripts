#!/bin/bash

# Check for existing GPG keys
existing_keys=$(gpg --list-secret-keys --keyid-format LONG)

if [[ -z "$existing_keys" ]]; then
    # Generate GPG key
    gpg --full-generate-key

    # List the GPG keys for which you have both a public and private key
    gpg --list-secret-keys --keyid-format LONG

    KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print substr($0,15,16)}' | head -1)

    # To get the GPG key ID
    echo "Copying GPG Key to clipboard"
    gpg --armor --export $KEY_ID | pbcopy
    echo "Click here and paste the key in the appropriate text field: https://github.com/settings/gpg/new"
    echo "After that run: git config --global user.signingkey ${KEY_ID}"
else
    echo "GPG key(s) already exists."
    gpg --list-secret-keys --keyid-format LONG
    KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | awk '{print substr($0,15,16)}' | head -1)
    echo "Next run: gpg --armor --export ${KEY_ID} | pbcopy"
    echo "Click here and paste the key in the appropriate text field: https://github.com/settings/gpg/new"
    echo "After that run: git config --global user.signingkey ${KEY_ID}"
fi