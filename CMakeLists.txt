cmake_minimum_required (VERSION 3.14...3.22)

project(snpcal
LANGUAGES Fortran)

enable_testing()

add_compile_options(
"$<$<Fortran_COMPILER_ID:GNU>:-std=legacy;-Wall;-Wextra;-fimplicit-none>"
"$<$<Fortran_COMPILER_ID:Intel,IntelLLVM>:-warn>"
)

add_executable(snpcal snpcal.f)

add_test(NAME Calendar
COMMAND sh -c "$<TARGET_FILE:snpcal> 2018 7 | diff --text -a - ${PROJECT_SOURCE_DIR}/ref/test.log"
)
set_tests_properties(Calendar PROPERTIES
DISABLED $<NOT:$<BOOL:${UNIX}>>
TIMEOUT 10
)

configure_file(snpcal.dat ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)

#--- install

install(TARGETS snpcal TYPE RUNTIME)

install(FILES ${snpcal_SOURCE_DIR}/snpcal.dat
TYPE BIN
PERMISSIONS OWNER_READ
)

if(UNIX)
  install(FILES ${snpcal_SOURCE_DIR}/snpcal.sh
  TYPE BIN
  )
endif()
