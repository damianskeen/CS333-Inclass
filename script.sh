#!/bin/bash


function pingsweep_cmd() 
{
	nodeFound=0
	nodeNotFound=0
	local base="onyxnode"
	ehco "Starting ping sweep..."
	for i in {1..200}; do
		ping -c 1 "${base}${i}" &> /dev/null
		if [ $? -eq 0 ]; then
			echo "${base}${i} is reachable."
			nodeFound=$((nodeFound+1))
		else
			echo "${base}${i} is not reachable."
			nodeNotFound=$((nodeNotFound+1))
		fi
	done
	echo "Found $nodeFound nodes reachable."
	echo "Found $nodeNotFound nodes not reachable."
}

cmd_help () 
{
	echo "Usage: pingsweep.sh -p"
	echo "Options:"
	echo "  -p    Perform a ping sweep of the lab nodes (onyxnode1 to onyxnode200)" 
}

function main() 
{
	while getopts ":ph" opt; do
		case $opt in
			p) pingsweep_cmd ;;
			h) cmd_help ;;
			/?) 
			echo "Invalid option: -$OPTARG" >&2
			cmd_help ;;
		esac
	done
	shift $((OPTIND -1))
}

##script entry point
if [$# -eq 0 ]; then
	cmd_help
else
	main "$@"
fi
