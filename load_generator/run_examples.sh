#!/usr/bin/env bash

# first install vegeta https://github.com/tsenart/vegeta/releases

# https://github.com/tsenart/vegeta

# max-workers ... number of cpu threads vegeta will use for the attack
# rate=0 ... generate requests as fast as possible - no limit

#echo no limit, 5 threads
#vegeta attack -targets=target_getProducts -rate=0 -max-workers=5 -duration=10s

echo 10/s
vegeta attack -targets=target_getProducts -rate=10 -max-workers=5 -duration=5s
#echo 100/s
#vegeta attack -targets=target_getProducts -rate=100 -max-workers=5 -duration=30s
#echo 500/s
#vegeta attack -targets=target_getProducts -rate=500 -max-workers=5 -duration=30s