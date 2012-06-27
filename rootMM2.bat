@echo off
setlocal enabledelayedexpansion
color 0c
:restart
cd "%~dp0"

echo	          ######   #####   #####  #########                 
echo	          #     # #     # #     #     #                            
echo	          #     # #     # #     #     #                          
echo	          ######  #     # #     #     #                       
echo	          #  #    #     # #     #     #                       
echo	          #   #   #     # #     #     #                 
echo	          #    #   #####   #####      #           
echo	.                
echo	.                   °INSTALLER°
echo    .                     
echo    .                    BY

echo    .                 °LeitoOo°

pause
cls


color 0b
:restart
cd "%~dp0"


echo Waiting for Phone
adb wait-for-device

ADB devices
adb push rooted.prop /data/preinstall_md5/
 adb push root.sh /data/preinstall_md5/
 adb shell "ln -s /sys/kernel/uevent_helper /data/preinstall_md5/first.md5"
 adb shell "ln -s /sys/class/mem/null/uevent /data/preinstall_md5/second.md5"
 adb shell "chmod 777 /data/preinstall_md5/root.sh"




echo Sin cerrar la ventana del cmd, desconectar el celular , apagarlo 

echo y reinicialo apretando el boton de power, el de la camara, y el de bajar el volumen ;

echo Una vez que entres en modo bootloader planchar el fixed.sbf 

echo (esta dentro de "firmware.7z") mediante rsdlite

echo una vez que arranque, Activar la depuracion usb y conectar el celular, 

echo luego presionar enter para continuar con el proceso 
pause







echo Waiting for Phone
adb wait-for-device


adb shell "echo 'entrando al adb, xq sino no funciona'"
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
adb shell "echo '/sbin/hotplug > /sys/kernel/uevent_helper'"

adb reboot
adb wait-for-device
adb kill-server


echo    FIN

pause
