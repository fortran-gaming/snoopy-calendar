# Fortran Snoopy Calendar

[![Actions Status](https://github.com/fortran-gaming/snoopy-calendar/workflows/ci_cmake/badge.svg)](https://github.com/fortran-gaming/snoopy-calendar/actions)

The classic Fortran 66 Peanuts calendar generator...with a dash of Fortran 2008, in a single .f file.

Modified:

* uses Fortran 2008 file open() and close()
* Fortran 2003 command line input of year/month
* remove Fortran 66 Hollerith characters

build with:

```sh
cmake -B build

cmake --build build
```

test output with

```sh
ctest --test-dir build -V
```

## Usage

The output seems valid from year 1753 through about year 3000.

The output is printed to the Terminal, so simply redirect stdout to a file to save.
The two needed parameters are year and month.

```sh
build/snpcal 2023 12 > cal.txt
```

To properly see the calendar in your terminal, your terminal must be at least 133 columns wide.

Specify year and month.
To make a July 2018 calendar, output to terminal:

```sh
build/snpcal 2018 7
```

The simplest way to **create a PDF calendar** is to open the text output in say LibreOffice or Microsoft Office or Notepad etc. and "print to PDF".

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
