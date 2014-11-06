set(proj oce)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS ftgl freetype
  GIT_REPOSITORY "https://github.com/robertmaynard/oce.git"
  GIT_TAG "cgm_support"
  CMAKE_CACHE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=OFF
	-DOCE_DISABLE_X11:BOOL=FALSE
    -DOCE_VISU_DEP:BOOL=TRUE
    -DOCE_VISUALISATION:BOOL=TRUE
    -DOCE_OCAF:BOOL=TRUE
    -DOCE_DRAW:BOOL=FALSE
    -DFTGL_INCLUDE_DIR:PATH=${ftgl_INSTALL_DIR}/include
    -DOCE_INSTALL_PREFIX:FilePath=${oce_INSTALL_DIR}
    #force the include dir path, so it doesn't install the include files into
    #install/include/oce/, because than CGM can't find it.
    -DOCE_INSTALL_INCLUDE_DIR:FilePath=include
	-DFTGL_INCLUDE_DIR:PATH=${ftgl_INSTALL_DIR}/include
	-DFTGL_LIBRARY:PATH=${ftgl_INSTALL_DIR}/lib/ftgld.lib
	-DFREETYPE_INCLUDE_DIR_freetype2:PATH=${freetype_INSTALL_DIR}/include
	-DFREETYPE_INCLUDE_DIR_ft2build:PATH=${freetype_SOURCE_DIR}/include
	-DFREETYPE_LIBRARY:PATH=${freetype_INSTALL_DIR}/lib/freetype.lib
  )
  
  