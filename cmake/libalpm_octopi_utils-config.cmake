
include(CMakeFindDependencyMacro)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR};${CMAKE_MODULE_PATH}")
find_dependency(glib-2.0)
find_dependency(gio-2.0)
find_dependency(alpm)
include("${CMAKE_CURRENT_LIST_DIR}/libalpm_octopi_utils_target.cmake")
