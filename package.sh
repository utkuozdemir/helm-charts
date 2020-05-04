#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ $# -eq 0 ]; then
  echo "No arguments supplied. Pass the helm chart directory as the first parameter."
  exit 1
fi

repo_url=https://utkuozdemir.org/helm-charts
package_dir=$1

helm package "$package_dir"
mv "$package_dir"*.tgz docs/
helm repo index docs/ --url $repo_url
git add --all
