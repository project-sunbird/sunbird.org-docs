#!/bin/bash
# wget https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64
# chmod +x yq_linux_amd64
# mv yq_linux_amd64 yq
echo -e "Generating the proxy validator yaml by merging all the API definition into 1"
yaml-merge $(find apis -name *.yaml | tr "\n" " ") > intermediate-1.yml
# Remove the unwanted fields from the proxyvalidator
# Now clean the intermediate file
echo -e "Cleaning the files to have minimal and required fileds"
./yq delete intermediate-1.yml servers > intermediate-2.yml
./yq delete intermediate-2.yml paths.*.*.description > intermediate-3.yml
./yq delete intermediate-3.yml paths.*.*.operationId > intermediate-4.yml
./yq delete intermediate-4.yml paths.*.*.tags > intermediate-5.yml
./yq delete intermediate-5.yml paths.*.*.responses.*.content.*.example > intermediate-6.yml
./yq delete intermediate-6.yml paths.*.*.responses.*.content.*.examples > intermediate-7.yml
./yq delete intermediate-7.yml tags > intermediate-8.yml
./yq delete intermediate-8.yml security > intermediate-9.yml
./yq delete intermediate-9.yml externalDocs > intermediate-10.yml
./yq delete intermediate-10.yml paths.*.*.requestBody.content.*.examples > intermediate-11.yml
./yq delete intermediate-11.yml paths.*.*.requestBody.content.*.example > intermediate-12.yml
echo -e "Find the final validated file \"spec.yml\""
mv intermediate-12.yml spec.yml
rm -rf intermediate-*.yml