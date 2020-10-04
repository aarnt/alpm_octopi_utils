include(ValaPrecompile)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)
find_library(GLIB_LIBRARY NAMES glib-2.0 PATHS ${GLIB_LIBRARY_DIRS})
find_library(GIO_LIBRARY NAMES gio-2.0 PATHS ${GLIB_LIBRARY_DIRS})
find_library(ALPM_LIBRARY NAMES alpm)

set(SOURCES alpm_config.vala alpm_octopi_utils.vala)

vala_precompile(VALA_C libalpm_octopi_utils_gen ${SOURCES} CUSTOM_VAPIS "${CMAKE_SOURCE_DIR}/vapi/libalpm.vapi" PACKAGES gio-2.0 posix GENERATE_VAPI alpm_octopi_utils GENERATE_HEADER alpm_octopi_utils)

set(libdir "${CMAKE_INSTALL_PREFIX}/lib")
set(includedir "${CMAKE_INSTALL_PREFIX}/include")
configure_file(libalpm_octopi_utils.pc.in "${CMAKE_CURRENT_BINARY_DIR}/libalpm_octopi_utils.pc" @ONLY)

add_library(alpm_octopi_utils SHARED ${VALA_C})
target_compile_definitions(alpm_octopi_utils PRIVATE D_FILE_OFFSET_BITS=64)
target_include_directories(alpm_octopi_utils PUBLIC "$<INSTALL_INTERFACE:include>" "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>" "${GLIB_INCLUDE_DIRS}")
target_link_libraries(alpm_octopi_utils PUBLIC ${GLIB_LIBRARY} ${ALPM_LIBRARY} ${GIO_LIBRARY})
install(TARGETS alpm_octopi_utils EXPORT alpm_octopi_utils RUNTIME DESTINATION bin LIBRARY DESTINATION lib PUBLIC_HEADER DESTINATION include)
install(EXPORT alpm_octopi_utils DESTINATION lib/cmake)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/alpm_octopi_utils.h" DESTINATION include)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/alpm_octopi_utils.vapi" DESTINATION share/vala/vapi)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/libalpm_octopi_utils.pc" DESTINATION lib/pkgconfig)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config.cmake.in" "set(${PROJECT_NAME}_VERSION ${PROJECT_VERSION})\n@PACKAGE_INIT@\nset_and_check(${PROJECT_NAME}_INCLUDE_DIR \"@PACKAGE_INCLUDE_INSTALL_DIR@\")\ncheck_required_components(${PROJECT_NAME})\ninclude(\"\${CMAKE_CURRENT_LIST_DIR}/alpm_octopi_utils.cmake\")")

include(CMakePackageConfigHelpers)

set(INCLUDE_INSTALL_DIR include)

configure_package_config_file("${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config.cmake"
    INSTALL_DESTINATION lib/cmake
    PATH_VARS INCLUDE_INSTALL_DIR
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/config/alpm_octopi_utils-config.cmake" DESTINATION lib/cmake)
