#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*};
mount -o rw,remount /system;
ln -s /system/lib64/libncursesw.so.6.1 /system/lib64/libncursesw.so.6;
ln -s /system/lib64/libncursesw.so.6 /system/lib64/libncursesw.so;
ln -s /system/lib64/libncursesw.so.6.1 /system/lib64/libncurses.so.6.1;
ln -s /system/lib64/libncursesw.so.6 /system/lib64/libncurses.so.6;
ln -s /system/lib64/libncursesw.so /system/lib64/libncurses.so;
ln -s /system/lib64/libncurses.so.6.1 /system/lib64/libcurses.so.6.1;
ln -s /system/lib64/libncurses.so.6 /system/lib64/libcurses.so.6;
ln -s /system/lib64/libncurses.so /system/lib64/libcurses.so;
mount -o ro,remount /system;

# This script will be executed in late_start service mode
