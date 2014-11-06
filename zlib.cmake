set(proj zlib)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( zlib
  DEPENDS
  SOURCE_DIR "${${proj}_SOURCE_DIR}"
  BINARY_DIR "${${proj}_BINARY_DIR}"
  URL "http://www.paraview.org/files/v3.12/zlib-1.2.5.tar.gz"
  URL_MD5 c735eab2d659a96e5a594c9e8541ad63
  CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${${proj}_INSTALL_DIR}
    -DBUILD_SHARED_LIBS:BOOL=OFF
  PATCH_COMMAND ${CMAKE_COMMAND} -E remove -f <SOURCE_DIR>/zconf.h
 )
