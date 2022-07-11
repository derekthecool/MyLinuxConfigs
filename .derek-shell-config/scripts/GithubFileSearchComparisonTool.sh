#!/bin/bash

searchTerm='workspacer.config.csx'
tmpFile=/tmp/codeLookupFile

curl -G https://api.github.com/search/code \
  --data-urlencode "q=filename:workspacer.config.csx" \
  -H "Accept: application/vnd.github.preview" \
  --header "Authorization: Token $(cat ~/.gh_access_token)" | 
  jq '.items[].html_url' > $tmpFile

# Exit script if query failed
[[ $? -ne 0 ]] && exit 1

saveDir=$(tr '.' '_' <<< "$searchTerm")
mkdir -p "$saveDir"
cd "$saveDir"

# Transform the file that we just downloaded containing the html_url to the raw
# github download form
sed -i 's/github.com/raw.githubusercontent.com/' $tmpFile 
sed -i 's/blob\///' $tmpFile 
sed -i 's/"//g' $tmpFile 

# Loop through each file and download it to a folder with the github username
# https://raw.githubusercontent.com/adolfocorreia/dotfiles/c231ba4559430e489df768ffb3277a9ec8bbf9cb/dot_workspacer/workspacer.config.csx
# Example username to capture: adolfocorreia
while IFS='' read -r line; do
  gh_user=$(grep -Po ".*com/\K(\w+/\w+)" <<< "$line")
  pushd .
  codeFolder="$gh_user"
  mkdir -p "$codeFolder"
  cd "$codeFolder"
  wget "$line"
  popd
done < $tmpFile
