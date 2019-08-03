# - Find Alibaba ASR SDK
#
# C++ SDK 2.0
#
# On all CMake versions: (Note that on CMake 2.8.10 and earlier)
#  NLSSDK_LIBRARY - a specific lib in Nlssdk for searching
#  NLSSDK_LIBRARIES - group all Nlssdk libs.
#  NLSSDK_LIBRARY_IS_SHARED - if we know for sure NLSSDK_LIBRARY is shared, this is true-ish. We try to "un-set" it if we don't know one way or another.
#  NLSSDK_INCLUDE_DIR - Include directory - should (generally?) not needed if you require CMake 2.8.11+ since it handles target include directories.
#
#  NLSSDK_FOUND - True if Alibaba NlsSDK was found.
#
# Original Author:
# 2019 Hai Liang Wang <hain@chatopera.com>
#
# Copyright Chatopera Inc. 2019.
include(FindPackageHandleStandardArgs)
# Ensure that if this is TRUE later, it's because we set it.
set(NLSSDK_FOUND FALSE)

FIND_PATH(NLSSDK_INCLUDE_DIR iNlsRequest.h
  ${CMAKE_CURRENT_SOURCE_DIR}/include/nlssdk
)

SET(NLSSDK_LIB_NAMES nlsCommonSdk)
FIND_LIBRARY(NLSSDK_LIBRARY
  NAMES ${NLSSDK_LIB_NAMES}
  HINTS
    ${CMAKE_CURRENT_SOURCE_DIR}/lib
  PATHS
    /usr/lib
    /usr/local/lib
)

IF (NLSSDK_LIBRARY AND NLSSDK_INCLUDE_DIR)
    GET_FILENAME_COMPONENT(NLSSDK_LIBRARY_DIRNAME ${NLSSDK_LIBRARY} DIRECTORY)
    # MESSAGE(STATUS "NLSSDK_LIBRARY_DIRNAME --> " ${NLSSDK_LIBRARY_DIRNAME})
    SET(NLSSDK_LIBRARIES ${NLSSDK_LIBRARY_DIRNAME}/libnlsCppSdk.so 
                ${NLSSDK_LIBRARY_DIRNAME}/libnlsCommonSdk.so)
    SET(NLSSDK_LIBRARY_IS_SHARED "YES")
    SET(NLSSDK_FOUND "YES")
ELSE (NLSSDK_LIBRARY AND NLSSDK_INCLUDE_DIR)
  SET(NLSSDK_FOUND "NO")
ENDIF (NLSSDK_LIBRARY AND NLSSDK_INCLUDE_DIR)

IF (NLSSDK_FOUND)
    MESSAGE(STATUS "Found Alibaba Nlssdk headers: NLSSDK_INCLUDE_DIR --> " ${NLSSDK_INCLUDE_DIR})
    MESSAGE(STATUS "Found Alibaba Nlssdk library: NLSSDK_LIBRARIES --> " ${NLSSDK_LIBRARIES})
ELSE (NLSSDK_FOUND)
   IF (Nlssdk_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find Alibaba Nlssdk library")
   ENDIF (Nlssdk_FIND_REQUIRED)
ENDIF (NLSSDK_FOUND)