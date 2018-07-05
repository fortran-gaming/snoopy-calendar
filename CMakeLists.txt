cmake_minimum_required (VERSION 3.0)
project(snpcal Fortran)
enable_testing()

add_compile_options(-g)

add_executable(snpcal snppic.f90 snpcal.f)
if(UNIX)
  add_test(NAME Calendar COMMAND bash -c "./snpcal 2018 7 | diff --text -a - ${PROJECT_SOURCE_DIR}/ref/test.log")
endif()

configure_file(snpcal.dat ${CMAKE_CURRENT_BINARY_DIR} COPYONLY)

#--- install
if(UNIX AND CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX "~/.local/bin" CACHE PATH "..." FORCE)
endif()

install(TARGETS snpcal
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX})
        
install(FILES ${PROJECT_SOURCE_DIR}/snpcal.dat
        DESTINATION ${CMAKE_INSTALL_PREFIX}
        PERMISSIONS OWNER_READ)