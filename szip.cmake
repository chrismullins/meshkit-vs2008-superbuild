set(proj szip)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS
  SOURCE_DIR ${${proj}_SOURCE_DIR}
  BINARY_DIR ${${proj}_BINARY_DIR}
  URL "http://www.hdfgroup.org/ftp/lib-external/szip/2.1/src/szip-2.1.tar.gz"
  URL_MD5 902f831bcefb69c6b635374424acbead
  # BUG: szip does not install ricehdf.h
  # replace the file with an appropriate version.
  PATCH_COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/patches/szip.src.CMakeLists.txt <SOURCE_DIR>/src/CMakeLists.txt
  CMAKE_CACHE_ARGS
    -DSZIP_ENABLE_ENCODING:BOOL=ON
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=${${proj}_INSTALL_DIR}
  )
