cmake_minimum_required(VERSION 3.16)
project("autowap"
        VERSION 1.0.1
	DESCRIPTION "RaspberryPi Fallback WAP Setup"
        LANGUAGES NONE
)

set(AWAP_PKG ${CMAKE_CURRENT_SOURCE_DIR}/pkg )

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pkg
    COMMAND ODIR=${AWAP_PKG} SDIR=${CMAKE_CURRENT_SOURCE_DIR} VERS=${PROJECT_VERSION} make -f ${AWAP_PKG}/Makefile all && touch ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pkg
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/pkg/${PROJECT_NAME}.epm
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

add_custom_target(autowap_pkg ALL
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pkg
)
