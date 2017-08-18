#!/bin/sh

# defensively set PUBLIC_IP on container
# Expected output of this script is the public v4 IP

if type ip > /dev/null 2>&1; then
  # pick bonniernews ip
  PUBLIC_IP=$(ip -o a|grep -F 'inet 10.'|cut -d' ' -f7|cut -d'/' -f1|head -n1|xargs)
  if [ -z "$PUBLIC_IP" ]; then
    # fallback to dockers 172.xx ip
    PUBLIC_IP=$(ip -o a|grep -F 'inet 172.'|cut -d' ' -f7|cut -d'/' -f1|head -n1|xargs)
  fi
fi

if [ -z "$PUBLIC_IP" ]; then
  # no trix left. fallback to loopback
  PUBLIC_IP="127.0.0.1"
fi

echo $PUBLIC_IP
