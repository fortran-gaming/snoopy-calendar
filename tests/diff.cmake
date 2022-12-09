set(out ${CMAKE_CURRENT_BINARY_DIR}/out.log)

execute_process(COMMAND ${exe} 2018 7
OUTPUT_FILE ${out}
RESULT_VARIABLE ret
)

if(NOT ret EQUAL 0)
  message(FATAL_ERROR "snpcal failed")
endif()

execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files --ignore-eol ${out} ${ref}
RESULT_VARIABLE ret
)

if(NOT ret EQUAL 0)
  message(FATAL_ERROR "snpcal output does not match reference  ${out}  ${ref} ${ret}")
endif()
