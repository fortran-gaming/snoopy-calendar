#!/bin/sh

# apt install pandoc
# brew install pandoc

# cmake --workflow default

set -eu

(echo '```'; build/snpcal $1 $2; echo '```') | pandoc --from=markdown --to=pdf \
  --columns=133 --wrap=none \
  -V geometry=landscape,margin=0.4cm \
  -o $1-$2.pdf

echo "Saved $1-$2.pdf"

# apt install enscript ghostscript
# snpcal $1 $2 | enscript -Bh -f Courier2 --margins=110 -o - | ps2pdf - $1-$2.pdf

#  inkscape -l $1-$2.svg $1-$2.pdf
# FIXME: inkscape line-wraps of its own accord, even when using Inkscape GUI !?
