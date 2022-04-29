#!/bin/bash
# Copyright (c) 2021 by profzei
# Licensed under the terms of the GPL v3

LINK=$1
# https://github.com/acidanthera/OpenCorePkg/releases/download/0.7.9/OpenCore-0.7.9-RELEASE.zip
VERSION=$2
# 0.7.9


if ! command -v wget &> /dev/null
then
    echo "Please install wget"
    exit
fi

if ! command -v sbsign &> /dev/null
then
    echo "Please install sbsigntools"
    exit
fi

mkdir Signed
mkdir Signed/Drivers
mkdir Signed/Tools

# Download and unzip OpenCore
wget $LINK
unzip "OpenCore-${VERSION}-RELEASE.zip" "X64/*" -d "./Downloaded"
rm "OpenCore-${VERSION}-RELEASE.zip"

# Download HfsPlus
wget https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/HfsPlus.efi -O ./Downloaded/HfsPlus.efi
wget https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/ExFatDxe.efi -O ./Downloaded/ExFatDxe.efi
wget https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/btrfs_x64.efi -O ./Downloaded/btrfs_x64.efi
wget https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/ext4_x64.efi -O ./Downloaded/ext4_x64.efi

if [ -f "./ISK.key" ]; then
    echo "ISK.key was decrypted successfully"
fi

if [ -f "./ISK.pem" ]; then
    echo "ISK.pem was decrypted successfully"
fi

# Sign drivers
sbsign --key ISK.key --cert ISK.pem --output ./Signed/BOOTx64.efi ./Downloaded/X64/EFI/BOOT/BOOTx64.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/OpenCore.efi ./Downloaded/X64/EFI/OC/OpenCore.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/AudioDxe.efi ./Downloaded/X64/EFI/OC/Drivers/AudioDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/BiosVideo.efi ./Downloaded/X64/EFI/OC/Drivers/BiosVideo.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/CrScreenshotDxe.efi ./Downloaded/X64/EFI/OC/Drivers/CrScreenshotDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/HiiDatabase.efi ./Downloaded/X64/EFI/OC/Drivers/HiiDatabase.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/NvmExpressDxe.efi ./Downloaded/X64/EFI/OC/Drivers/NvmExpressDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenCanopy.efi ./Downloaded/X64/EFI/OC/Drivers/OpenCanopy.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenHfsPlus.efi ./Downloaded/X64/EFI/OC/Drivers/OpenHfsPlus.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenLinuxBoot.efi ./Downloaded/X64/EFI/OC/Drivers/OpenLinuxBoot.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenPartitionDxe.efi ./Downloaded/X64/EFI/OC/Drivers/OpenPartitionDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenRuntime.efi ./Downloaded/X64/EFI/OC/Drivers/OpenRuntime.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenUsbKbDxe.efi ./Downloaded/X64/EFI/OC/Drivers/OpenUsbKbDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/Ps2KeyboardDxe.efi ./Downloaded/X64/EFI/OC/Drivers/Ps2KeyboardDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/Ps2MouseDxe.efi ./Downloaded/X64/EFI/OC/Drivers/Ps2MouseDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/UsbMouseDxe.efi ./Downloaded/X64/EFI/OC/Drivers/UsbMouseDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/XhciDxe.efi ./Downloaded/X64/EFI/OC/Drivers/XhciDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/HfsPlus.efi ./Downloaded/HfsPlus.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/ExFatDxe.efi ./Downloaded/ExFatDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/btrfs_x64.efi ./Downloaded/btrfs_x64.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/ext4_x64.efi ./Downloaded/ext4_x64.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/BootKicker.efi ./Downloaded/X64/EFI/OC/Tools/BootKicker.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/ChipTune.efi ./Downloaded/X64/EFI/OC/Tools/ChipTune.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/CleanNvram.efi ./Downloaded/X64/EFI/OC/Tools/CleanNvram.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/ControlMsrE2.efi ./Downloaded/X64/EFI/OC/Tools/ControlMsrE2.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/CsrUtil.efi ./Downloaded/X64/EFI/OC/Tools/CsrUtil.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/GopStop.efi ./Downloaded/X64/EFI/OC/Tools/GopStop.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/KeyTester.efi ./Downloaded/X64/EFI/OC/Tools/KeyTester.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/MmapDump.efi ./Downloaded/X64/EFI/OC/Tools/MmapDump.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/OpenControl.efi ./Downloaded/X64/EFI/OC/Tools/OpenControl.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/OpenShell.efi ./Downloaded/X64/EFI/OC/Tools/OpenShell.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/ResetSystem.efi ./Downloaded/X64/EFI/OC/Tools/ResetSystem.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/RtcRw.efi ./Downloaded/X64/EFI/OC/Tools/RtcRw.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/TpmInfo.efi ./Downloaded/X64/EFI/OC/Tools/TpmInfo.efi

# Clean 
rm -rf Downloaded
echo "Cleaned..."
