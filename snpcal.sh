#!/bin/bash

# apt install enscript ghostscript

set -eu

snpcal $1 $2 | enscript -Bh -f Courier2 --margins=110 -o - | ps2pdf - $1-$2.pdf

#  inkscape -l $1-$2.svg $1-$2.pdf   # FIXME: inkscape line-wraps of it's own accord, even when using Inkscape GUI !?

