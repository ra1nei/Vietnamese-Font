#!/bin/bash

# Get font list using fc-list if no file is provided
if [ -z "$1" ]; then
  FONT_LIST=$(fc-list : family style file)
else
  FONT_LIST=$(cat "$1")
fi

# Declare an associative array to group fonts
declare -A FONT_GROUPS

# Read the font list line by line
while IFS= read -r line; do
  # Extract file path, family, and style using regex
  FILE=$(echo "$line" | awk -F ':' '{print $1}')
  FAMILY=$(echo "$line" | awk -F ':' '{print $2}' | sed 's/^ *//')
  STYLE=$(echo "$line" | awk -F ':' '{print $3}' | sed 's/^ *//')

  # Generate a unique key based on family and style
  KEY="${FAMILY} | ${STYLE}"

  # Append file path to the corresponding key (space-separated)
  if [[ -n "${FONT_GROUPS[$KEY]}" ]]; then
    FONT_GROUPS["$KEY"]+="_____$FILE"
  else
    FONT_GROUPS["$KEY"]="$FILE"
  fi
done <<<"$FONT_LIST"

# Print grouped fonts with more than 1 entry
for KEY in "${!FONT_GROUPS[@]}"; do
  # Convert space-separated paths into newline-separated list
  FONT_LIST=$(echo "${FONT_GROUPS[$KEY]}" | sed 's/_____/\n/g')

  # Count the number of lines (i.e., number of files)
  COUNT=$(echo "$FONT_LIST" | grep -c '^')

  if [ "$COUNT" -gt 1 ]; then
    if [[ "$FONT_LIST" == *font-chua-viet-hoa-hoac-viet-hoa-mot-phan* ]]; then
      echo -e "$FONT_LIST" >>result.txt
      echo "" >>result.txt # Add a blank line for readability
    fi

  fi
done
