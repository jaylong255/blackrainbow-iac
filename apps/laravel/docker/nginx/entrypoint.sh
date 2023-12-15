#!/usr/bin/env bash

echo 'Starting NGINX';
nginx -g 'daemon off;' 2>&1 &
NGINX_PID=$!

# Function to gracefully terminate NGINX
terminate_nginx() {
    echo "Terminating NGINX gracefully..."
    kill -15 $NGINX_PID
    wait $NGINX_PID
    exit $?
}

# Set up signal traps
trap terminate_nginx SIGTERM SIGINT

# Infinite loop for monitoring NGINX
while true; do
    if ! kill -0 $NGINX_PID 2>/dev/null; then
        echo "NGINX process has exited."
        exit 1
    fi

    sleep 60
done
