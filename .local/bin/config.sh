#!/bin/bash
if [ $1 == "" ]
then
  echo "Digite nvim para abrir a configuração"
elif [ $1 == "nvim" ]
then
  $EDITOR ~/.config/nvim/init.vim
elif [ $1 == "polybar" ]
then 
  $EDITOR ~/.config/polybar/config.ini ~/.config/polybar/bars.ini ~/.config/polybar/modules.ini
elif [ $1 == "bspwm" ]
then 
  $EDITOR ~/.config/bspwm/bspwmrc
elif [ $1 == "sxhkd" ]
then
  $EDITOR ~/.config/sxhkd/sxhkdrc
elif [ $1 == "zsh" ]
then 
  $EDITOR ~/.zshrc
elif [ $1 == "dunst" ]
then
  $EDITOR ~/.config/dunst/dunstrc
elif [ $1 == "alacritty" ]
then
  $EDITOR ~/.config/alacritty/alacritty.yml
elif [ $1 == "picom" ]
then
  $EDITOR ~/.config/picom/picom.conf
fi

