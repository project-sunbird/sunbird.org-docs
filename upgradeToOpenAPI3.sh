#!/bin/bash
#apis=$(find . -name *.yaml)
#for api in ${apis[@]};
#do
#  api_name=$(echo $api | cut -d '/' -f 3)
#  folder_name=$(echo $api | cut -d '/' -f 2)
#  echo "API NAME: $api_name" | tee -a output.txt
#  echo "converting file $api to swagger 3.0" | tee -a output.txt
#  curl -s 'https://converter.swagger.io/api/convert' \
#   -H 'authority: converter.swagger.io'  \
#   -H 'pragma: no-cache' \
#   -H 'cache-control: no-cache'  \
#   -H 'accept: application/yaml' \
#   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' \
#   -H 'content-type: application/yaml' \
#   -H 'origin: https://editor.swagger.io' \
#   -H 'sec-fetch-site: same-site' \
#   -H 'sec-fetch-mode: cors' \
#   -H 'sec-fetch-dest: empty' \
#   -H 'referer: https://editor.swagger.io/' \
#   -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
#   --data-binary "@$api" -o "$folder_name/3_${api_name}"
#  git add "$folder_name/3_${api_name}"
#  git commit -m "Upgrading the API definition for file \"${api_name}\" from swagger-2.0 to OPENAPI-3.0.1"
#  rm -rf $api
#  git add "$api"
#  git commit -m "Remove the API older api file \"${api_name}\""
#  mv "$folder_name/3_${api_name}" $api
#  git add "$api"
#  git commit -m "Renaming file $api file as per the standards"
#done

curl -s 'https://converter.swagger.io/api/convert' \
   -H 'authority: converter.swagger.io'  \
   -H 'pragma: no-cache' \
   -H 'cache-control: no-cache'  \
   -H 'accept: application/yaml' \
   -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36' \
   -H 'content-type: application/yaml' \
   -H 'origin: https://editor.swagger.io' \
   -H 'sec-fetch-site: same-site' \
   -H 'sec-fetch-mode: cors' \
   -H 'sec-fetch-dest: empty' \
   -H 'referer: https://editor.swagger.io/' \
   -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
   --data-binary "@apis/definitions/schemas/education.yaml" -o education.yml
