[![Build Status](https://travis-ci.com/fortran-gaming/snoopy-calendar.svg?branch=master)](https://travis-ci.com/fortran-gaming/snoopy-calendar)

# Snoopy Calendar

The classic Fortran 66 Peanuts calendar generator...with a dash of Fortran 2008!

Modified:

* uses Fortran 2008 file open() and close()
* allows Fortran 2003 command line input of year (default 1969)
* remove Fortran 66 Hollerith characters

## Build
Assuming any modern Fortran compiler (tested with Gfortran 4.8+, PGI 2017+, Flang 5.0 and Intel 2018+) and GNU Make:

```bash
make
```

## Usage

Year is optional, default is 1969. 
To make a 2018 calendar:

```bash
./snpcal 2018
```

It seems from a cursory check that the output may be valid from year 1753 through year 3000 or more.

### Output

The calendar is created in `snpcal2018.txt` (or whatever your year is).
Be sure line wrapping is turned off in your text editor to view the calendar properly.
The lines are 132 characters + newline long.
