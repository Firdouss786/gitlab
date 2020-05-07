#!/bin/bash
#bundle exec puma -C config/puma.rb
#sleep 20s
echo "REDIS.flushdb" | rails c
echo "Search::IndexAll.new.perform" | rails c
#touch 1.txt
#tail -f 1.txt

