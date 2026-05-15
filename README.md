# Fortran Snoopy Calendar

[![Actions Status](https://github.com/fortran-gaming/snoopy-calendar/workflows/ci_cmake/badge.svg)](https://github.com/fortran-gaming/snoopy-calendar/actions)

The classic Fortran 66 Peanuts calendar generator...with a dash of Fortran 2008, in a single .f file.

[Original code](https://www.ibiblio.org/pub/academic/computer-science/history/pdp-11/rsts/decus/sig87/087018/)
is stored under [ref/](./ref).
Modified:

* uses Fortran 2008 file open() and close()
* Fortran 2003 command line input of year/month
* remove Fortran 66 Hollerith characters

Build and test SnpCal with:

```sh
cmake --workflow default
```

## Usage

The output seems valid from year 1753 through about year 3000.

The output is printed to the Terminal stdout, so simply redirect stdout to a file or pipe to a convertor like Pandoc to save.
The one needed parameter is year, and month is optional (defaults to 1).

```sh
build/snpcal 2026 > out.txt
```

## Usage

It seems from a cursory check that the output may be valid from year 1753 through year 3000 or more.

The output is printed to the Terminal, so simply redirect stdout to a file to save.
To see the calendar in your terminal, your terminal must be at least 133 columns wide.

Specify year and month.
To make a July 2018 calendar, output to terminal:

```sh
build/snpcal 2018 7
```

Make a PDF with Pandoc.
This is scripted in "snpcal.sh" for Unix-like systems, and "snpcal.ps1" for Windows PowerShell:

```sh
build/snpcal 2026 > out.txt

(echo '```'; cat out.txt; echo '```') | pandoc --from=markdown --to=pdf \
  --columns=133 --wrap=none \
  -V geometry=landscape,margin=0.4cm \
  -o calendar.pdf
```

[Pandoc](https://pandoc.org/) is available across OSes:

* Windows: `winget install JohnMacFarlane.Pandoc`
* macOS: `brew install pandoc`
* Linux: `apt install pandoc` or similar

To **print a calendar** open the output in a text editor or Office software and print as usual.

### Custom images

The second command line argument `user` will load your own images from the folder `data/pic01.txt` `data/pic02.txt` where the number is the month.
We have found a good way to convert images to simple ASCII is
[jp2a](https://csl.name/jp2a/), available on Linux by `apt install jp2a` or similar.
Then using ImageMagick:

```sh
convert myimg.png jpg:- | jp2a --width=132 -i - > myimg.txt
```

Once you are satisfied, put them in the `data/` folder, named as `pic01.txt` &c. to be used for the respective month.
