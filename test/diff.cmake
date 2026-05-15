execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files --ignore-eol ${out} ${ref}
RESULT_VARIABLE ret
COMMAND_ERROR_IS_FATAL ANY
)
