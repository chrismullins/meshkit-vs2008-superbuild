set(proj lasso)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS moab cgm
  GIT_REPOSITORY "git://github.com/chrismullins/lasso.git"
  GIT_TAG "cmake-build-system"
  SOURCE_DIR "${${proj}_SOURCE_DIR}"
  BINARY_DIR "${${proj}_BINARY_DIR}"
  CMAKE_CACHE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=OFF
	-DMOAB_DIR:PATH=${moab_INSTALL_DIR}/lib
	-DCGM_CFG:PATH=${cgm_INSTALL_DIR}/include/cgm.make
	-DCMAKE_INSTALL_PREFIX:PATH=${lasso_INSTALL_DIR}
  )