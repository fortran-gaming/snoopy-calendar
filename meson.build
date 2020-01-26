project('snpcal', 'fortran', default_options: ['warning_level=3'])

executable('snpcal', 'snpcal.f',
  install: true)

configure_file(input : 'snpcal.dat', output : 'snpcal.dat', copy : true)
