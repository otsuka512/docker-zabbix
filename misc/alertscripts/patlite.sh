#!/bin/bash

nhm_ip=$1
nhm_port=10000
subject=$2
options=""

if   [[ "$subject" =~ ^PROBLEM:.* ]]; then
  options="W\x20"
elif [[ "$subject" =~ ^OK:.* ]]; then
  options="W\x04"
fi

if [ ! -z $options ]; then
  echo -ne "$options" | nc -n $nhm_ip $nhm_port
fi
