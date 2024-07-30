# --------------------------------------------------------------------
# GLM
# --------------------------------------------------------------------
find_package(glm CONFIG REQUIRED)
list(APPEND LIBS glm::glm)
# Or use the header-only version
#target_link_libraries(main PRIVATE glm::glm-header-only)
