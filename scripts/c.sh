while IFS= read -r file; do
  name="${file%.*}" # Removes the last extension
  if grep -q "UTM" "$name.xml"; then
    mv "$name.xml" "UTM/"
  fi
done <l.txt
