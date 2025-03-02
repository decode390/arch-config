#!/bin/bash

# pactl list sinks
# pactl list sources
# pactl list sink-inputs

MICRO=alsa_input.usb-Razer_Inc_Razer_Seiren_V2_X_UC2345L04500069-00.mono-fallback
HEADSETS=alsa_output.usb-TurtleBeach_Stealth_600X_Gen_2_MAX_0000000000000000-00.analog-stereo
RECORDER_HDMI=alsa_output.pci-0000_0b_00.1.hdmi-stereo
NULL_SINK_NAME=StreamingSink

pactl load-module module-null-sink sink_name=$NULL_SINK_NAME # Create the null-sink
pactl set-default-sink $NULL_SINK_NAME # Send all audio to null-sink (null-sink as default)
pactl set-default-source $MICRO # Set micro as default
pactl load-module module-loopback source="$MICRO" sink=$RECORDER_HDMI # Send micro to recorder output
pactl load-module module-loopback source="${NULL_SINK_NAME}.monitor" sink=$RECORDER_HDMI # Send null-sink to recorder output

pactl load-module module-loopback source="${NULL_SINK_NAME}.monitor" sink=$HEADSETS # Send null-sink to headsets

