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

# Load all submodules
echo "2. Updating submodules and building the vterm module."
echo ""
echo "   If the build fails on your system, disable vterm in the Global"
echo "   toggles section of emacs-config.org -- add this host to the"
echo "   exclusion in '(setq enable-vterm ...)' -- and re-run this script."
echo "   Setting it in ~/.emacs.d/init.el has no effect: init.el runs before"
echo "   emacs-config.org, whose own setq overwrites it, and step 1 above"
echo "   replaces init.el on every run."
echo ""
git submodule update --init --recursive

# Build the emacs-libvterm module, unless any argument was passed.
#
# Pass an argument to skip the build where the module cannot be built, or need
# not be.  vterm-module.so only has to be rebuilt when a submodule bump touches
# emacs-libvterm's C sources or CMakeLists.txt; an elisp-only bump needs nothing
# but a fresh vterm.elc.  So skipping no longer exits the script -- the
# byte-compile step below still has to run, because load takes a stale .elc over
# its .el whatever the timestamps say (load-prefer-newer is nil by default), and
# a bump left uncompiled would have no effect at all.
#
# Skipping matters on machines with no system libvterm, Cannon among them, where
# every cmake run clones and static-links the libvterm mirror instead.
if [[ "x${1}" != "x" ]]; then
    echo ""
    echo "   Skipping the emacs-libvterm build (argument given)."
else
    cd emacs-libvterm
    mkdir build
    cd build
    cmake ..
    make
    cd ..
    rm -rf build
    cd ..
fi

# Byte-compile the vendored packages
#
# Emacs macroexpands every .el it loads from source, so obsolete macros in
# unmaintained vendored code (org-bullets, rust-prog-mode, vterm) print a
# warning on every startup.  Loading a .elc skips that, and starts faster.
#
# Only the files the configuration actually loads are compiled: elpa/ also
# carries magit and its dependency tree, which nothing requires and which
# cannot compile without dash on the load-path.  Walking load-history after
# the config has loaded picks the right set automatically, so this needs no
# updating when packages are added or dropped.
#
# load-history names whichever file was actually loaded, so on every run
# after the first it reports .elc rather than .el.  Strip the trailing "c"
# before compiling, or this step silently does nothing once it has run once.
#
# .elc files are gitignored -- they are per-machine derived artifacts, and
# bytecode is not portable to an older Emacs than the one that built it.
echo ""
echo "3. Byte-compiling the vendored packages..."
echo ""
emacs --batch --eval '(progn (require (quote package)) (package-initialize))' \
      -l ~/.emacs.d/init.el --eval '
(let ((root (file-name-as-directory (expand-file-name "~/.emacs.d/emacs-config")))
      (ok 0) (fail 0))
  (dolist (entry load-history)
    (let ((f (car entry)))
      (when (and (stringp f) (string-prefix-p root f))
        (when (string-suffix-p ".elc" f)
          (setq f (substring f 0 -1)))
        (when (and (string-suffix-p ".el" f) (file-exists-p f))
          (if (ignore-errors (byte-compile-file f))
              (setq ok (1+ ok))
            (setq fail (1+ fail))
            (message "could not compile %s" (file-relative-name f root)))))))
  (message "byte-compiled %d file(s), %d failed" ok fail))' 2>&1 \
    | grep -E "byte-compiled|could not compile"

# We're done!
echo ""
echo "4. Done!"

