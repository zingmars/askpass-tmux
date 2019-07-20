#!/usr/bin/env bash

# This part of the script is run inside tmux
TIMEOUT=13 # in seconds
if [ "$1" == "get-consent" ]; then
	read -p "Allow the use of $3 (HASH: $4) - " -t"$TIMEOUT"
	if [ $? -eq 1 ]; then echo 1 >> "$2"; fi # The script timed out
	if [ "$REPLY" == "yes" ]; then echo "0" >> "$2";
	else echo "1" >> "$2"; fi
	exit 0
elif [ "$1" == "get-username" ]; then
	read -p "Please enter your username for $3 " -t"$TIMEOUT"
	if [ $? -eq 1 ]; then echo 1 >> "$2"; fi
	echo "$REPLY" >> "$2";
	exit 0
elif [ "$1" == "get-password" ]; then
	read -p "Please enter your password for $3 " -s -t"$TIMEOUT"
	if [ $? -eq 1 ]; then echo 1 >> "$2"; fi
	echo "$REPLY" >> "$2";
	exit 0
elif [ "$1" == "get-agent-password" ]; then
	read -p "Please enter password to unlock the ssh agent: " -s -t"$TIMEOUT"
	if [ $? -eq 1 ]; then echo 1 >> "$2"; fi
	echo "$REPLY" >> "$2";
	exit 0
fi

TMUX_SESSION=$(tmux list-sessions -F '#{session_name} #{session_attached,yes,}' | head)  # Get the first active session
TMP=$(mktemp --dry-run)
LOCATION="$(readlink -f $0)"

# Set up a communications channel between this instance and the one running in tmux using named pipes.
mkfifo -m=0600 "$TMP" || exit 2

# Launch the script in tmux
REPLY="1"
if [[ "$1" =~ ^Allow\ use\ of\ key ]]; then
	# Ask the user to confirm
	KEYNAME=$(echo $1 | cut -d " " -f 5)
	KEYHASH=$(echo $1 | cut -d " " -f 8)
	tmux split-window -v bash "$LOCATION" get-consent "$TMP" "$KEYNAME" "$KEYHASH"
elif [[ "$1" =~ ^Username\ for ]]; then
	DEST=$(echo $1 | cut -d " " -f 3)
	tmux split-window -v bash "$LOCATION" get-username "$TMP" "$DEST"
elif [[ "$1" =~ ^Password\ for ]]; then
	DEST=$(echo $1 | cut -d " " -f 3)
	tmux split-window -v bash "$LOCATION" get-password "$TMP" "$DEST"
else
	tmux split-window -v bash "$LOCATION" get-agent-password "$TMP"
fi
read REPLY < "$TMP"

rm -r "$TMP"

if [ "$REPLY" == "0" ] || [ "$REPLY" == "1" ]; then
	exit "$REPLY"
else
	echo "$REPLY"
	exit 0
fi
