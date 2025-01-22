#!/bin/sh

if ! command -v yay &> /dev/null; then
    echo "yay não está instalado. Instale o yay antes de executar este script."
    exit 1
fi

yay -S zsh ghostty pyenv nvm starship zsh-autosuggestions zsh-syntax-highlighting inetutils eza
