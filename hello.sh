#!/usr/bin/env bash
nohup bash -lc 'while true; do echo "hello world"; sleep 60; done' >/tmp/backup.log 2>&1 &
echo $! > /tmp/datamaite-worker.pid
echo "Started background hello-world worker (pid: $(cat /tmp/datamaite-worker.pid), log: /tmp/datamaite.log)"
