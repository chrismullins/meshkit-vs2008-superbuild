set(proj hdf5)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

if(WIN32)
 # Use bin/szip_D.dll if you're building with shared libs
  set(${proj}_SZIP_LIBRARY ${szip_INSTALL_DIR}/lib/libszip_D.lib)
  set(${proj}_ZLIB_LIBRARY ${zlib_INSTALL_DIR}/lib/zlibd.lib)
else()
  set(${proj}_SZIP_LIBRARY ${szip_INSTALL_DIR}/lib/libszip.${SHARED_LIBRARY_SUFFIX})
endif()

ExternalProject_Add( ${proj}
  DEPENDS szip zlib
  SOURCE_DIR ${${proj}_SOURCE_DIR}
  BINARY_DIR ${${proj}_BINARY_DIR}
  URL "http://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.8/src/hdf5-1.8.8.tar.gz"
  URL_MD5 1196e668f5592bfb50d1de162eb16cff
  CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${hdf5_INSTALL_DIR}
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DHDF5_ENABLE_Z_LIB_SUPPORT:BOOL=ON
    -DHDF5_ENABLE_SZIP_SUPPORT:BOOL=ON
    -DHDF5_ENABLE_SZIP_ENCODING:BOOL=ON
    -DHDF5_BUILD_HL_LIB:BOOL=ON
    -DSZIP_LIBRARY:PATH=${hdf5_SZIP_LIBRARY}
    -DSZIP_INCLUDE_DIR:PATH=${szip_INSTALL_DIR}/include
    -DZLIB_LIBRARY:PATH=${hdf5_ZLIB_LIBRARY}
    -DZLIB_INCLUDE_DIR:PATH=${zlib_INSTALL_DIR}/include
  )
