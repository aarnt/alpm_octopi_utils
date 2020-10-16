# GenerateFindModule CMake utility script
# ---------------------------------------

# Copyright (c) 2020, Björn Stresing (bjoern.stresing@gmx.de)
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1.  Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.

# 2.  Redistributions in binary form must reproduce the above copyright notice,
#     this list of conditions and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.

# 3.  Neither the name of the copyright holder nor the names of its
#     contributors may be used to endorse or promote products derived from this
#     software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

cmake_minimum_required(VERSION 3.5)


include(CMakeParseArguments)

set(MODULES_OUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/generated_modules")
set(CMAKE_MODULE_PATH "${MODULES_OUT_DIR};${CMAKE_MODULE_PATH}")

#generate_find_package(
#   <VAR>
#   <package>
#   LIB_NAMES name1 [name2 ...]
#   HEADER_NAMES name1 [name2 ...]
#   [LIB_HINTS path1 [path2 ... ENV var]]
#   [HEADER_HINTS path1 [path2 ... ENV var]]
#   [LIB_PATHS path1 [path2 ... ENV var]]
#   [HEADER_PATHS path1 [path2 ... ENV var]]
#   [LIB_PATH_SUFFIXES suffix1 [suffix2 ...]]
#   [HEADER_PATH_SUFFIXES suffix1 [suffix2 ...]]
#   [LIB_DOC "cache documentation string"]
#   [HEADER_DOC "cache documentation string"]
#   [NO_DEFAULT_PATH]
#   [NO_CMAKE_ENVIRONMENT_PATH]
#   [NO_CMAKE_PATH]
#   [NO_SYSTEM_ENVIRONMENT_PATH]
#   [NO_CMAKE_SYSTEM_PATH]
#   [CMAKE_FIND_ROOT_PATH_BOTH | ONLY_CMAKE_FIND_ROOT_PATH | NO_CMAKE_FIND_ROOT_PATH]
#)

function(generate_find_module VAR package)

# apply ARG_ prefix because of conformity with other arguments
set(ARG_PACKAGE ${package})
set(${VAR} "${VAR}-NOTFOUND" PARENT_SCOPE)

# parse the arguments: cmake_parse_arguments(<prefix> <options> <one_value_keywords> <multi_value_keywords> args...)
cmake_parse_arguments(ARG "NO_DEFAULT_PATH;NO_CMAKE_ENVIRONMENT_PATH;NO_CMAKE_PATH;NO_SYSTEM_ENVIRONMENT_PATH;NO_CMAKE_SYSTEM_PATH;CMAKE_FIND_ROOT_PATH_BOTH;ONLY_CMAKE_FIND_ROOT_PATH;NO_CMAKE_FIND_ROOT_PATH" "LIB_DOC;HEADER_DOC" "LIB_NAMES;HEADER_NAMES;LIB_HINTS;HEADER_HINTS;LIB_PATHS;HEADER_PATHS;LIB_PATH_SUFFIXES;HEADER_PATH_SUFFIXES" ${ARGN})

if(NOT ARG_PACKAGE)
    message(FATAL_ERROR "Missing madatory package name")
endif()

if(NOT ARG_LIB_NAMES)
    message(FATAL_ERROR "Missing madatory LIB_NAMES")
endif()

if(NOT ARG_HEADER_NAMES)
    message(FATAL_ERROR "Missing madatory HEADER_NAMES")
endif()

string(LENGTH ${ARG_PACKAGE} ARG_PACKAGE_LEN)

set(ARG_PACKAGE_LEN_UNDERLINE "")
foreach(loop_var RANGE 1 ${ARG_PACKAGE_LEN})
    string(APPEND ARG_PACKAGE_LEN_UNDERLINE "-")
endforeach(loop_var)

if(ARG_LIB_DOC)
    set(ARG_LIB_DOC "DOC ${ARG_LIB_DOC}")
endif()

if(ARG_HEADER_DOC)
    set(ARG_HEADER_DOC "DOC ${ARG_HEADER_DOC}")
endif()

if(ARG_NO_DEFAULT_PATH)
    set(ARG_NO_DEFAULT_PATH "ARG_NO_DEFAULT_PATH")
else()
    set(ARG_NO_DEFAULT_PATH "")
endif()

if(ARG_NO_CMAKE_ENVIRONMENT_PATH)
    set(ARG_NO_CMAKE_ENVIRONMENT_PATH "ARG_NO_CMAKE_ENVIRONMENT_PATH")
else()
    set(ARG_NO_CMAKE_ENVIRONMENT_PATH "")
endif()

if(ARG_NO_CMAKE_PATH)
    set(ARG_NO_CMAKE_PATH "ARG_NO_CMAKE_PATH")
else()
    set(ARG_NO_CMAKE_PATH "")
endif()

if(ARG_NO_SYSTEM_ENVIRONMENT_PATH)
    set(ARG_NO_SYSTEM_ENVIRONMENT_PATH "ARG_NO_SYSTEM_ENVIRONMENT_PATH")
else()
    set(ARG_NO_SYSTEM_ENVIRONMENT_PATH "")
endif()

if(ARG_NO_CMAKE_SYSTEM_PATH)
    set(ARG_NO_CMAKE_SYSTEM_PATH "ARG_NO_CMAKE_SYSTEM_PATH")
else()
    set(ARG_NO_CMAKE_SYSTEM_PATH "")
endif()

if(ARG_CMAKE_FIND_ROOT_PATH_BOTH)
    set(ARG_CMAKE_FIND_ROOT_PATH_BOTH "ARG_CMAKE_FIND_ROOT_PATH_BOTH")
else()
    set(ARG_CMAKE_FIND_ROOT_PATH_BOTH "")
endif()

if(ARG_ONLY_CMAKE_FIND_ROOT_PATH)
    set(ARG_ONLY_CMAKE_FIND_ROOT_PATH "ARG_ONLY_CMAKE_FIND_ROOT_PATH")
else()
    set(ARG_ONLY_CMAKE_FIND_ROOT_PATH "")
endif()

if(ARG_NO_CMAKE_FIND_ROOT_PATH)
    set(ARG_NO_CMAKE_FIND_ROOT_PATH "ARG_NO_CMAKE_FIND_ROOT_PATH")
else()
    set(ARG_NO_CMAKE_FIND_ROOT_PATH "")
endif()

file(WRITE "${MODULES_OUT_DIR}/Find${ARG_PACKAGE}.cmake"
"# Distributed under the OSI-approved BSD 3-Clause License.
# See https://cmake.org/licensing for details.

#[=======================================================================[.rst:
${ARG_PACKAGE}
${ARG_PACKAGE_LEN_UNDERLINE}

Finds the ${ARG_PACKAGE} library.

Imported Targets
^^^^^^^^^^^^^^^^

This module was generated by \"generate_find_module\" and provides the following IMPORTED targets, if found:

``${ARG_PACKAGE}::${ARG_PACKAGE}``
  The ${ARG_PACKAGE} library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``${ARG_PACKAGE}_FOUND``
  True if the system has the ${ARG_PACKAGE} library.
``${ARG_PACKAGE}_VERSION``
  The version of the ${ARG_PACKAGE} library which was found.
``${ARG_PACKAGE}_INCLUDE_DIRS``
  Include directories needed to use ${ARG_PACKAGE}.
``${ARG_PACKAGE}_LIBRARIES``
  Libraries needed to link to ${ARG_PACKAGE}.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``${ARG_PACKAGE}_INCLUDE_DIR``
  The directory containing ``${ARG_HEADER_NAMES}``.
``${ARG_PACKAGE}_LIBRARY``
  The path to the ${ARG_PACKAGE} library.

#]=======================================================================]

set(VERBOSE_FIND_MODULE OFF CACHE BOOL \"Enable to print debug infos in the generated Find[...].cmake files\")

find_package(PkgConfig)
pkg_check_modules(PC_${ARG_PACKAGE} QUIET ${ARG_PACKAGE})
find_path(${ARG_PACKAGE}_INCLUDE_DIR NAMES ${ARG_HEADER_NAMES}
    HINTS ${ARG_HEADER_HINTS} 
    PATHS ${ARG_HEADER_PATHS} \${PC_${ARG_PACKAGE}_INCLUDE_DIRS}
    PATH_SUFFIXES ${ARG_HEADER_PATH_SUFFIXES}
    ${ARG_HEADER_DOC}
    ${ARG_NO_DEFAULT_PATH}
    ${ARG_NO_CMAKE_ENVIRONMENT_PATH}
    ${ARG_NO_CMAKE_PATH}
    ${ARG_NO_SYSTEM_ENVIRONMENT_PATH}
    ${ARG_NO_CMAKE_SYSTEM_PATH}
    ${ARG_CMAKE_FIND_ROOT_PATH_BOTH} ${ARG_ONLY_CMAKE_FIND_ROOT_PATH} ${ARG_NO_CMAKE_FIND_ROOT_PATH}
)

find_library(${ARG_PACKAGE}_LIBRARY NAMES ${ARG_LIB_NAMES}
    HINTS ${ARG_LIB_HINTS}
    PATHS ${ARG_LIB_PATHS} \${PC_${ARG_PACKAGE}_LIBRARY_DIRS}
    PATH_SUFFIXES ${ARG_LIB_PATH_SUFFIXES}
    ${ARG_LIB_DOC}
    ${ARG_NO_DEFAULT_PATH}
    ${ARG_NO_CMAKE_ENVIRONMENT_PATH}
    ${ARG_NO_CMAKE_PATH}
    ${ARG_NO_SYSTEM_ENVIRONMENT_PATH}
    ${ARG_NO_CMAKE_SYSTEM_PATH}
    ${ARG_CMAKE_FIND_ROOT_PATH_BOTH} ${ARG_ONLY_CMAKE_FIND_ROOT_PATH} ${ARG_NO_CMAKE_FIND_ROOT_PATH}
)

set(Foo_VERSION \${PC_${ARG_PACKAGE}_VERSION})
set(Foo_VERSION_STRING \${Foo_VERSION})

if(\${VERBOSE_FIND_MODULE})
    message(STATUS \"Running Find${ARG_PACKAGE}.cmake\")
    if(\${PC_${ARG_PACKAGE}_FOUND})
        message(STATUS \"   Found PkgConfig module with name '${ARG_PACKAGE}':\")
        message(STATUS \"       ${ARG_PACKAGE}_LIBRARIES: \${PC_${ARG_PACKAGE}_LIBRARIES}\")
        message(STATUS \"       ${ARG_PACKAGE}_LIBRARY_DIRS: \${PC_${ARG_PACKAGE}_LIBRARY_DIRS}\")
        message(STATUS \"       ${ARG_PACKAGE}_LDFLAGS: \${PC_${ARG_PACKAGE}_LDFLAGS}\")
        message(STATUS \"       ${ARG_PACKAGE}_LDFLAGS_OTHER: \${PC_${ARG_PACKAGE}_LDFLAGS_OTHER}\")
        message(STATUS \"       ${ARG_PACKAGE}_INCLUDE_DIRS: \${PC_${ARG_PACKAGE}_INCLUDE_DIRS}\")
        message(STATUS \"       ${ARG_PACKAGE}_CFLAGS: \${PC_${ARG_PACKAGE}_CFLAGS}\")
        message(STATUS \"       ${ARG_PACKAGE}_CFLAGS_OTHER: \${PC_${ARG_PACKAGE}_CFLAGS_OTHER}\")
    else()
        message(STATUS \"   No PkgConfig module found with name '${ARG_PACKAGE}'\")
    endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${ARG_PACKAGE} FOUND_VAR ${ARG_PACKAGE}_FOUND REQUIRED_VARS ${ARG_PACKAGE}_LIBRARY ${ARG_PACKAGE}_INCLUDE_DIR VERSION_VAR ${ARG_PACKAGE}_VERSION)

if(${ARG_PACKAGE}_FOUND)
    set(${ARG_PACKAGE}_LIBRARIES \${${ARG_PACKAGE}_LIBRARY})
    if(PC_${ARG_PACKAGE}_INCLUDE_DIRS)
        set(${ARG_PACKAGE}_INCLUDE_DIRS \${PC_${ARG_PACKAGE}_INCLUDE_DIRS})
    else()
        set(${ARG_PACKAGE}_INCLUDE_DIRS \${${ARG_PACKAGE}_INCLUDE_DIR})
    endif()
    set(${ARG_PACKAGE}_DEFINITIONS \${PC_${ARG_PACKAGE}_CFLAGS_OTHER})
endif()

if(${ARG_PACKAGE}_FOUND AND NOT TARGET ${ARG_PACKAGE}::${ARG_PACKAGE})
    add_library(${ARG_PACKAGE}::${ARG_PACKAGE} UNKNOWN IMPORTED)
    set_target_properties(${ARG_PACKAGE}::${ARG_PACKAGE} PROPERTIES IMPORTED_LOCATION \"\${${ARG_PACKAGE}_LIBRARY}\" INTERFACE_COMPILE_OPTIONS \"\${PC_${ARG_PACKAGE}_CFLAGS_OTHER}\" INTERFACE_INCLUDE_DIRECTORIES \"\${${ARG_PACKAGE}_INCLUDE_DIRS}\")
    if(\${VERBOSE_FIND_MODULE})
        message(STATUS \"   Creating IMPORTED target '${ARG_PACKAGE}::${ARG_PACKAGE}':\")
        message(STATUS \"       IMPORTED_LOCATION: \${${ARG_PACKAGE}_LIBRARY}\")
        message(STATUS \"       INTERFACE_COMPILE_OPTIONS: \${PC_${ARG_PACKAGE}_CFLAGS_OTHER}\")
        message(STATUS \"       INTERFACE_INCLUDE_DIRECTORIES: \${${ARG_PACKAGE}_INCLUDE_DIRS}\")
    endif()
endif()

mark_as_advanced(
  ${ARG_PACKAGE}_INCLUDE_DIR
  ${ARG_PACKAGE}_LIBRARY
)
")

set(${VAR} "${MODULES_OUT_DIR}/Find${ARG_PACKAGE}.cmake" PARENT_SCOPE)
message(STATUS "Generated find module containing the imported target \"${ARG_PACKAGE}::${ARG_PACKAGE}\"")

endfunction(generate_find_module)
