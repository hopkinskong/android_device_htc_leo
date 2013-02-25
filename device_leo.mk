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
# This file is the build configuration for a full Android
# build for leo hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit QSD8K Common
$(call inherit-product, device/htc/qsd8k-common/qsd8k.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/htc/leo/overlay

# Sensors & Lights & GPS
PRODUCT_PACKAGES += \
	sensors.htcleo \
	lights.htcleo \
	gps.htcleo

# Audio
PRODUCT_PACKAGES += \
	libaudioutils

# GPU
PRODUCT_PACKAGES += \
	liboverlay \
	libgenlock \
	libmemalloc \
	libtilerenderer \
	libQcomUI

# Omx
PRODUCT_PACKAGES += \
	libmm-omxcore

# Reference RIL
PRODUCT_PACKAGES += \
	leo-reference-ril

# Ramdisk
PRODUCT_COPY_FILES += \
	device/htc/leo/ramdisk/fstab.htcleo:root/fstab.htcleo \
	device/htc/leo/ramdisk/init.htcleo.rc:root/init.htcleo.rc \
	device/htc/leo/ramdisk/init.htcleo.usb.rc:root/init.htcleo.usb.rc \
	device/htc/leo/ramdisk/ueventd.htcleo.rc:root/ueventd.htcleo.rc \
	device/htc/leo/ramdisk/logo.rle:root/logo.rle

# Keylayouts and IDC
PRODUCT_COPY_FILES += \
	device/htc/leo/keylayout/htcleo-keypad.kl:system/usr/keylayout/htcleo-keypad.kl \
	device/htc/leo/keylayout/htcleo-keypad.kcm:system/usr/keychars/htcleo-keypad.kcm \
	device/htc/leo/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
	device/htc/leo/keylayout/htcleo-touchscreen.idc:system/usr/idc/htcleo-touchscreen.idc

# PPP files
PRODUCT_COPY_FILES += \
	device/htc/leo/ppp/ip-up:system/etc/ppp/ip-up \
	device/htc/leo/ppp/ip-down:system/etc/ppp/ip-down \
	device/htc/leo/ppp/ppp:system/ppp \
	device/htc/leo/ppp/options:system/etc/ppp/options

# Scripts
PRODUCT_COPY_FILES += \
	device/htc/leo/scripts/02usb_tethering:system/etc/init.d/02usb_tethering \
	device/htc/leo/scripts/10mic_level:system/etc/init.d/10mic_level \
	device/htc/leo/scripts/97ppp:system/etc/init.d/97ppp

# Vold
PRODUCT_COPY_FILES += \
	device/htc/leo/vold.fstab:system/etc/vold.fstab

# GPS Config
PRODUCT_COPY_FILES += \
     device/htc/leo/configs/gps.conf:system/etc/gps.conf
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# Modules
ifeq ($(USING_PREBUILT_KERNEL),)
PRODUCT_COPY_FILES += $(shell \
    find device/htc/leo/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')
endif

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# High-Density Res
PRODUCT_LOCALES += hdpi mdpi
PRODUCT_LOCALES := en_US

# Inherit Vendor
$(call inherit-product, vendor/htc/leo/leo-vendor.mk)

# Precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Discard inherited values and use our own instead.
PRODUCT_NAME := full_leo
PRODUCT_DEVICE := leo
PRODUCT_MODEL := Full Android on leo
