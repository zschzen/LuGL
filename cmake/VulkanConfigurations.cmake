set(VENDOR_PATH "${PROJECT_SOURCE_DIR}/vendor/khronos")
list(APPEND VENDOR_LIBS KHR vulkan-headers/ vulkan-headers/vk_video)

foreach(VENDOR_LIB ${VENDOR_LIBS})
  set(VENDOR_LIB_PATH "${VENDOR_PATH}/${VENDOR_LIB}")

  if(EXISTS ${VENDOR_LIB_PATH})
    list(APPEND LUMINA_INCLUDE_DIR ${VENDOR_LIB_PATH})
  else()
    message(
      WARNING
        "Vendor library '${VENDOR_LIB}' does not exist at '${VENDOR_LIB_PATH}'")
  endif()
endforeach()

find_package(Vulkan QUIET)
list(APPEND LIBS Vulkan::Vulkan)
list(APPEND LUMINA_INCLUDE_DIR ${Vulkan_INCLUDE_DIRS})
