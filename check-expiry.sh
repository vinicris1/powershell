#!/bin/bash
expdate=$(date --date $(whois "$1" | grep 'Registry Expiry Date:' | awk '{print $4}') +'%d-%m-%Y')

echo "$expdate $1"

