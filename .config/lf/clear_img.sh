#!/bin/sh

# this script was called for /usr/bin/lfwrapper.sh: image previer in LF
if [ -n "$FIFO_UEBERZUG" ]; then
	  printf '{"action": "remove", "identifier": "preview"}\n' >"$FIFO_UEBERZUG"
fi

