build_dir=./hopmobile

tmp_dir=$(mktemp -d -t test-XXXX)
echo $tmp_dir
img_file=$tmp_dir/system.img
simg2img system.img $img_file
system_path=$tmp_dir/system
#echo mount $img_file $system_path
mkdir $system_path
mount $img_file $system_path
if [ -d $build_dir/media ]; then
  cp $build_dir/media/*.zip $system_path/media
  chmod 644 $system_path/media/*.zip
  echo copied bootanimation
fi
if [ -e $build_dir/build.prop ]; then
  cp $build_dir/build.prop $system_path/build.prop
  chmod 644 $system_path/build.prop
  echo copied build.prop
fi
if [ -d $build_dir/etc ]; then
  cp $build_dir/etc/apns-conf.xml $system_path/etc
  chmod 644 $system_path/etc/apns-conf.xml
  chcon u:object_r:system_file:s0 $system_path/etc/apns-conf.xml
  echo copied apns-conf.xml
fi
if [ -d $build_dir/apk ]; then
  for apk in $build_dir/apk/*.apk; do
     filename=$(basename -- "$apk")
     filename="${filename%.*}"
     dest=$system_path/priv-app/$filename
     if [ -d $dest ]; then
         cp $apk $dest/$(basename -- "$apk")
        chmod 644 $dest/$(basename -- "$apk")
        echo copied $apk
     fi
  done
fi
rm -r $system_path/priv-app/Launcher3_Singlelayer_Foursquares-aosp-debug

umount $system_path
cp $img_file raw_system.img
img2simg $img_file new_system.img
rm -r $tmp_dir

