set(proj freetype)
set(${proj}_ROOT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${proj}")
set(${proj}_SOURCE_DIR "${${proj}_ROOT_DIR}/${proj}")
set(${proj}_BINARY_DIR "${${proj}_ROOT_DIR}/${proj}-build")
set(${proj}_INSTALL_DIR "${${proj}_ROOT_DIR}/${proj}-install")

ExternalProject_Add( ${proj}
  DEPENDS zlib
  SOURCE_DIR "${${proj}_SOURCE_DIR}"
  BINARY_DIR "${${proj}_BINARY_DIR}"
  URL "http://paraview.org/files/dependencies/freetype-2.4.8.tar.gz"
  URL_MD5 "5d82aaa9a4abc0ebbd592783208d9c76"
  CONFIGURE_COMMAND ""
  #BUILD_IN_SOURCE 1
  BUILD_COMMAND
    ${CMAKE_COMMAND}
      -DFTJAM_EXECUTABLE:PATH=${FTJAM_EXECUTABLE}
      -DWORKING_DIRECTORY:PATH=${freetype_SOURCE_DIR}
      -P ${CMAKE_SOURCE_DIR}/freetype-build.cmake
  INSTALL_COMMAND
    ${CMAKE_COMMAND}
      -DSOURCE_DIR:PATH=${freetype_SOURCE_DIR}
      -DINSTALL_DIR:PATH=${freetype_INSTALL_DIR}
      -P ${CMAKE_SOURCE_DIR}/freetype-install.cmake
	)
  