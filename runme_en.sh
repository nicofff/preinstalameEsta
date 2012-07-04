#!/bin/bash
echo __________                .__                 __         .__                        ___________         __          
echo \______   \_______   ____ |__| ____   _______/  |______  |  | _____    _____   ____ \_   _____/ _______/  |______   
echo  |     ___/\_  __ \_/ __ \|  |/    \ /  ___/\   __\__  \ |  | \__  \  /     \_/ __ \ |    __)_ /  ___/\   __\__  \  
echo  |    |     |  | \/\  ___/|  |   |  \\___ \  |  |  / __ \|  |__/ __ \|  Y Y  \  ___/ |        \\___ \  |  |  / __ \_
echo  |____|     |__|    \___  >__|___|  /____  > |__| (____  /____(____  /__|_|  /\___  >_______  /____  > |__| (____  /
echo                         \/        \/     \/            \/          \/      \/     \/        \/     \/            \/ 
echo      ___.                  .__              _____  _____  _____                                                     
echo      \_ |__ ___.__.   ____ |__| ____  _____/ ____\/ ____\/ ____\                                                    
echo       | __ <   |  |  /    \|  |/ ___\/  _ \   __\\   __\\   __\                                                     
echo       | \_\ \___  | |   |  \  \  \__(  <_> )  |   |  |   |  |                                                       
echo       |___  / ____| |___|  /__|\___  >____/|__|   |__|   |__|                                                       
echo           \/\/           \/        \/              

echo "Asegurate de tener el celular enchufado, y que este habilitada la Depuracion USB (Configurar -> Aplicaciones -> Desarrollo -> Depuracion de USB) y apreta Enter"
echo "Make sure you have your phone connected and USB debugging enabled, and press enter"
read -p ""
adb wait-for-device
echo "copying needed files"
adb push rooted.prop /data/preinstall_md5/
adb push root.sh /data/preinstall_md5/
adb shell "ln -s /sys/kernel/uevent_helper /data/preinstall_md5/first.md5"
adb shell "ln -s /sys/class/mem/null/uevent /data/preinstall_md5/second.md5"
adb shell "chmod 777 /data/preinstall_md5/root.sh"

echo "Without closing this window, shutdown the phone"
echo "and restart it in bootloader mode (power + UP key in the keyboard)"
echo "Once inside the bootloader mode, flash the fixed.sbf with sbf_flash"
echo "after it restarts, enable USB debugging and press enter to continue..." 
read -p ""

adb wait-for-device
adb shell "echo 'doing something on adb, otherwise it doesn't work'"
echo "restarting"
adb reboot
adb wait-for-device
adb remount
adb push su /system/bin/su
adb shell "chmod 6755 /system/bin/su"
adb shell "ln -s /system/bin/su /system/xbin/su"
adb push busybox /system/xbin/busybox
adb shell "chmod 755 /system/xbin/busybox"
adb shell "/system/xbin/busybox --install /system/xbin"
adb push Superuser.apk /system/app/Superuser.apk
adb shell "rm /data/preinstall_md5/*"
adb shell "echo /sbin/hotplug > /sys/kernel/uevent_helper"
adb reboot
adb wait-for-device
echo "Done"
adb kill-server
