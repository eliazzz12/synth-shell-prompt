#!/bin/bash

##  +-----------------------------------+-----------------------------------+
##  |                                                                       |
##  | Copyright (c) 2019-2020, Andres Gongora <mail@andresgongora.com>.     |
##  |                                                                       |
##  | This program is free software: you can redistribute it and/or modify  |
##  | it under the terms of the GNU General Public License as published by  |
##  | the Free Software Foundation, either version 3 of the License, or     |
##  | (at your option) any later version.                                   |
##  |                                                                       |
##  | This program is distributed in the hope that it will be useful,       |
##  | but WITHOUT ANY WARRANTY; without even the implied warranty of        |
##  | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         |
##  | GNU General Public License for more details.                          |
##  |                                                                       |
##  | You should have received a copy of the GNU General Public License     |
##  | along with this program. If not, see <http://www.gnu.org/licenses/>.  |
##  |                                                                       |
##  +-----------------------------------------------------------------------+

##
##	QUICK INSTALLER
##




##==============================================================================
##	INCLUDE DEPENDENCIES
##==============================================================================
[ "$(type -t include)" != 'function' ]&&{ include(){ { [ -z "$_IR" ]&&_IR="$PWD"&&cd $(dirname "${BASH_SOURCE[0]}")&&include "$1"&&cd "$_IR"&&unset _IR;}||{ local d=$PWD&&cd "$(dirname "$PWD/$1")"&&. "$(basename "$1")"&&cd "$d";}||{ echo "Include failed $PWD->$1"&&exit 1;};};}
include 'bash-tools/bash-tools/user_io.sh'
include 'bash-tools/bash-tools/hook_script.sh'
include 'bash-tools/bash-tools/assemble_script.sh'






##==============================================================================
##	SELECT SETUP LOCATION (PROMPT USER IF NEED BE)
##==============================================================================

## SWITCH BETWEEN AUTOMATIC AND USER INSTALLATION
if [ "$#" -eq 0 ]; then
	OUTPUT_SCRIPT="$HOME/.config/synth-shell/synth-shell-prompt.sh"
	OUTPUT_CONFIG_DIR="$HOME/.config/synth-shell"
	USER_CHOICE=""

elif [ "$#" -eq 2 ]; then
	OUTPUT_SCRIPT="$1"
	OUTPUT_CONFIG_DIR="$2"
	USER_CHOICE="y"

else
	printError "Wrong number of arguments passed to setup script"
	exit 1
fi

## CREATE HOOK
printInfo "Installing script as $OUTPUT_SCRIPT"
if [ -z "$USER_CHOICE" ]; then
	USER_CHOICE=$(promptUser "Add hook your .bashrc file or equivalent?\n\tRequired for autostart on new terminals" "[Y]/[n]?" "yYnN" "y")
fi
case "$USER_CHOICE" in
	""|y|Y )	hookScript $OUTPUT_SCRIPT ;;
	n|N )		;;
	*)		printError "Invalid option"; exit 1
esac






##==============================================================================
##	EMPLACE SCRIPT
##==============================================================================

## DEFINE LOCAL VARIABLES
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
INPUT_SCRIPT="$DIR/synth-shell-prompt/synth-shell-prompt.sh"
INPUT_CONFIG_DIR="$DIR/config"



## HEADER TO BE ADDED AT THE TOP OF THE ASSEMBLED SCRIPT
OUTPUT_SCRIPT_HEADER=$(printf '%s'\
	"##\n"\
	"##\n"\
	"##  =======================\n"\
	"##  WARNING!!\n"\
	"##  DO NOT EDIT THIS FILE!!\n"\
	"##  =======================\n"\
	"##\n"\
	"##  This file was generated by an installation script.\n"\
	"##  It might be overwritten without warning at any time\n"\
	"##  and you will lose all your changes.\n"\
	"##\n"\
	"##  Visit for instructions and more information:\n"\
	"##  https://github.com/andresgongora/synth-shell/\n"\
	"##\n"\
	"##\n\n\n")






##==============================================================================
##	EMPLACE CONFIGURATION FILES
##==============================================================================

## SETUP SCRIPT
assembleScript "$INPUT_SCRIPT" "$OUTPUT_SCRIPT" "$OUTPUT_SCRIPT_HEADER"



## SETUP CONFIGURATION FILES
[ -d "$OUTPUT_CONFIG_DIR" ] || mkdir -p "$OUTPUT_CONFIG_DIR"
cp -r "$INPUT_CONFIG_DIR/." "$OUTPUT_CONFIG_DIR/"



## SETUP DEFAULT SYNTH-SHELL-PROMPT CONFIG FILE
CONFIG_FILE="$OUTPUT_CONFIG_DIR/synth-shell-prompt.config"
if [ -f "$CONFIG_FILE" ]; then
	CONFIG_FILE="${CONFIG_FILE}.new"
fi

cp "$INPUT_CONFIG_DIR/synth-shell-prompt.config.default" "$CONFIG_FILE"
