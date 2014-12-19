get_filename_component(TOOLCHAIN_DIR ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
set(CMAKE_MODULE_PATH "${TOOLCHAIN_DIR}/Module/")
include(create_pro)

unset(TOOLCHAIN_DIR)
set(ANDROID true)
