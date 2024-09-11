#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libalpm_octopi_utils" for configuration ""
set_property(TARGET libalpm_octopi_utils APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(libalpm_octopi_utils PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libalpm_octopi_utils.so.1.0"
  IMPORTED_SONAME_NOCONFIG "libalpm_octopi_utils.so.1"
  )

list(APPEND _cmake_import_check_targets libalpm_octopi_utils )
list(APPEND _cmake_import_check_files_for_libalpm_octopi_utils "${_IMPORT_PREFIX}/lib/libalpm_octopi_utils.so.1.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
