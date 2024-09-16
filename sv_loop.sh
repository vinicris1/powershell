#!/bin/bash

run_sv(){

	java @user_jvm_args.txt @libraries/net/minecraftforge/forge/1.18.2-40.2.21/unix_args.txt --nogui 2>&1 | tee -a server2.log  "$@"
	echo "$(date +"%T") Server crashed. Restarting" > server.log
}

while true; do
	run_sv
done
