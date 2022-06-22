#!/bin/bash
docker-compose pull

# generate node id and node key
OUTPUT=$(docker run --rm -it ghcr.io/subspace/node:gemini-1b-2022-jun-13 key generate-node-key)
NODE_KEY="${OUTPUT##*$'\n'}"

# generate chain spec
mkdir chain-spec
# TODO: ideally should use docker image, but currently works with binary
# docker run --rm -it ghcr.io/subspace/node:gemini-1b-2022-jun-13 \
./subspace-node-macos-x86_64-gemini-1b-2022-jun-13 \
  build-spec \
  --chain dev \
  --node-key $NODE_KEY \
  --raw > chain-spec/chain-spec.json

# start node and farmer
NODE_KEY=$NODE_KEY docker-compose up -d 
