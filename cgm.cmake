set(proj cgm)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS oce
  GIT_REPOSITORY "git://github.com/chrismullins/cgma.git"
  GIT_TAG "cmake"
  SOURCE_DIR "${${proj}_SOURCE_DIR}"
  BINARY_DIR "${${proj}_BINARY_DIR}"
  CMAKE_CACHE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=OFF
    -DCGM_OCC:BOOL=ON
    -DCGM_KCM:BOOL=OFF
    -DOCE_DIR:PATH=${oce_INSTALL_DIR}/cmake
    -DCMAKE_INSTALL_PREFIX:PATH=${cgm_INSTALL_DIR}
  )
