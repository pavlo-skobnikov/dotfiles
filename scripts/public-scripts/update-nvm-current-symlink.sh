#!/usr/bin/env bash
set -euo pipefail

# Load `nvm` if not already loaded => in order to make `nvm current` available.
if [ -s "${NVM_DIR}/nvm.sh" ]; then
    . "${NVM_DIR}/nvm.sh"
else
    echo "ERROR: nvm.sh not found in ${NVM_DIR}. Is NVM installed?" >&2
    exit 1
fi

# Use current version to symlink.
current_version="$(nvm current)"
if [[ "${current_version}" == "none" ]]; then
    echo "ERROR: No active Node version. Please run 'nvm use <version>' first." >&2
    exit 1
fi

echo "Current NVM Node version: ${current_version}"

# Ensure ~/.nvm/current directory exists.
link_dir="${NVM_DIR}/current"
mkdir -p "${link_dir}"

# Remove any existing symlinks or files in link_dir
find "${link_dir}" -mindepth 1 -maxdepth 1 -exec rm -rf {} \;

# Symlink all executables from the active version's bin/ directory.
version_bin_dir="${NVM_DIR}/versions/node/${current_version}/bin"

if [ ! -d "${version_bin_dir}" ]; then
    echo "ERROR: Expected bin directory not found: ${version_bin_dir}" >&2
    exit 1
fi

symlinked_bins=''

for bin in "${version_bin_dir}"/*; do
    bin_name="$(basename "${bin}")"

    # Symlink bin.
    ln -s "${bin}" "${link_dir}/${bin_name}"

    # Collect symlinked binaries for output.
    if [[ -n $symlinked_bins ]]; then
        symlinked_bins+=", "
    fi
    symlinked_bins+="${bin_name}"
done

echo "Symlinks created in '${link_dir}': ${symlinked_bins}"
