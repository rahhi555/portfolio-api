#!/bin/sh
set -e
# -fをつけないと存在しない時にエラーになる
rm -f /api/tmp/pids/server.pid
#rails s -b 0.0.0.0

rails s -b 0.0.0.0 -e production