#! /bin/bash
function version_lt() { test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" != "$1"; }
current=$(uname -r|tr '-' '.')
echo $current
expect=3.10.1.852.11.6.el7.x86_64
echo $expect
if version_lt $current $expect
then
	echo 'need update'
else
	echo 'now is new'
fi
