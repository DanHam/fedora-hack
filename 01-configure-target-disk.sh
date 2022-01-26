#!/usr/bin/env bash
#
# Partition the build disk
set -o errexit

if [ "x$1" == "x" ]; then
    echo "ERROR: You must supply the full path to the target disk e.g. /dev/sda"
    exit 1
fi

if ! fdisk -l "$1" &>/dev/null; then
    echo "ERROR: Could not find block device $1"
fi

# Ensure the target disk has no existing partitions
if [ "x$(lsblk -l -o PATH,TYPE | grep "$1" | grep part)" != "x" ]; then
    echo "ERROR: Target disk $1 has existing partitions. Exiting"
    exit 1
fi

# Configure the build disk and create required partitions
echo "Partitioning the target disk..."
printf "%s" "\
    g # Create a new empty GPT partition table
    n # Create a new partition for the boot filesystem
        1       # Partition number 1
                # Accept default first sector
        +512MiB # Set the partition size
    n # Create a new EFI system partition
        2       # Partition number 2
                # Accept default first sector
        +512MiB # Set the partition size
        t       # Set the partion type
            2   # Partition number 2
            1   # Set the partition type to EFI System
    n # Create a new partition for the LUKS encrypted LVM
        3     # Partition number 3
              # Accept default first sector
              # Accept default last sector - end of disk
    w # Write the partition table and quit
    " | sed -e 's/^ *//g' -e 's/[ ]*#.*//g' | \
        fdisk "$1"

exit 0
