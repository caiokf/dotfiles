#!/bin/bash
# Install extensions for VS Code and Cursor
# Generate list: code --list-extensions | xargs -L 1 echo code --install-extension

extensions=(
    4ops.terraform
    christian-kohler.path-intellisense
    eamodio.gitlens
    EditorConfig.EditorConfig
    esbenp.prettier-vscode
    ms-azuretools.vscode-docker
    ms-python.python
    redhat.vscode-yaml
    shardulm94.trailing-spaces
    teabyii.ayu
)

# Install for VS Code if available
if command -v code &> /dev/null; then
    echo "Installing VS Code extensions..."
    for ext in "${extensions[@]}"; do
        code --install-extension "$ext" --force
    done
fi

# Install for Cursor if available
if command -v cursor &> /dev/null; then
    echo "Installing Cursor extensions..."
    for ext in "${extensions[@]}"; do
        cursor --install-extension "$ext" --force
    done
fi
