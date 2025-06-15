#! /usr/bin/env bash

get_image_tag() {
  local base_tag
  local git_hash
  local git_info_suffix # This will store the +<hash>[+dirty] or +nogit part

  # Attempt to get the latest git tag using 'git describe'.
  # --tags: uses any tag, not just annotated
  # --abbrev=0: ensures the full tag name is returned without additional hash info
  if ! base_tag=$(git describe --tags --abbrev=0 2>/dev/null); then
    # If 'git describe' fails (e.g., no tags yet, or not in a git repository),
    # use "0.0.0" as a sensible default base tag.
    # You could change "0.0.0" to "latest" or another default if preferred.
    base_tag="0.0.0"
  fi

  # Get the short git commit hash (first 5 characters)
  if git_hash=$(git rev-parse --short=5 HEAD 2>/dev/null); then
    git_info_suffix="-${git_hash}"
    # Check if the working directory has uncommitted changes
    if ! git diff --quiet HEAD --; then
      git_info_suffix+="-dirty"
    fi
  else
    # Fallback if not in a git repository or git is not installed
    git_info_suffix="-nogit"
  fi

  echo "${base_tag}${git_info_suffix}"
}

get_image_tag "$@"
# Usage: Call this script to get the image tag
