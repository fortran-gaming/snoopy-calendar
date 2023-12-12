cmake_minimum_required(VERSION 3.14...3.28)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "Please use out-of-source build
  cmake -Bbuild")
endif()

project(snpcal LANGUAGES Fortran)

enable_testing()


if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
  #add_compile_options(-Wall -Wextra -fimplicit-none "$<$<CONFIG:Debug>:-fcheck=all>")
  add_compile_options(-std=legacy -Werror=line-truncation)
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^Intel")
  # add_compile_options(warn)
endif()

add_executable(snpcal app/snpcal.for )

add_test(NAME diff
COMMAND ${CMAKE_COMMAND}
  -Dexe:FILEPATH=$<TARGET_FILE:snpcal>
  -Dref:FILEPATH=${PROJECT_SOURCE_DIR}/ref/test.log
  -P ${CMAKE_CURRENT_SOURCE_DIR}/tests/diff.cmake
)

configure_file(snpcal.dat ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)

#--- install

install(TARGETS snpcal TYPE RUNTIME)

install(FILES snpcal.dat TYPE BIN
PERMISSIONS OWNER_READ
)

if(UNIX)
  install(FILES snpcal.sh TYPE BIN)
endif()

file(GENERATE OUTPUT .gitignore CONTENT "*")
