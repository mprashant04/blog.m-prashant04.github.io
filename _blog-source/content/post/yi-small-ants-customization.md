+++
date = "2017-03-22T18:23:41+05:30"
title = "Xiaomi Yi Small Ants camera Hacks  & Customization"
draft = false
+++




Xiaomi Yi Small Ants is great comptact wifi camera suitable for general purpose home / office security or monitoring. Great thing about this camera is that it runs linux operating system which makes it fun to fiddle with it and customize as per your requirements.

Following command will give yoy version of linux running on your camera.


<pre><code>  # uname -a
  Linux (none) 3.0.8 #1 Wed Jan 30 16:56:49 CST 2017 armv5tejl GNU/Linux
</code></pre>




Camera firmware has been programmed to detect and run /temp/equip_test.sh file from micro-sd card card on camera startup. We can use this to customize your camera as per need. Following is the equip_test.sh script I have been using with my camera. Hope this helps you to customize your cameras as well.




## Steps
* Insert micro-sd card on your computer card reader
* Create 'temp' folder on the cars
* Create equip_test.sh file in this temp directory and add required script in it.
* Now insert this card in  your camera
* Power on the camera









## equip_test.sh script

To keep stuff understandable, I will explain this script in parts. (You just have to merge all following script snippets into single equip_test.sh file) 





### Initialization
Following is the first initiation part of the script. It sets required variables. Script log will be written in equip_test_logs.txt file

<pre><code>#!/bin/sh

# variable for sd card directory
dr='dirname $0'	
echo "running script...." > $dr/equip_test_logs.txt

# Variable for camera number, I have multiple cameras and this helps to identify them
CAM_NO=4
</code></pre>






### 'Only china' issue fix
Xiami have started marketing different versions for Chinese market and other countries. If you have bought China version of camera, then on startup camera will give audio warning "This camera can only be used in China" and it's pairing with mobile application will fail. Following script will fix this issue. I have experienced that you this fix each time camera firmware is updated.

<pre><code>echo "fixing only china issue" >> $dr/equip_test_logs.txt
	
cp /home/cloud $dr/cloud_original
strings /home/cloud | grep http  >> $dr/cloud_grep_original.txt

ps | grep /home/watch_process | grep -v "grep" | awk '{print $1}' | xargs kill -9
ps | grep /home/cloud | grep -v "grep" | awk '{print $1}' | xargs kill -9
sed -i  's|api.xiaoyi.com/v4/ipc/check_did|api.xiaoyi.cox/v4/ipc/check_did|g' /home/cloud

cp /home/cloud $dr/cloud_modded
strings /home/cloud | grep http  >> $dr/cloud_grep_modded.txt
</code></pre>


Following script snippet logs whole file system tree in the camera internal memory. While experimenting with camera (was trying to configure dropbox & google drive sync application), I copied a large (~ 5MB) file into the camera's bin folder. After this camera started misbehaving, it was failing to connect to the wifi. After extensive troubleshooting I remembered that I had coped something on it, and had to find it out. Used following script to log all files on the camera, and find & delete required files.

<pre><code>echo "logging file system tree...." >> $dr/equip_test_logs.txt

# log whole directory tree in filesystem.txt file
ls -R -l / >> $dr/filesystem.txt

# Once required files is detected, use following to delete them
rm -f file-name-to-be-deleted
</code></pre>





### Register new commands
Following script snippet creates my custom 'log' & 'reboot' commands in /bin folder. These commands are used in subsequent script. 'log' command logs messages into /tmp/hd1/logs folder (new log file is created each week). Such logs are useful for debug purpose when something goes wrong.

<pre><code>echo "settig up basic commands" >> $dr/equip_test_logs.txt

echo "#!/bin/sh" > /bin/log
echo "LOG_FILE=/tmp/hd1/logs/z_log-week-\$(date +\"%W\").txt  " >> /bin/log	
echo "mkdir /tmp/hd1/logs" >> /bin/log	
echo "echo \"[\$(date +\"%Y-%m-%d %H:%M:%S\")] \$1\"  >> \$LOG_FILE" >> /bin/log
chmod 777 /bin/log

echo "#!/bin/sh" > /bin/restart
echo "log \"soft restarting....\"" >> /bin/restart
echo "reboot" >> /bin/restart
chmod 777 /bin/restart	
</code></pre>





### Phone push notifications

I have programmed my cameras to send push notification on my Android phone (using ['Pushover'](https://pushover.net/) app) Pushover allows you to send notifications to your phone with help of simple curl command. You just have to pay small one time fee ($2-3 I guess) and create new Pushover account, and use your account token to send phone notifications. Following sctips creates 'pushnotify' system command which is used in other scripts to send notifications. Very useful to keep regular watch on your cameras, you don't want to wake up one fine day in event of emergency to find out that camera has been non-functioning for many days & you don't have camera recordings. 

<pre><code>echo "setting up pushnotify" >> $dr/equip_test_logs.txt

echo "#!/bin/sh" > /bin/pushnotify
echo "log \"push notification begin:  ($CAM_NO) \$1\"" >> /bin/pushnotify

# this is needed to run curl command, referenced from profile file which is executed on login, but not for cron job
echo "LD_LIBRARY_PATH=\"/home/bt:/home/libusr:/usr/local/lib:/usr/lib\"" >> /bin/pushnotify
echo "export LD_LIBRARY_PATH" >> /bin/pushnotify

echo "RESULT=\$(/home/curl --form-string \"token=your-token-here\" --form-string \"user=your-user-id-here\" --form-string \"message=($CAM_NO) \$1\" http://api.pushover.net/1/messages.json  2>&1)" >> /bin/pushnotify
echo "log \"push notification result: \$RESULT\"" >> /bin/pushnotify
chmod 777 /bin/pushnotify

</code></pre>




### Custom cron jobs

Following script snippet sets up cron job for restarting cameras every night (My experience says restarting camera daily keeps them relatively more stable). I have also written additional script ('auto_delete_old_files', this script file is present on SD card along with equip_test.sh file. Let me know if anyone need this script as well) to delete oldest video recordings in order to always keep at least 15-20% of SD card memory free. This script has been configured to run every hour. I know that camera automatically deletes oldest video files when running out of disk space, but I was facing occasional SD card corruption issue, hence thought of always keeping minimum 15% card space free. After this workaround never faced SD corruption issue.  

<pre><code>#Setup cron service on startup, also send "booted" push notification to your phone
echo "setting up cron" >> $dr/equip_test_logs.txt
echo "#!/bin/sh" > /etc/init.d/S89cron
echo "sleep 2m" >> /etc/init.d/S89cron
echo "log \"starting cron service on startup (if u don't see soft reboot log above, this means it is hard reset)\"" >> /etc/init.d/S89cron
echo "pushnotify \"booted\"" >> /etc/init.d/S89cron
echo "crond &" >> /etc/init.d/S89cron	
chmod 777 /etc/init.d/S89cron

rm -f /bin/auto_delete_old_files
mv $dr/auto_delete_old_files /bin/auto_delete_old_files
chmod 777 /bin/auto_delete_old_files

# create /var/spool/cron/crontabs directory
mkdir /var/spool
mkdir /var/spool/cron
mkdir /var/spool/cron/crontabs

# create cron config for root user
echo "# reboot each night 5:30 AM - 2.5 hrs = 3:00AM IST, keeping reboot time different than other cron tasks time" > /var/spool/cron/crontabs/root
echo "30 5 * * *      restart" >> /var/spool/cron/crontabs/root
echo "  " >> /var/spool/cron/crontabs/root
echo "# delete oldest videos each hour, if running low on disk space" >> /var/spool/cron/crontabs/root
echo "0 * * * *      /bin/auto_delete_old_files" >> /var/spool/cron/crontabs/root
chmod 666 /var/spool/cron/crontabs/root
</code></pre>





### Enable telnet
Automatically start telnet on camera startup

<pre><code>rm -f /etc/init.d/S88telnet
echo "setting up telnet" >> $dr/equip_test_logs.txt
echo "#!/bin/sh" > /etc/init.d/S88telnet
echo "telnetd &" >> /etc/init.d/S88telnet
chmod 755 /etc/init.d/S88telnet
</code></pre>



### Enable FTP
Following script will create 'ftp' command in camnera, whenever I need to access camera using FTP, I connect to it using telnet and run ftp command. If you need ftp to be always available, you can also start FTP during boot (like telnet above). Since I don't need ftp so often, I prefer to start it manually whenever required.

<pre><code>echo "setting up ftp" >> $dr/equip_test_logs.txt

rm -f /etc/init.d/S89ftp
echo "#!/bin/sh" > /bin/ftp
echo "nohup tcpsvd -u root -vE 0.0.0.0 21 ftpd -w / >> /dev/null 2>&1 &" >> /bin/ftp
chmod 755 /bin/ftp
</code></pre>




### Finish gracefully
Now following is last part of script, it just renames script to avoid repeated execution and reboots camera

<pre><code>mv $dr/equip_test.sh $dr/equip_test-moved.sh
echo "rebooting...." >> $dr/equip_test_logs.txt
reboot
</code></pre>