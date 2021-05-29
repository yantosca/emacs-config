#!/bin/bash

#==============================================================================
# emacs-config installation script
#
# 28 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu
#==============================================================================

# Copy the sample init.el file to the ~/.emacs.d folder
# The user can customize this further
echo "-----------------------"
echo "Installing emacs-config"
echo "-----------------------"
echo ""
echo "1. Copying the sample init.el file to .emacs.d"
echo "   You can customize this further."
echo ""
cp -f ./sample-init-el/init.el ../init.el

# Load all submodules
echo "2. Attempting to build the vterm module. If this fails"
echo "   on your system, you can disable vterm by setting"
echo "   '(setq enable-vterm nil)' in ~/.emacs.d/init.el."
echo ""
git submodule update --init --recursive

# Build the emacs-libvterm module
cd emacs-libvterm
mkdir build
cd build
cmake ..
make
cd ..
rm -rf build

# We're done!
echo ""
echo "3. Done!"

