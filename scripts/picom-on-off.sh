process=$(ps -aux | grep picom | grep "Sl")
if [[ -z $process ]]; then
	picom &
else
    killall picom &
fi