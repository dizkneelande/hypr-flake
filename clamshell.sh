#!/usr/bin/env bash

if grep -q open /proc/acpi/button/lid/LID/state; then
	hyprctl keyword monitor "eDP-1, enable"
else
	hyprctl keyword monitor "eDP-1, disable"
fi
