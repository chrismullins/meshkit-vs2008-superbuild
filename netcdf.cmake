set(proj netcdf)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

if(WIN32)
 # Use bin/szip_D.dll if you're building with shared libs
  set(${proj}_SZIP_LIBRARY ${szip_INSTALL_DIR}/lib/libszip_D.lib)
  set(${proj}_ZLIB_LIBRARY ${zlib_INSTALL_DIR}/lib/zlibd.lib)
  set(${proj}_HDF5_LIB ${hdf5_INSTALL_DIR}/lib/hdf5d.lib)
  set(${proj}_HDF5_HL_LIB ${hdf5_INSTALL_DIR}/lib/hdf5_hld.lib)
endif()

ExternalProject_Add( ${proj}
  DEPENDS hdf5
  SOURCE_DIR ${${proj}_SOURCE_DIR}
  BINARY_DIR ${${proj}_BINARY_DIR}
  URL "ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.3.0.tar.gz"
  URL_MD5 40c0e53433fc5dc59296ee257ff4a813
  PATCH_COMMAND
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/patches/netcdf.src.CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt
  CMAKE_CACHE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DBUILD_UTILITIES:BOOL=ON
    -DENABLE_NETCDF:BOOL=ON
    -DUSE_SZIP:BOOL=ON
    -DSZIP_LIBRARY:PATH=${netcdf_SZIP_LIBRARY}
    -DSZIP_INCLUDE_DIR:PATH=${szip_INSTALL_DIR}/include
    -DUSE_HDF5:BOOL=ON
    -DHDF5_DIR:PATH=${hdf5_INSTALL_DIR}/share/cmake/hdf5
    -DHDF5_LIB:PATH=${netcdf_HDF5_LIB}
    -DHDF5_HL_LIB:PATH=${netcdf_HDF5_HL_LIB}
    -DHDF5_INCLUDE_DIR:PATH=${hdf5_INSTALL_DIR}/include
    -DENABLE_NETCDF_4:BOOL=ON
    -DENABLE_DAP:BOOL=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=${netcdf_INSTALL_DIR}
    -DZLIB_LIBRARY:PATH=${netcdf_ZLIB_LIBRARY}
    -DZLIB_INCLUDE_DIR:PATH=${netcdf_INSTALL_DIR}/include
    -DCMAKE_INSTALL_PREFIX:PATH=${netcdf_INSTALL_DIR}
  )

#  ExternalProject_Add_Step(netcdf patch_fix_ncgen3
#  COMMAND ${CMAKE_COMMAND} -E copy_if_different
#           ${CMAKE_SOURCE_DIR}/patches/netcdf.ncgen3.load.c
#          <SOURCE_DIR>/ncgen3/load.c
#  DEPENDEES update # do after update
#  DEPENDERS patch  # do before patch
#  )
    
