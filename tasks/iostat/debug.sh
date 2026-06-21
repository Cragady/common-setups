# ps -eo pid,rss,cmd --sort=-rss | head -20

#### ??? Likely read the numbers and put them here
### ps -o pid,rss,cmd -p \
### 505240,509925,509926,509954,\
### 511590,511591,511652,\
### 516930,516931,516935,\
### 518192,518193,518198

# systemctl status copy-games.service
# pgrep -fa 'fpsync|rsync'
# DEBUG_COMMAND=$(pgrep -fa 'fpsync|rsync' | awk 'BEGIN { print "ps -o pid,rss,cmd -p \\" } { printf "%s,", $1; if(NR %4 == 0) print "\\" } END { print ";" }')
# DEBUG_COMMAND=$(pgrep -fa 'fpsync|rsync' | awk 'BEGIN { print "ps -o pid,rss,cmd -p \\" } { printf "%s,", $1; if(NR %4 == 0) print "\\" }')
# DEBUG_COMMAND=$( echo "$DEBUG_COMMAND" | tac | sed 's/\(,$\|,\\$\)//' | tac)
# echo "$DEBUG_COMMAND"
echo 'execute this: ps -o pid,rss,cmd -p <pidlist>'

PID_LIST=$(pgrep -fa 'fpsync|rsync' | awk '{ printf "%s,", $1 }' | sed 's/\(,$\|,\\$\)//')
# echo $PID_LIST

ps -o pid,rss,cmd --sort=-rss -p "$PID_LIST"
