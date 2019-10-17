CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

# We split the Houdini version string in multiple ones.
string(REPLACE "." ";" HOUDINI_VERSION_LIST ${REZ_BUILD_PROJECT_VERSION})
list(GET HOUDINI_VERSION_LIST 0 HOUDINI_MAJOR_VERSION)
list(GET HOUDINI_VERSION_LIST 1 HOUDINI_MINOR_VERSION)
list(GET HOUDINI_VERSION_LIST 2 HOUDINI_PATCH_VERSION)

# Houdini
rez_set_archive(
    HOUDINI_URL houdini/houdini-${REZ_BUILD_PROJECT_VERSION}-linux_x86_64_gcc6.3.tar.gz
    https://www.sidefx.com/download/download-houdini/60235/
)

# The environment variable REZ_TMP_PATH is meant to point to a location such as "/tmp/rez".
set(EXTRACT_DIR $ENV{REZ_TMP_PATH}/houdini/${REZ_BUILD_PROJECT_VERSION})

# We configure/build/install Houdini through the ExternalProject_Add macro,
# using three different shell scripts for each of these steps.
# If necessary, it is possible to skip one of these steps by replacing the command
# by "", an empty string.
ExternalProject_Add(
    REZ_HOUDINI
    URL ${HOUDINI_URL}
    PREFIX houdini
    SOURCE_DIR ${EXTRACT_DIR}
    PATCH_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND bash ${CMAKE_SOURCE_DIR}/install.sh ${EXTRACT_DIR}
)

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] Houdini-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
