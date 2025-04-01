#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

# Initialize ROM manifest
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs

# cloning device tree
git clone https://github.com/EVOX-MOJITO-QPR2/device_xiaomi_mojito.git --depth 1 -b Evo-15 device/xiaomi/mojito
git clone https://github.com/EVOX-MOJITO-QPR2/android_device_xiaomi_sm6150-common.git --depth 1 -b Evo-15 device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/Sachinpawar86/kernel_xiaomi_mojito.git --depth 1 -b Evo-15 kernel/xiaomi/mojito

# cloning vendor tree
git clone https://github.com/EVOX-MOJITO-QPR2/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://github.com/EVOX-MOJITO-QPR2/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/EVOX-MOJITO-QPR2/android_hardware_xiaomi_mojito.git --depth 1 -b mojito hardware/xiaomi

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Set up build environment
source build/envsetup.sh
echo "====== Envsetup Done ======="

# Lunch
lunch lineage_mojito-bp1a-user
echo "============="

# Make cleaninstall
make installclean
echo "============="

# Build rom
m evolution