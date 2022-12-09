cmake_minimum_required(VERSION 3.14)

project(snpcal
LANGUAGES Fortran)

enable_testing()

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()

add_compile_options(
"$<$<Fortran_COMPILER_ID:GNU>:-std=legacy;-Wall;-Wextra;-fimplicit-none>"
"$<$<Fortran_COMPILER_ID:Intel,IntelLLVM>:-warn>"
)

add_executable(snpcal app/snpcal.f)

add_test(NAME Calendar
COMMAND sh -c "$<TARGET_FILE:snpcal> 2018 7 | diff --text -a - ${PROJECT_SOURCE_DIR}/ref/test.log"
)
set_property(TEST Calendar PROPERTY DISABLED $<NOT:$<BOOL:${UNIX}>>)

configure_file(snpcal.dat ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)

#--- install

install(TARGETS snpcal TYPE RUNTIME)

install(FILES snpcal.dat TYPE BIN
PERMISSIONS OWNER_READ
)

if(UNIX)
  install(FILES snpcal.sh TYPE BIN)
endif()
