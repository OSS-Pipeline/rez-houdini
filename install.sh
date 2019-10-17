#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
HOUDINI_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "==============="
echo -e "=== INSTALL ==="
echo -e "==============="
echo -e "\n"

echo -e "[INSTALL][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[INSTALL][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[INSTALL][ARGS] HOUDINI VERSION: ${HOUDINI_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${INSTALL_PATH} || -z ${HOUDINI_VERSION} ]]; then
    echo -e "\n"
    echo -e "[INSTALL][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We install Houdini.
echo -e "\n"
echo -e "[INSTALL] Installing Houdini-${HOUDINI_VERSION}..."
echo -e "\n"

${EXTRACT_PATH}/houdini.install \
    --install-houdini \
    --install-engine-maya \
    --auto-install \
    --no-root-check \
    --accept-EULA \
    ${INSTALL_PATH}

echo -e "\n"
echo -e "[INSTALL] Finished installing Houdini-${HOUDINI_VERSION}!"
echo -e "\n"
