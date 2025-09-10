#!/bin/bash

# Get the ip address of the loadbalancer
endpoint=$(kubectl describe svc ingress-nginx-controller | grep IPs | cut -d ":" -f 2 | xargs)
total=0
schedulerv1_count=0
schedulerv2_count=0

while true; do
    response=$(curl -s "$endpoint/version")
    total=$((total + 1))

    if echo "$response" | grep -q "schedulerv2"; then
        schedulerv2_count=$((schedulerv2_count + 1))
    fi

    if echo "$response" | grep -q "schedulerv1"; then
        schedulerv1_count=$((schedulerv1_count + 1))
    fi

    schedulerv1_percent=$(awk "BEGIN {print ($schedulerv1_count / $total) * 100}")
    schedulerv2_percent=$(awk "BEGIN {print ($schedulerv2_count / $total) * 100}")
    printf "response: %-16s  |  schedulerv1:: %-16s  |  schedulerv2: %-16s\n" "$response" "$schedulerv1_percent%" "$schedulerv2_percent%"
    
done
