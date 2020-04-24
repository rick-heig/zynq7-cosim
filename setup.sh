#!/bin/bash

if [ -d libsystemctlm-soc ]
then
    echo "[SETUP] Directory libsystemctlm-soc already exists"
    exit 1
fi

echo "[SETUP] Cloning Xilinx libraries..."
git clone https://github.com/Xilinx/libsystemctlm-soc.git
cd libsystemctlm-soc
# Checkout the commit on which this was tested
git checkout 9aeece0b95592cc84db10b53bd0c45f3ea8536dc
git checkout -b work
echo "[SETUP] Patching Xilinx libraries for Questasim compatibility"
git apply ../libSystemCTLM-SoC_wo_async_questa.patch
echo "[SETUP] Everything is ready"
