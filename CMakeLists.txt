#
# Copyright (C) 2024 SOHNE, Leandro Peres
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.25)
project(
  LuGL
  VERSION 0.0.1
  DESCRIPTION "An educational rendering engine"
  LANGUAGES CXX)

# Determine if LuGL is the main project
set(LUGL_IS_MAIN ${PROJECT_IS_TOP_LEVEL})

# --------------------------------------------------------------------
# Paths
# --------------------------------------------------------------------
# Set CMake module path
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# --------------------------------------------------------------------
# Include External CMake Files
# --------------------------------------------------------------------
include(CMakeOptions.txt)
include(BuildOptions)

# --------------------------------------------------------------------
# Compiler Settings
# --------------------------------------------------------------------
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# --------------------------------------------------------------------
# Visibility Settings
# --------------------------------------------------------------------
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

# --------------------------------------------------------------------
# Output Directories
# --------------------------------------------------------------------
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)

# --------------------------------------------------------------------
# Global Properties
# --------------------------------------------------------------------
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# --------------------------------------------------------------------
# Subdirectories
# --------------------------------------------------------------------
add_subdirectory(src lugl)

# --------------------------------------------------------------------
# Conditional Subdirectories
# --------------------------------------------------------------------
if(LUGL_BUILD_UNIT_TESTS)
  # add_subdirectory(unit-test)
endif()

if(LUGL_BUILD_TESTBED)
  add_subdirectory(testbed)
endif()

# --------------------------------------------------------------------
# Installation Configuration
# --------------------------------------------------------------------
# Include GNU install directories
include(GNUInstallDirs)

# Install headers
install(DIRECTORY "${CMAKE_SOURCE_DIR}/include/lugl"
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
