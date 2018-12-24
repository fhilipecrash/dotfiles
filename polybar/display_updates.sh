#!/bin/bash
# File              : .config/polybar/display_updates.sh
# Author            : Morgareth <morgareth@tutanota.com>
# Date              : 10.08.2017
# Last Modified Date: 10.08.2017
# Last Modified By  : Morgareth <morgareth@tutanota.com>
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
   echo "$pac %{F#5b5b5b}%{F-} $aur"
fi

