#!/bin/sh
#
# Copyright (C) 2012 the cmhtcleo team
#

echo "updater-script: making compatible update script"
cd $REPACK/ota/META-INF/com/google/android

cat updater-script >> temp
rm -rf updater-script
grep -vw "unmount" temp > updater-script
rm -rf temp

echo 'package_extract_file("checksys.sh","/tmp/checksys.sh");' >> updater-script
echo 'set_perm(0, 0, 755, "/tmp/checksys.sh");' >> updater-script
echo 'run_program("/tmp/checksys.sh");' >> updater-script
echo 'if file_getprop("/tmp/nfo.prop","clk") == "true" then' >> updater-script
echo '  ui_print("cLK detected, using ppp for data connections");' >> updater-script
echo 'else' >> updater-script
echo '  ui_print("MAGLDR detected, using rmnet for data connections");' >> updater-script
echo '  delete("/system/ppp");' >> updater-script
echo 'endif;' >> updater-script
echo 'unmount("/system");' >> updater-script

echo "updater-script: copying checksys.sh"
cp $ANDROID_BUILD_TOP/device/htc/leo/releasetools/checksys.sh $REPACK/ota
