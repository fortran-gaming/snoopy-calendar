[![Build Status](https://travis-ci.com/fortran-gaming/snoopy-calendar.svg?branch=master)](https://travis-ci.com/fortran-gaming/snoopy-calendar)

# Snoopy Calendar

The classic Fortran calendar.

Modified in two regards:

* uses Fortran 2008 file open() and close()
* allows command line input of year (default 1969)


## Build
Assuming any Fortran compiler (tested with Gfortran 4.8+, PGI, Flang and Intel) and GNU Make:

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
