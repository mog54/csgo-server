#!/bin/bash

# This file is part of Dedipanel project
#
# (c) 2010-2015 Dedipanel <http://www.dedicated-panel.net>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.

SCREEN_NAME="dp-9013315a368dbc2b9cc1"
STATUS=`ps aux | grep SCREEN | grep "$SCREEN_NAME " | wc -l`

# Try to get our IP from the system and fallback to the Internet.
# CHECK NAT
IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)

	


case "$1" in
    start)
        if [ $STATUS -eq 0 ]; then
            echo "starting "
            cd /home/p/serverfiles/
            
            screen -dmS $SCREEN_NAME taskset -c 0 ./srcds_run -game csgo +ip $IP -tickrate 128 +map de_mirage -port 27015 -console -usercon +game_type 0 +game_mode 1 +mapgroup mg_active -maxplayers_override 16
            echo "."
        else
            $0 restart
        fi
        
        exit ${?}
    ;;

    stop)
        if [ $STATUS -ne 0 ]; then
            echo "stopping"
            PID=`ps aux | grep SCREEN | grep "$SCREEN_NAME " | awk '{print $2}'`
            kill $PID
            echo "."
        fi

        exit ${?}
    ;;

    restart)
        $0 stop
        sleep 1
        $0 start $2 $3 $4

        exit ${?}
    ;;

    status)        
        if [ $STATUS -eq 0 ]; then
            echo "Not running."
        else
            echo "Started."
        fi
    ;;
    
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit ${?}
    ;;
esac
