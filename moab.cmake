set(proj moab)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

if(WIN32)
  set(${proj}_NETCDF_CXX_LIBRARY ${netcdf_INSTALL_DIR}/lib/netcdf.lib)
  # Use bin/szip_D.dll if you're building with shared libs
  set(${proj}_SZIP_LIBRARY ${szip_INSTALL_DIR}/lib/libszip_D.lib)
  set(${proj}_ZLIB_LIBRARY ${zlib_INSTALL_DIR}/lib/zlibd.lib)
  set(${proj}_HDF5_LIB ${hdf5_INSTALL_DIR}/lib/hdf5d.lib)
  set(${proj}_HDF5_HL_LIB ${hdf5_INSTALL_DIR}/lib/hdf5_hld.lib)
  set(${proj}_CMAKE_CXX_STANDARD_LIBRARIES "${CMAKE_CXX_STANDARD_LIBRARIES} shlwapi.lib")
endif()

ExternalProject_Add( ${proj}
  DEPENDS hdf5 netcdf cgm
  SOURCE_DIR ${${proj}_SOURCE_DIR}
  BINARY_DIR ${${proj}_BINARY_DIR}
#  GIT_REPOSITORY https://bitbucket.org/judajake/moab.git
  GIT_REPOSITORY git://github.com/chrismullins/moab.git
  GIT_TAG "4.6.3_cmake-windows-fixes"
  CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${${proj}_INSTALL_DIR}
    -DHDF5_DIR:PATH=${hdf5_INSTALL_DIR}/share/cmake/hdf5
    -DENABLE_IMESH:BOOL=ON
    -DMOAB_USE_NETCDF:BOOL=ON
    -DMOAB_USE_HDF:BOOL=ON
#    -DHDF5_DIR:PATH=${hdf5_INSTALL_DIR}/share/cmake/hdf5
    -DHDF5_DIR:PATH=${hdf5_INSTALL_DIR}
    #-DHDF5_LIB:PATH=${moab_HDF5_LIB}
    #-DHDF5_HL_LIB:PATH=${moab_HDF5_HL_LIB}
    # -DHDF5_INCLUDE_DIR:PATH=${hdf5_INSTALL_DIR}/include
    -DMOAB_USE_CGM:BOOL=ON
    -DCGM_CFG:PATH=${cgm_INSTALL_DIR}/include/cgm.make
    -DNetCDF_DIR:PATH=${netcdf_INSTALL_DIR}/share/cmake
    -DNetCDF_CXX_LIBRARY:PATH=${moab_NETCDF_CXX_LIBRARY}
    -DNetCDF_C_LIBRARY:PATH=${moab_NETCDF_CXX_LIBRARY}
    -DNetCDF_INCLUDE_DIR:PATH=${netcdf_INSTALL_DIR}/include
    -DMOAB_USE_SZIP:BOOL=ON
    -DSZIP_LIBRARY:PATH=${moab_SZIP_LIBRARY}
    -DSZIP_INCLUDE_DIR:PATH=${szip_INSTALL_DIR}/include
    #-DCMAKE_CXX_FLAGS:STRING=-fPIC
    #-DCMAKE_C_FLAGS:STRING=-fPIC
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DCMAKE_CXX_STANDARD_LIBRARIES:STRING=${moab_CMAKE_CXX_STANDARD_LIBRARIES}
   # -DCMAKE_EXE_LINKER_FLAGS:STRING=-ldl
   -DMOAB_ENABLE_TESTING:BOOL=OFF
  )
