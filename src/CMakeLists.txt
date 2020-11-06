include(ValaPrecompile)
include(GenerateFindModule)

generate_find_module(FIND_FILE_GLIB_PATH glib-2.0 LIB_NAMES glib-2.0 HEADER_NAMES glib.h HEADER_PATH_SUFFIXES glib)
generate_find_module(FIND_FILE_GIO_PATH gio-2.0 LIB_NAMES gio-2.0 HEADER_NAMES gfile.h HEADER_PATH_SUFFIXES gio)
generate_find_module(FIND_FILE_ALPM_PATH alpm LIB_NAMES alpm HEADER_NAMES alpm.h)
find_package(glib-2.0)
find_package(gio-2.0)
find_package(alpm)

set(SOURCES alpm_config.vala alpm_octopi_utils.vala)

vala_precompile(VALA_GEN_C alpm_octopi_utils_valagen ${SOURCES} CUSTOM_VAPIS "${CMAKE_SOURCE_DIR}/vapi/libalpm.vapi" PACKAGES gio-2.0 posix GENERATE_VAPI alpm_octopi_utils GENERATE_HEADER alpm_octopi_utils)

set(libdir "${CMAKE_INSTALL_PREFIX}/lib")
set(includedir "${CMAKE_INSTALL_PREFIX}/include")
configure_file(libalpm_octopi_utils.pc.in "${CMAKE_CURRENT_BINARY_DIR}/libalpm_octopi_utils.pc" @ONLY)

add_library(alpm_octopi_utils SHARED ${VALA_GEN_C})
target_compile_definitions(alpm_octopi_utils PRIVATE _FILE_OFFSET_BITS=64)
target_include_directories(alpm_octopi_utils PUBLIC "$<INSTALL_INTERFACE:include>" "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>")
target_link_libraries(alpm_octopi_utils PUBLIC glib-2.0::glib-2.0 PUBLIC gio-2.0::gio-2.0 PUBLIC alpm::alpm)
install(TARGETS alpm_octopi_utils EXPORT alpm_octopi_utils_target RUNTIME DESTINATION bin LIBRARY DESTINATION lib PUBLIC_HEADER DESTINATION include)
install(EXPORT alpm_octopi_utils_target DESTINATION lib/cmake/alpm_octopi_utils)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/alpm_octopi_utils.h" DESTINATION include)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/alpm_octopi_utils.vapi" DESTINATION share/vala/vapi)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/libalpm_octopi_utils.pc" DESTINATION lib/pkgconfig)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config.cmake" DESTINATION lib/cmake/alpm_octopi_utils)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config-version.cmake" DESTINATION lib/cmake/alpm_octopi_utils)
install(FILES "${FIND_FILE_GLIB_PATH}" DESTINATION lib/cmake/alpm_octopi_utils)
install(FILES "${FIND_FILE_GIO_PATH}" DESTINATION lib/cmake/alpm_octopi_utils)
install(FILES "${FIND_FILE_ALPM_PATH}" DESTINATION lib/cmake/alpm_octopi_utils)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config.cmake" 
"
include(CMakeFindDependencyMacro)
set(CMAKE_MODULE_PATH \"\${CMAKE_CURRENT_LIST_DIR};\${CMAKE_MODULE_PATH}\")
find_dependency(glib-2.0)
find_dependency(gio-2.0)
find_dependency(alpm)
include(\"\${CMAKE_CURRENT_LIST_DIR}/alpm_octopi_utils_target.cmake\")
")

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config-version.cmake"
  VERSION ${libalpm_octopi_utils_VERSION}
  COMPATIBILITY AnyNewerVersion
)
