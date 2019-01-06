project('snpcal', 'fortran', default_options : ['default_library=static'])

executable('snpcal', 'snppic.f90', 'snpcal.f', 'utils.f90')

configure_file(input : 'snpcal.dat', output : 'snpcal.dat', copy : true)
