# Copyright (C) 2013 The Android Open Source Project
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
USE_CAMERA_STUB := true

# inherit common defines for all qsd8k devices
-include device/htc/qsd8k-common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/htc/leo/BoardConfigVendor.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := htcleo

# Chipset
TARGET_ARCH_VARIANT_CPU := cortex-a8
TARGET_ARCH_VARIANT_FPU := neon
ARCH_ARM_HAVE_VFP := true

# Kernel
BOARD_KERNEL_CMDLINE := no_console_suspend=1 wire.search_count=5
BOARD_KERNEL_BASE := 0x11800000
BOARD_KERNEL_NEW_PPPOX := true
TARGET_KERNEL_SOURCE := kernel/htc/leo
TARGET_KERNEL_CONFIG := htcleo_defconfig
TARGET_PREBUILT_KERNEL := device/htc/leo/prebuilt/kernel

# FPU compilation flags
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_WLAN_DEVICE           := bcm4329
WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/bcm4329.ko"
WIFI_DRIVER_FW_PATH_STA     := "/vendor/firmware/fw_bcm4329.bin"
WIFI_DRIVER_FW_PATH_AP      := "/vendor/firmware/fw_bcm4329_apsta.bin"
WIFI_DRIVER_MODULE_ARG      := "iface_name=wlan firmware_path=/vendor/firmware/fw_bcm4329.bin nvram_path=/proc/calibration"
WIFI_DRIVER_MODULE_NAME     := "bcm4329"

# Radio
BOARD_HAVE_FM_RADIO := true
BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO

# RIL
BOARD_USE_NEW_LIBRIL_HTC := true

# HWA
TARGET_USES_GENLOCK     := true
TARGET_USES_16BPPSURFACE_FOR_OPAQUE := true
COMMON_GLOBAL_CFLAGS    += -DMISSING_GRALLOC_BUFFERS
COMMON_GLOBAL_CFLAGS    += -DREFRESH_RATE=60
TARGET_USE_OVERLAY      := false
TARGET_HAVE_BYPASS      := false
TARGET_USES_C2D_COMPOSITION := false
TARGET_GRALLOC_USES_ASHMEM := true
BOARD_ADRENO_DECIDE_TEXTURE_TARGET := true
COMMON_GLOBAL_CFLAGS    += -DEGL_TRACE

# Legacy
BOARD_USE_LEGACY_TRACKPAD := true
BOARD_USE_LEGACY_TOUCHSCREEN := true

# USB Mass Storage
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/usb_mass_storage/lun0/file

# Gps
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := leo
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 3200

# SSL
BOARD_USE_OPENSSL_ENGINE := true

# # cat /proc/mtd
# dev:    size   erasesize  name
#mtd0: 00100000 00020000 "misc"
#mtd1: 00500000 00020000 "recovery"
#mtd2: 00500000 00020000 "boot"
#mtd3: 0aa00000 00020000 "system"
#mtd4: 02c00000 00020000 "cache"
#mtd5: 0d900000 00020000 "userdata"

BOARD_BOOTIMAGE_PARTITION_SIZE     := 0x00500000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00500000
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 0x0de00000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 0x0c800000
BOARD_FLASH_BLOCK_SIZE := 131072

# Recovery
TARGET_PREBUILT_RECOVERY_KERNEL := device/htc/leo/prebuilt/recovery_kernel
