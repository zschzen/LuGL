# --------------------------------------------------------------------
# Installation Configuration
# --------------------------------------------------------------------
# Install targets
install(
  TARGETS lugl
  EXPORT luglConfig
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

# Install export configuration
install(
  EXPORT luglConfig
  NAMESPACE lugl::
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/lugl")

# --------------------------------------------------------------------
# Package Configuration
# --------------------------------------------------------------------
include(CMakePackageConfigHelpers)

# Write package version file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/luglConfigVersion.cmake"
  COMPATIBILITY SameMajorVersion)

# Install package version file
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/luglConfigVersion.cmake"
        DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/lugl")
