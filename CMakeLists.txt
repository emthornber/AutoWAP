cmake_minimum_required(VERSION 3.16)
project("autowap"
        VERSION 1.0.3
	DESCRIPTION "RaspberryPi Fallback WAP Setup"
        LANGUAGES NONE
)

set(AWAP_CONFIG  ${CMAKE_CURRENT_SOURCE_DIR}/config )
set(AWAP_PKG ${CMAKE_CURRENT_SOURCE_DIR}/pkg )
set(AWAP_SCRIPTS ${CMAKE_CURRENT_SOURCE_DIR}/scripts )

add_custom_command(OUTPUT ${AWAP_CONFIG}/autowap.conf
    COMMAND python3 ${AWAP_SCRIPTS}/create_autowap_conf.py < ${AWAP_CONFIG}/autowap-config-defn.json > ${AWAP_CONFIG}/autowap.conf
    DEPENDS ${AWAP_CONFIG}/autowap-config-defn.json
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

add_custom_target(autowap-conf ALL
    DEPENDS ${AWAP_CONFIG}/autowap.conf
)

file(
    GLOB_RECURSE
    CONFIG_DEPS
    ${AWAP_CONFIG}/*
)

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pkg
    COMMAND ODIR=${AWAP_PKG} SDIR=${CMAKE_CURRENT_SOURCE_DIR} VERS=${PROJECT_VERSION} make -f ${AWAP_PKG}/Makefile all && touch ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pkg
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/pkg/${PROJECT_NAME}.epm ${AWAP_SCRIPTS}/autowapctl.bash ${CONFIG_DEPS}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

add_custom_target(autowap_pkg ALL
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pkg
)
