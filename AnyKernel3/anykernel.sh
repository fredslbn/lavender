# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=SUPER.KERNEL LAVENDER 4.19 STANDARD
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
supported.versions=
'; } # end properties


# begin attributes
attributes() {
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;
} # end attributes


# shell variables
block=auto;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;


# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh && attributes;


# boot install
#dump_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk
split_boot;
if [ -f $split_img/ramdisk.cpio ]; then
  unpack_ramdisk;
fi;


#write_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
if [ -f $split_img/ramdisk.cpio ]; then
  repack_ramdisk;
fi;
flash_boot;
flash_dtbo;
## end boot install
