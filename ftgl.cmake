set(proj ftgl)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS freetype
  GIT_REPOSITORY "https://github.com/ulrichard/ftgl.git"
  GIT_TAG cf4d9957930e41c3b82a57b20207242c7ef69f18
  SOURCE_DIR "${${proj}_SOURCE_DIR}"
  BINARY_DIR "${${proj}_BINARY_DIR}"
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS=OFF
	-DCMAKE_INSTALL_PREFIX:PATH=${ftgl_INSTALL_DIR}
	-DFREETYPE_INCLUDE_DIR_freetype2:PATH=${freetype_INSTALL_DIR}/include
	-DFREETYPE_INCLUDE_DIR_ft2build:PATH=${freetype_SOURCE_DIR}/include
	-DFREETYPE_LIBRARY:PATH=${freetype_INSTALL_DIR}/lib/freetype.lib
  )