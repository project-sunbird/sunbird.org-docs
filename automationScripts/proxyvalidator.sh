#!/bin/bash
# Author S M Y ALTAMASH <smy.altamash@gmail.com>
set -eo pipefail

directoryLocation=$(readlink -f $0| rev | cut -d '/' -f2- | rev)
cd ${directoryLocation}
echo -e "Generating the proxy validator yaml by merging all the API definition into 1"

# Install yaml-merge for merging all the yaml files
npm install @alexlafroscia/yaml-merge

completeFile=$(yaml-merge $(find ${directoryLocation}/../apis -name *.yaml | tr "\n" " "))

echo "$completeFile" > completeOpenApiSpecFile.yml
tmpFile=""

# Patterns to delete from the spec file
patterns=("servers" "paths.*.*.description" "paths.*.*.operationId" "paths.*.*.tags" "paths.*.*.responses.*.content.*.example" "paths.*.*.responses.*.content.*.examples" "tags" "security" "externalDocs" "paths.*.*.requestBody.content.*.examples" "paths.*.*.requestBody.content.*.example")

# Remove the unwanted fields from the proxyvalidator
# Now clean the intermediate file
echo -e "Cleaning the files to have minimal and required fileds"
for pattern in ${patterns[@]};
do
  echo "Removing $pattern from the yaml file"
  tmpFile=$(echo "$completeFile" | ./yq delete - $pattern)
  completeFile=$tmpFile
done

echo "$completeFile" > spec.yml
echo -e "Find the final validated file \"spec.yml\""
