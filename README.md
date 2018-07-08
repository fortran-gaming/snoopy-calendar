[![Build Status](https://travis-ci.com/fortran-gaming/snoopy-calendar.svg?branch=master)](https://travis-ci.com/fortran-gaming/snoopy-calendar)

# Fortran Snoopy Calendar

The classic Fortran 66 Peanuts calendar generator...with a dash of Fortran 2008!

Modified:

* uses Fortran 2008 file open() and close()
* Fortran 2003 command line input of year/month
* remove Fortran 66 Hollerith characters

## Build
Assuming any modern Fortran compiler (tested with Gfortran &ge; 4.8, PGI 2017+, Flang 5.0 and Intel 2018+):

```bash
cmake ..

cmake --build .
```

test output with
```bash
ctest -V
```

## Usage

It seems from a cursory check that the output may be valid from year 1753 through year 3000 or more.


The output is printed to the Terminal, so simply redirect stdout to a file to save.
To see the calendar in your terminal, your terminal must be at least 133 columns wide.

Specify year and month.
To make a July 2018 calendar, output to terminal:
```sh
./snpcal 2018 7 
```

### Create PDF
This procedure is specific to Linux, but may be adapted to other OS.

1. install:
   ```sh
   apt install enscript ghostscript
   ```
2. for each month wanted (here, July 2018)
   ```sh
   ./snpcal.sh 2018 7
   ```

That creates `mycal.pdf` which should be a single page, approximately centered.
Adjust the `enscript` command line parameters if it doesn't look right.



### Custom images

The second command line argument `user` will load your own images from the folder `data/pic01.txt` `data/pic02.txt` where the number is the month.
We have found a good way to convert images to simple ASCII is 
[jp2a](https://csl.name/jp2a/), available on Linux by `apt install jp2a` or similar.
Then using ImageMagick:
```bash
convert myimg.png jpg:- | jp2a --width=132 -i - > myimg.txt
```

Once you are satisfied, put them in the `data/` folder, named as `pic01.txt` &c. to be used for the respective month.
