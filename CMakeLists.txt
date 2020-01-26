cmake_minimum_required (VERSION 3.7)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Debug or Release")
endif()
project(snpcal Fortran)
enable_testing()

if(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  set(CMAKE_Fortran_FLAGS "-std=legacy -Wall -Wextra -fimplicit-none ")
  set(CMAKE_Fortran_FLAGS_DEBUG "-fcheck=all ")
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  add_compile_options(-warn)
endif()

add_executable(snpcal snpcal.f)
if(UNIX)
  add_test(NAME Calendar COMMAND bash -c "./snpcal 2018 7 | diff --text -a - ${PROJECT_SOURCE_DIR}/ref/test.log")
endif()

configure_file(snpcal.dat ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)

#--- install

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(WIN32)
    set(HOME $ENV{USERPROFILE})
  else()
    set(HOME $ENV{HOME})
  endif()
  set(CMAKE_INSTALL_PREFIX "${HOME}/.local/" CACHE PATH "..." FORCE)
endif()

install(TARGETS snpcal
        RUNTIME DESTINATION bin)

install(FILES ${snpcal_SOURCE_DIR}/snpcal.dat
        DESTINATION bin
        PERMISSIONS OWNER_READ)

if(UNIX)
  install(FILES ${snpcal_SOURCE_DIR}/snpcal.sh DESTINATION bin)
endif()
