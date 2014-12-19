macro(GET_RELATIVE_PATH source relative)
  string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/" "" ${relative} ${source})
endmacro(GET_RELATIVE_PATH)
