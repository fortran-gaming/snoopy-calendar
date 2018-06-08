[![Build Status](https://travis-ci.com/fortran-gaming/snoopy-calendar.svg?branch=master)](https://travis-ci.com/fortran-gaming/snoopy-calendar)

# Fortran Snoopy Calendar

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

test output with
```bash
make test
```

## Usage

Year is optional, default is 1969. 
To make a 2018 calendar:

```bash
./snpcal 2018
```

It seems from a cursory check that the output may be valid from year 1753 through year 3000 or more.

To output to console `stdout` instead of a file, specify AFTER the year (as the second argument) `-`
For example:

```bash
./snpcal 2018 -
```

You can thus pipe the output to other programs. 
To see the calendar in your terminal, your terminal must be at least 132 columns wide.

### Output

The calendar is created in `snpcal2018.txt` (or whatever your year is).
Be sure line wrapping is turned off in your text editor to view the calendar properly.
The lines are 132 characters + newline long.

## Hacking
The cartoon character writing code is all in `snppic.f`.
Simply commenting out line 230 (replacing with `230 continue`) generates just the calendar, so it's straightforward to make a new few line `snppic()` that inputs your own Text art files.
