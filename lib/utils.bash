#!/usr/bin/env bash

set -euo pipefail

GH_ORG="ArtifexSoftware"
GH_REPO="ghostpdl-downloads"
GH_REPO_URL="https://github.com/${GH_ORG}/${GH_REPO}"
TOOL_NAME="ghostscript"
TOOL_TEST="gs --version"
SUPPORTED_ARCH="x86_64"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO_URL" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^gs10.*//' # Remove gs10* as it does not have any published binaries
}

list_all_versions() {
	list_github_tags
}

check_arch() {
	local arch
	arch="$(uname -m)"
	if [ "$arch" != "$SUPPORTED_ARCH" ]; then
		fail "asdf-$TOOL_NAME only support $SUPPORTED_ARCH"
	fi
}

download_release() {
	check_arch
	local version filename url
	version="$1"
	filename="$2"

	url=$(curl -s -L -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/$GH_ORG/$GH_REPO/releases | grep -E "${version}/ghostscript.*x86_64.tgz" | sed 's|.*"\(https://.*\)"|\1|g')

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	check_arch
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH/gs-${version#"gs"}-linux-x86_64" "$install_path/gs"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
