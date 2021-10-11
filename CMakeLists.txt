cmake_minimum_required (VERSION 3.14...3.21)

project(snpcal
LANGUAGES Fortran)

include(CTest)

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-std=legacy -Wall -Wextra -fimplicit-none)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  add_compile_options(-warn)
endif()

add_executable(snpcal snpcal.f)
find_program(BASH NAMES bash)
if(BASH)
  add_test(NAME Calendar
    COMMAND ${BASH} -c "./snpcal 2018 7 | diff --text -a - ${PROJECT_SOURCE_DIR}/ref/test.log")
endif()

configure_file(snpcal.dat ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)

#--- install

install(TARGETS snpcal TYPE RUNTIME)

install(FILES ${snpcal_SOURCE_DIR}/snpcal.dat
        DESTINATION bin
        PERMISSIONS OWNER_READ)

if(UNIX)
  install(FILES ${snpcal_SOURCE_DIR}/snpcal.sh DESTINATION bin)
endif()
