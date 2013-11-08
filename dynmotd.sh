#!/bin/env bash

# modified from http://parkersamp.com/2010/10/howto-creating-a-dynamic-motd-in-linux/

PROCCOUNT=`ps -Afl | wc -l`
PROCCOUNT=`expr $PROCCOUNT - 5`
GROUPZ=`groups`
 
if [[ $GROUPZ == *irc* ]]; then
ENDSESSION=`cat /etc/security/limits.conf | grep "@irc" | grep maxlogins | awk {'print $4'}`
PRIVLAGED="IRC Account"
else
ENDSESSION="Unlimited"
PRIVLAGED="Regular User"
fi
 
echo -e "\033[1;32m

# generate server name ascii art here: http://patorjk.com/software/taag/

\033[0;31mNOTICE: Unathorized use prohibited, all activity is logged.\033[0;31m
\033[0;35m+++++++++++++++++++++++: \033[0;37mSystem Data\033[0;35m :+++++++++++++++++++++++++
+      \033[0;37mHostname \033[0;35m= \033[1;32m`hostname -f`
\033[0;35m+  \033[0;37mIPv4 Address \033[0;35m= \033[1;32m<insert ipv4 address here>
\033[0;35m+  \033[0;37mIPv6 Address \033[0;35m= \033[1;32m`hostname -i`
\033[0;35m+        \033[0;37mKernel \033[0;35m= \033[1;32m`uname -r`
\033[0;35m+      \033[0;37mUp Since \033[0;35m= \033[1;32m`uptime --since`
\033[0;35m+           \033[0;37mCPU \033[0;35m= \033[1;32m8x Intel(R) Xeon(R) CPU E5-2670 @ 2.60GHz
\033[0;35m+      \033[0;37mFree RAM \033[0;35m= \033[1;32m`grep '^MemFree:' /proc/meminfo | awk '{ mem=($2)/(1024) ; printf "%0.0f MB\n", mem }'` of `grep '^MemTotal:' /proc/meminfo | awk '{ mem=($2)/(1024) ; printf "%0.0f MB\n", mem }'`
\033[0;35m++++++++++++++++++++++++: \033[0;37mUser Data\033[0;35m :++++++++++++++++++++++++++
+      \033[0;37mUsername \033[0;35m= \033[1;32m`whoami`
\033[0;35m+     \033[0;37mPrivlages \033[0;35m= \033[1;32m$PRIVLAGED
\033[0;35m+      \033[0;37mSessions \033[0;35m= \033[1;32m`who | grep $USER | wc -l` of $ENDSESSION MAX
\033[0;35m+     \033[0;37mProcesses \033[0;35m= \033[1;32m$PROCCOUNT of `ulimit -u` MAX
\033[0;35m+++++++++++++++++++: \033[0;37mHelpful Information\033[0;35m :+++++++++++++++++++++
+    \033[0;37mIRC Client \033[0;35m= \033[1;32mirssi
\033[0;35m+     \033[0;37mBox Admin \033[0;35m= \033[1;32mmitzip @ freenode
\033[0;35m+++++++++++++++++: \033[0;31mMaintenance Information\033[0;35m :+++++++++++++++++++
+\033[0;31m `cat /etc/motd-maint`
\033[0;35m+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
"
