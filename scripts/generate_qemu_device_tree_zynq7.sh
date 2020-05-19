#!/bin/bash

# Documentation :
# https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug1144-petalinux-tools-reference-guide.pdf
# https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug1169-xilinx-qemu.pdf

if [ -z ${PETALINUX+x} ]
then
    echo 'could not find Petalinux path $PETALINUX'
    echo 'did you source Petalinux settings.sh ?'
    exit 1
fi

if [ $# -le 0 ]
then
    echo 'Your command line contains no arguments'
    echo "usage : $0 /path/to/petalinux/project/"
    exit 1
fi

PATHTOPETALINUXPROJECT=$1

cd $PATHTOPETALINUXPROJECT

if [ ! -d images/linux ]
then
    echo "the directory ${PATHTOPETALINUXPROJECT} does not seem to hold the images directory."
    echo "did you build the project ?"
    exit 1
fi

if [ ! -d qemu_cosim ]
then
    mkdir qemu_cosim
fi

if [ ! -f qemu_cosim/qemu_hw_system.dtb ]
then
    # Clean the sstate
    petalinux-build -c device-tree -x cleansstate
    
    # Create the QEMU HW device tree
    # Doc is here but not necessarily up to date
    # https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842109/QEMU+SystemC+and+TLM+CoSimulation
    echo "Creating hardware device tree for QEMU..."
    echo "Getting Xilinx QEMU device tree..."
    wget https://raw.githubusercontent.com/Xilinx/qemu-devicetrees/master/zynq-pl-remoteport.dtsi -O project-spec/meta-user/recipes-bsp/device-tree/files/zynq-pl-remoteport.dtsi
    cp project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi.backup
    # TODO : Here it would be best to check if this wasn't already done
    sed -i '/\/ {/i #include "zynq-pl-remoteport.dtsi"' project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi
    cp project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend.backup
    echo 'SRC_URI += "file://zynq-pl-remoteport.dtsi"' >> project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend
    petalinux-build -c device-tree
    
    # Copy it
    cp images/linux/system.dtb qemu_cosim/qemu_hw_system.dtb
    echo "QEMU device tree created : $(realpath qemu_cosim/qemu_hw_system.dtb)"
    
    # Restore
    rm project-spec/meta-user/recipes-bsp/device-tree/files/zynq-pl-remoteport.dtsi
    mv project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi.backup project-spec/meta-user/recipes-bsp/device-tree/files/system-user.dtsi
    mv project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend.backup project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend
    mv project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend.backup project-spec/meta-user/recipes-bsp/device-tree/device-tree.bbappend
    
    # Clean the sstate again
    petalinux-build -c device-tree -x cleansstate
    
    # Rebuild device tree as usual for linux (this is optional, but cleaner)
    petalinux-build -c device-tree

    echo "QEMU device tree available in : $(realpath qemu_cosim/qemu_hw_system.dtb)"
else
    echo "QEMU device tree already exists in : $(realpath qemu_cosim/qemu_hw_system.dtb)"
    echo "Remove it and run the script again to regenerate"
fi
