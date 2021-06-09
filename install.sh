#!/bin/bash

#==============================================================================
# emacs-config installation script
#
# 28 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu
#==============================================================================

# Copy startup files ~/.emacs.d folder
# The user can customize these further
echo "---------------------------------------"
echo "Copying the init.org file to ~/.emacs.d"
echo "---------------------------------------"
echo ""
echo "1. Copying *.org files file to .emacs.d"
echo ""
cp -f ./emacs-config.org ~/.emacs.d
cp -f ./init.el ~/.emacs.d

# Skip building the emacs vterm if any argument is passed
if [[ "x${1}" != "x" ]]; then
    echo "2. Skip building emacs-libvterm..."
    echo ""
    echo "3. Done!"
    exit 0
fi

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

