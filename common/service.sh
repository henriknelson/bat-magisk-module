#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*};

cp_man() {
   man_dir=$1;
   if [[ ! -d "/system/usr/share/man/$man_dir" ]]; then
      mkdir -p /system/usr/share/man/$man_dir;
   fi

   find $MODDIR/system/usr/share/man/$man_dir -type f -print | while read man_file; do
      cd $MODDIR;
      man_file=$(basename $man_file);
      #cp -f system/usr/share/man/$man_dir/$man_file /system/usr/share/man/$man_dir;
      chmod 644 /system/usr/share/man/$man_dir/$man_file;
   done
}

mount -o rw,remount /system;
mount -o rw,remount /system/usr/share;

ln -s /system/lib64/libncursesw.so.6.1 /system/lib64/libncursesw.so.6;
ln -s /system/lib64/libncursesw.so.6 /system/lib64/libncursesw.so;
ln -s /system/lib64/libncursesw.so.6.1 /system/lib64/libncurses.so.6.1;
ln -s /system/lib64/libncursesw.so.6 /system/lib64/libncurses.so.6;
ln -s /system/lib64/libncursesw.so /system/lib64/libncurses.so;
ln -s /system/lib64/libncurses.so.6.1 /system/lib64/libcurses.so.6.1;
ln -s /system/lib64/libncurses.so.6 /system/lib64/libcurses.so.6;
ln -s /system/lib64/libncurses.so /system/lib64/libcurses.so;

orig_dir=$(pwd);

for dir in $MODDIR/system/usr/share/man/man*/; do
    dir="${dir%/}";
    dir="${dir##*/}";
    cp_man $dir;
done

if [[ -s "/system/bin/mandoc" ]]; then
  makewhatis /system/usr/share/man;
fi

mount -o ro,remount /system/usr/share;
mount -o ro,remount /system;
