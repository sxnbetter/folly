include(CheckCXXSourceCompiles)
include(CheckIncludeFileCXX)

find_package(Boost 1.51.0 MODULE
  COMPONENTS
    context
    chrono
    date_time
    filesystem
    program_options
    regex
    system
    thread
  REQUIRED
)
list(APPEND FOLLY_LINK_LIBRARIES ${Boost_LIBRARIES})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${Boost_INCLUDE_DIRS})

find_package(DoubleConversion MODULE REQUIRED)
list(APPEND FOLLY_LINK_LIBRARIES ${DOUBLE_CONVERSION_LIBRARY})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${DOUBLE_CONVERSION_INCLUDE_DIR})

set(FOLLY_HAVE_LIBGFLAGS OFF)
find_package(gflags CONFIG QUIET)
if (gflags_FOUND)
  message(STATUS "Found gflags from package config")
  set(FOLLY_HAVE_LIBGFLAGS ON)
  set(FOLLY_SHINY_DEPENDENCIES ${FOLLY_SHINY_DEPENDENCIES} gflags)
  list(APPEND CMAKE_REQUIRED_LIBRARIES ${GFLAGS_LIBRARIES})
  list(APPEND CMAKE_REQUIRED_INCLUDES ${GFLAGS_INCLUDE_DIR})
else()
  find_package(GFlags MODULE)
  set(FOLLY_HAVE_LIBGFLAGS ${LIBGFLAGS_FOUND})
  list(APPEND FOLLY_LINK_LIBRARIES ${LIBGFLAGS_LIBRARY})
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBGFLAGS_INCLUDE_DIR})
  list(APPEND CMAKE_REQUIRED_LIBRARIES ${LIBGFLAGS_LIBRARY})
  list(APPEND CMAKE_REQUIRED_INCLUDES ${LIBGFLAGS_INCLUDE_DIR})
endif()

set(FOLLY_HAVE_LIBGLOG OFF)
find_package(glog CONFIG QUIET)
if (glog_FOUND)
  message(STATUS "Found glog from package config")
  set(FOLLY_HAVE_LIBGLOG ON)
  set(FOLLY_SHINY_DEPENDENCIES ${FOLLY_SHINY_DEPENDENCIES} glog::glog)
else()
  find_package(GLog MODULE)
  set(FOLLY_HAVE_LIBGLOG ${LIBGLOG_FOUND})
  list(APPEND FOLLY_LINK_LIBRARIES ${LIBGLOG_LIBRARY})
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBGLOG_INCLUDE_DIR})
endif()

find_package(Libevent CONFIG QUIET)
if(TARGET event)
  message(STATUS "Found libevent from package config")
  set(FOLLY_SHINY_DEPENDENCIES ${FOLLY_SHINY_DEPENDENCIES} event)
else()
  find_package(LibEvent MODULE REQUIRED)
  list(APPEND FOLLY_LINK_LIBRARIES ${LIBEVENT_LIB})
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBEVENT_INCLUDE_DIR})
endif()

find_package(OpenSSL MODULE REQUIRED)
list(APPEND FOLLY_LINK_LIBRARIES ${OPENSSL_LIBRARIES})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${OPENSSL_INCLUDE_DIR})

find_package(PThread MODULE)
set(FOLLY_HAVE_PTHREAD ${LIBPTHREAD_FOUND})
if (LIBPTHREAD_FOUND)
  list(APPEND CMAKE_REQUIRED_LIBRARIES ${LIBPTHREAD_LIBRARIES})
  list(APPEND CMAKE_REQUIRED_INCLUDES ${LIBPTHREAD_INCLUDE_DIRS})
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBPTHREAD_INCLUDE_DIRS})
  list(APPEND FOLLY_LINK_LIBRARIES ${LIBPTHREAD_LIBRARIES})
endif()

find_package(ZLIB MODULE)
set(FOLLY_HAVE_LIBZ ${ZLIB_FOUND})
if (ZLIB_FOUND)
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${ZLIB_INCLUDE_DIRS})
  list(APPEND FOLLY_LINK_LIBRARIES ${ZLIB_LIBRARIES})
endif()

find_package(BZip2 MODULE)
set(FOLLY_HAVE_LIBBZ2 ${BZIP2_FOUND})
if (BZIP2_FOUND)
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${BZIP2_INCLUDE_DIRS})
  list(APPEND FOLLY_LINK_LIBRARIES ${BZIP2_LIBRARIES})
endif()

find_package(LibLZMA MODULE)
set(FOLLY_HAVE_LIBLZMA ${LIBLZMA_FOUND})
if (LIBLZMA_FOUND)
  list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBLZMA_INCLUDE_DIRS})
  list(APPEND FOLLY_LINK_LIBRARIES ${LIBLZMA_LIBRARIES})
endif()

# TODO: We should ideally build FindXXX modules for the following libraries,
# rather than the simple checks we currently have here.
CHECK_INCLUDE_FILE_CXX(zstd.h FOLLY_HAVE_LIBZSTD)
if (FOLLY_HAVE_LIBZSTD)
  list(APPEND FOLLY_LINK_LIBRARIES zstd)
endif()
CHECK_INCLUDE_FILE_CXX(snappy.h FOLLY_HAVE_LIBSNAPPY)
if (FOLLY_HAVE_LIBSNAPPY)
  list(APPEND FOLLY_LINK_LIBRARIES snappy)
endif()
CHECK_INCLUDE_FILE_CXX(lz4.h FOLLY_HAVE_LIBLZ4)
if (FOLLY_HAVE_LIBLZ4)
  list(APPEND FOLLY_LINK_LIBRARIES lz4)
endif()

find_package(LibDwarf)
list(APPEND FOLLY_LINK_LIBRARIES ${LIBDWARF_LIBRARIES})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBDWARF_INCLUDE_DIRS})
CHECK_INCLUDE_FILE_CXX(libdwarf/dwarf.h FOLLY_HAVE_LIBDWARF_DWARF_H)

find_package(Libiberty)
list(APPEND FOLLY_LINK_LIBRARIES ${LIBIBERTY_LIBRARIES})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBIBERTY_INCLUDE_DIRS})

find_package(LibAIO)
list(APPEND FOLLY_LINK_LIBRARIES ${LIBAIO_LIBRARIES})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBAIO_INCLUDE_DIRS})

find_package(LibURCU)
list(APPEND FOLLY_LINK_LIBRARIES ${LIBURCU_LIBRARIES})
list(APPEND FOLLY_INCLUDE_DIRECTORIES ${LIBURCU_INCLUDE_DIRS})

list(APPEND FOLLY_LINK_LIBRARIES ${CMAKE_DL_LIBS})
list(APPEND CMAKE_REQUIRED_LIBRARIES ${CMAKE_DL_LIBS})
