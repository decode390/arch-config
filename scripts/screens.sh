#!/bin/bash


PRIMARY_MONITOR="eDP-1"
SECONDARY_MONITOR="HDMI-1"
primary-only() {
    xrandr --output $SECONDARY_MONITOR --off --output $PRIMARY_MONITOR --auto
}

secondary-only() {
    xrandr --output $SECONDARY_MONITOR --auto --primary --output $PRIMARY_MONITOR --off
}

both(){
    xrandr --output $SECONDARY_MONITOR --auto --primary --output $PRIMARY_MONITOR --auto --${1} $SECONDARY_MONITOR
}

error-msg() {
    echo "Argument not valid, use -h for help"
    exit 1
}

help() {
    echo "Custom script to manage two screens"
    echo "	Syntax: screens [option]"
    echo "	Available options:"
    echo "		-p"
    echo "			(Primary) Set laptop monitor only"
    echo "		-s"
    echo "			Set secondary monitor only"
    echo "		-b[option]"
    echo "			Both monitors, with options:"
    echo "			l"
    echo "				Laptop monitor on left"
    echo "			r"
    echo "				Laptop monitor on right"
    echo "			u"
    echo "				Laptop monitor up"
    echo "			d"
    echo "				Laptio monitor down"
    echo ""
}


while getopts psb:h option; do
	case $option in
	    p) 
	        primary-only ;;
	    s)
		secondary-only ;;
	    b)
		case $OPTARG in
		    l)
			both left-of ;;
		    r)
			both right-of ;;
		    u)
			both above ;;
		    d)
			both below ;;
		    *)
			error-msg ;;
		 esac ;;
	    h)
		help ;;
	esac
done

