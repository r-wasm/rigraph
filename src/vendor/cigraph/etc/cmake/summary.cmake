function(print_bool HEADING VAR)
  if(${VAR})
    set(LABEL "yes")
  else()
    set(LABEL "no")
  endif()
  print_str(${HEADING} ${LABEL})
endfunction()

function(print_str HEADING LABEL)
  string(LENGTH "${HEADING}" HEADING_LENGTH)
  math(EXPR REMAINING_WIDTH "30 - ${HEADING_LENGTH}")

  if("${LABEL}" STREQUAL "")
    pad_string(PADDED ${REMAINING_WIDTH} " " "${ARGN}")
  else()
    pad_string(PADDED ${REMAINING_WIDTH} " " "${LABEL}")
  endif()

  message(STATUS "${HEADING}: ${PADDED}")
endfunction()

#############################################################################

set(ALL_DEPENDENCIES ${REQUIRED_DEPENDENCIES} ${OPTIONAL_DEPENDENCIES} ${VENDORED_DEPENDENCIES})
list(SORT ALL_DEPENDENCIES CASE INSENSITIVE)

message(STATUS " ")
message(STATUS "-----[ Build configuration ]----")
print_str("Version" "${PACKAGE_VERSION}")
print_str("CMake build type" "${CMAKE_BUILD_TYPE}" "default")
if(BUILD_SHARED_LIBS)
  message(STATUS "Library type:             shared")
else()
  message(STATUS "Library type:             static")
endif()
if(${IGRAPH_INTEGER_SIZE} STREQUAL "AUTO")
  print_str("igraph_integer_t size" "auto")
elseif(${IGRAPH_INTEGER_SIZE} STREQUAL 64)
  print_str("igraph_integer_t size" "64 bits")
elseif(${IGRAPH_INTEGER_SIZE} STREQUAL 32)
  print_str("igraph_integer_t size" "32 bits")
else()
  print_str("igraph_integer_t size" "INVALID")
endif()
if(USE_CCACHE)
  if(CCACHE_PROGRAM)
    message(STATUS "Compiler cache:           ccache")
  endif()
else()
  message(STATUS "Compiler cache:         disabled")
endif()

message(STATUS " ")
message(STATUS "----------[ Features ]----------")
print_bool("GLPK for optimization" IGRAPH_GLPK_SUPPORT)
print_bool("Reading GraphML files" IGRAPH_GRAPHML_SUPPORT)
print_bool("Thread-local storage" IGRAPH_ENABLE_TLS)
print_bool("Link-time optimization" IGRAPH_ENABLE_LTO)
message(STATUS " ")

message(STATUS "--------[ Dependencies ]--------")
foreach(DEPENDENCY ${ALL_DEPENDENCIES})
  list(FIND VENDORED_DEPENDENCIES "${DEPENDENCY}" INDEX)
  if(INDEX EQUAL -1)
    print_bool("${DEPENDENCY}" ${DEPENDENCY}_FOUND)
  else()
    print_str("${DEPENDENCY}" "vendored")
  endif()
endforeach()
message(STATUS " ")

message(STATUS "-----------[ Testing ]----------")
if(DIFF_TOOL)
  print_str("Diff tool" "diff")
elseif(FC_TOOL)
  print_str("Diff tool" "fc")
else()
  print_str("Diff tool" "not found")
endif()
print_str("Sanitizers" "${USE_SANITIZER}" "none")
print_bool("Code coverage" IGRAPH_ENABLE_CODE_COVERAGE)
print_bool("Verify 'finally' stack" IGRAPH_VERIFY_FINALLY_STACK)
message(STATUS " ")

message(STATUS "--------[ Documentation ]-------")
print_bool("HTML" HTML_DOC_BUILD_SUPPORTED)
print_bool("PDF" PDF_DOC_BUILD_SUPPORTED)
message(STATUS " ")

set(MISSING_DEPENDENCIES)
foreach(DEPENDENCY ${REQUIRED_DEPENDENCIES})
  if(NOT ${DEPENDENCY}_FOUND)
    list(APPEND MISSING_DEPENDENCIES ${DEPENDENCY})
  endif()
endforeach()

if(MISSING_DEPENDENCIES)
  list(JOIN MISSING_DEPENDENCIES ", " GLUED)
  message(FATAL_ERROR "The following dependencies are missing: ${GLUED}")
else()
  message(STATUS "igraph configured successfully.")
  message(STATUS " ")
endif()
