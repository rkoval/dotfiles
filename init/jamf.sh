#!/usr/bin/env bash
jamfDir=/usr/local/jamf/bin
if [ ! -d "$jamfDir" ]; then
  echo 'jamf not detected; ignoring jamf disable operations'
  exit
fi
echo "disabling jamf ..."
launchctl remove com.jamfsoftware.jamf.agent

files=(
  jamf
  jamfAgent
)

for file in "${files[@]}"; do
  if [ -e "$file" ]; then
    echo "disabling $file ..."
    mv "$file" "$file-disabled"
  else
    echo "couldn't find $jamfDir/$file (possibly already disabled?)"
  fi
done
