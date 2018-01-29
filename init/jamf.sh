#!/usr/bin/env bash
echo "disabling jamf ..."
jamfDir=/usr/local/jamf/bin
cd $jamfDir || (echo 'jamf not detected. exitting ...' && exit)
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
