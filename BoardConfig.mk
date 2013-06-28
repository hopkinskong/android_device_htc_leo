# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
USE_CAMERA_STUB := false

# inherit common defines for all qsd8k devices
include device/htc/qsd8k-common/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := htcleo
TARGET_ARCH_VARIANT_CPU := cortex-a8
TARGET_ARCH_VARIANT_FPU := neon
ARCH_ARM_HAVE_VFP := true

# Kernel
TARGET_PREBUILT_KERNEL := device/htc/leo/prebuilt/kernel
TARGET_KERNEL_SOURCE := kernel/htc/leo
TARGET_KERNEL_CONFIG := leo_defconfig

# FPU compilation flags
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp

BOARD_KERNEL_CMDLINE := no_console_suspend=1 wire.search_count=5
BOARD_KERNEL_BASE := 0x11800000
BOARD_KERNEL_NEW_PPPOX := true

# Graphics
TARGET_USES_MDP3 := true
TARGET_USES_PMEM := true
BOARD_ADRENO_AVOID_EXTERNAL_TEXTURE := true
COMMON_GLOBAL_CFLAGS    += -DREFRESH_RATE=60

# Blank unused Wi-Fi configs
#WIFI_BAND                   :=
#BOARD_HOSTAPD_DRIVER        :=
#BOARD_HOSTAPD_PRIVATE_LIB   :=
#WIFI_DRIVER_FW_PATH_P2P     :=
#WIFI_DRIVER_FW_PATH_PARAM   :=
#BOARD_LEGACY_NL80211_STA_EVENTS := false

# Wi-Fi Configs
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WLAN_DEVICE           := bcm4329
WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/bcm4329.ko"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcm4329.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcm4329_apsta.bin"
WIFI_DRIVER_MODULE_ARG      := "iface_name=wlan firmware_path=/vendor/firmware/fw_bcm4329.bin nvram_path=/proc/calibration"
WIFI_DRIVER_MODULE_NAME     := "bcm4329"

# # cat /proc/mtd
# dev:    size   erasesize  name
#mtd0: 00100000 00020000 "misc"
#mtd1: 00500000 00020000 "recovery"
#mtd2: 00500000 00020000 "boot"
#mtd3: 0aa00000 00020000 "system"
#mtd4: 02c00000 00020000 "cache"
#mtd5: 0d900000 00020000 "userdata"

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00500000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00600000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 272629760
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x0c800000
BOARD_FLASH_BLOCK_SIZE := 131072



# GPS
#BOARD_USES_GPSSHIM := true
#BOARD_GPS_LIBRARIES := libgps librpc
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := htcleo
TARGET_QCOM_GPS_VARIANT  :=

# Ril
BOARD_USES_LEGACY_RIL := true

# Hacks
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/usb_mass_storage/lun0/file
BOARD_USE_LEGACY_TRACKPAD := true

# Recovery
#TARGET_PREBUILT_RECOVERY_KERNEL := device/htc/leo/prebuilt/recovery_kernel

# TWRP
#DEVICE_RESOLUTION := 480x800
#TW_EXTERNAL_STORAGE_PATH := "/sdcard"
#TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard"
