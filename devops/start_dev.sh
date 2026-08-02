#!/bin/bash

sh /usr/local/tomcat/bin/shutdown.sh

ps -ef | grep tomcat | grep -v grep | awk '{print $2}' | xargs kill -9

echo start...
sh /usr/local/tomcat/bin/startup.sh
echo sucess
exit