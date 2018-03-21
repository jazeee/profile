#!/bin/bash
set -euo pipefail

if [[ "$#" -lt 1 ]]
then
  echo "Randomly throttles network requests using iproute"
  echo "Usage: $0 [INTERFACE]"
  echo "Credits: http://bencane.com/2012/07/16/tc-adding-simulated-network-latency-to-your-linux-server/"
  exit 1
fi

INTERFACE=$1; shift

echo "Remember to del the rule once done, otherwise you may have slow
network requests!"
echo "Run sudo tc qdisc del dev ${INTERFACE} root netem"

for i in `seq 1 1000`; do
  DELAY="$((1 + RANDOM % 100))ms"
  sudo tc qdisc add dev "${INTERFACE}" root netem delay "${DELAY}"
  sleep 0.2s
  sudo tc qdisc del dev "${INTERFACE}" root netem
done

