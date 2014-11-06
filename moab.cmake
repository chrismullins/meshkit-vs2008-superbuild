set(proj moab)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS hdf5 netcdf cgm
  SOURCE_DIR ${${proj}_SOURCE_DIR}
  BINARY_DIR ${${proj}_BINARY_DIR}
  GIT_REPOSITORY https://bitbucket.org/judajake/moab.git
#  GIT_REPOSITORY git://github.com/chrismullins/moab.git
  GIT_TAG "4.6.3_cmake"
  CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${${proj}_INSTALL_DIR}
    -DHDF5_DIR:PATH=${hdf5_INSTALL_DIR}/share/cmake/hdf5
    -DENABLE_IMESH:BOOL=ON
    -DMOAB_USE_CGM:BOOL=ON
    -DMOAB_USE_NETCDF:BOOL=ON
    -DMOAB_USE_HDF:BOOL=ON
    -DCGM_CFG:PATH=${cgm_INSTALL_DIR}/include/cgm.make
    -DNetCDF_DIR:PATH=${netcdf_INSTALL_DIR}/share/cmake
    -DCMAKE_CXX_FLAGS:STRING=-fPIC
    -DCMAKE_C_FLAGS:STRING=-fPIC
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DCMAKE_EXE_LINKER_FLAGS:STRING=-ldl
  )
