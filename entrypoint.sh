#!/bin/sh
set -e

rm /api/tmp/pids/server.pid
#rails s -b 0.0.0.0

rails s -b 0.0.0.0 -e production