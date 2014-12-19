get_filename_component(__DIR ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
set(CMAKE_MODULE_PATH "${__DIR}")
include(get_relative_path)

macro(CREATE_PRO)
  set(sources "${ARGN}")

  # Separate by file type
  set(SOURCES_LIST)
  set(RESOURCES_LIST)
  set(HEADERS_LIST)
  foreach(source ${sources})
    GET_RELATIVE_PATH(${source} source)
    if(${source} MATCHES "^.*cpp$" OR ${source} MATCHES "^.*cc$")
      list(APPEND SOURCES_LIST ${source})
    elseif(${source} MATCHES "^.*qrc$")
      list(APPEND RESOURCES_LIST ${source})
    else()
      list(APPEND HEADERS_LIST ${source})
    endif()
  endforeach()

  set(PRO_CONTENT "TEMPLATE    += app\n")
  set(PRO_CONTENT "${PRO_CONTENT}QT          += core gui network opengl sql svg xml widgets quick declarative\n\n")

  # Write HEADERS
  set(FIRST TRUE)
  foreach(source ${HEADERS_LIST})
    if(FIRST)
      set(PRO_CONTENT "${PRO_CONTENT}HEADERS     += ${source}")
      set(FIRST FALSE)
    else()
      set(PRO_CONTENT "${PRO_CONTENT} \\\n               ${source}")
    endif()
  endforeach()
  set(PRO_CONTENT "${PRO_CONTENT}\n")


  # Write SOURCES
  set(FIRST TRUE)
  foreach(source ${SOURCES_LIST})
    if(FIRST)
      set(PRO_CONTENT "${PRO_CONTENT}SOURCES     += ${source}")
      set(FIRST FALSE)
    else()
      set(PRO_CONTENT "${PRO_CONTENT} \\\n               ${source}")
    endif()
  endforeach()
  set(PRO_CONTENT "${PRO_CONTENT}\n")

  # Write RESOURCES
  set(FIRST TRUE)
  foreach(source ${RESOURCES_LIST})
    if(FIRST)
      set(PRO_CONTENT "${PRO_CONTENT}RESOURCES   += ${source}")
      set(FIRST FALSE)
    else()
      set(PRO_CONTENT "${PRO_CONTENT} \\\n               ${source}")
    endif()
  endforeach()

  # Write File
  file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/project.pro" ${PRO_CONTENT})
  unset(PRO_CONTENT)
endmacro(CREATE_PRO)
