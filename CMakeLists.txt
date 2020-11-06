cmake_minimum_required(VERSION 3.5)
project(libalpm_octopi_utils VERSION 1.0 LANGUAGES C)

set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

add_subdirectory(src)
add_subdirectory(examples)
