#!/bin/bash

docker run -ti --gpus all --privileged=true $@  -v /root/.ssh:/root/.ssh -v $(pwd):/tensor -w /tensor tensor-dev:latest
