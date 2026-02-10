#!/usr/bin/env bash
nohup bash -lc 'while true; do echo "hello world"; sleep 60; done' >/dev/stdout 2>/dev/stderr &
echo "Started background hello-world worker"
