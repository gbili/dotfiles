#!/bin/sh

/sbin/ip -o -4 addr list | sed -n 2p | awk '{print $4}' | cut -d/ -f1
