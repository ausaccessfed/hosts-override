#!/bin/bash

set -eu

echo 'Compiling hosts-override for multiple platforms'

# Triple is so we can keep using OS names in existing public documentation rather
# than updating and missing a reference somewhere, specifically macos over darwin
platforms=("windows/amd64/windows" "darwin/amd64/macos" "linux/amd64/linux")
tmp_dir=$(mktemp -d -t hostsoverride-XXXXXXXXX)

if [[ ! -e 'release' ]]; then
  mkdir 'release'
fi

for platform in "${platforms[@]}"; do
  echo 'Building for '$platform
  platform_split=(${platform//\// })
  GOOS=${platform_split[0]}
  GOARCH=${platform_split[1]}
  output_name='hosts-override'
  if [ $GOOS = "windows" ]; then
    output_name+='.exe'
  fi
  env GOOS=$GOOS GOARCH=$GOARCH go build -o $tmp_dir'/'$output_name
  zip -j 'release/'${platform_split[2]}'.zip' $tmp_dir'/'$output_name
done

echo 'Completed all platforms'
