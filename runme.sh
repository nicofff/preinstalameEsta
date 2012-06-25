#!/bin/bash
echo "Asegurate de tener el celular enchufado, y que este habilitada la Depuracion USB (Configurar -> Aplicaciones -> Desarrollo -> Depuracion de USB) y apreta Enter"
read -p ""
adb wait-for-device
echo "copiando archivos necesarios"
adb push rooted.prop /data/preinstall_md5/
adb push root.sh /data/preinstall_md5/
adb shell "ln -s /sys/kernel/uevent_helper /data/preinstall_md5/first.md5"
adb shell "ln -s /sys/class/mem/null/uevent /data/preinstall_md5/second.md5"
adb shell "chmod 777 /data/preinstall_md5/root.sh"
echo "Todos los archivos listos en el celular, ahora flashea el CG66 (sbf_flash -r --preinstall CG66.img romPersonal.sbf)"
echo "Para entrar en modo bootloader apaga el celular y reinicialo apretando el boton de power, el de la camara, y el de bajar el volumen"
echo "Una vez que entres en modo bootloader, ejecuta el sbf_flash"
echo "Apreta enter cuando se termine de flashear y reinicie"
read -p ""
adb wait-for-device
adb shell "echo 'entrando al adb, xq sino no funciona'"
echo "reiniciando"
adb reboot
adb wait-for-device
echo "Si los dioses de los bits estuvieron con nosotros, el celular deberia estar rooteado, persistiendo el root"
echo "Copiando Su, busybox y superuser.apk"
adb remount
adb push su /system/bin/su
adb shell "chmod 6755 /system/bin/su"
adb shell "ln -s /system/bin/su /system/xbin/su"
adb push busybox /system/xbin/busybox
adb shell "chmod 755 /system/xbin/busybox"
adb shell "/system/xbin/busybox --install /system/xbin"
adb push Superuser.apk /system/app/Superuser.apk
echo "Hecha la persistencia"
echo "limpiando"
adb shell "rm /data/preinstall_md5/*"
adb shell "echo /sbin/hotplug > /sys/kernel/uevent_helper"
echo "Ultima reiniciada (te lo prometo)"
adb reboot
adb wait-for-device
echo "Todo terminado :)"
adb kill-server
