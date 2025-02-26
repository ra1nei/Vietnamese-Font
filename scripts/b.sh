while IFS= read -r file; do
  name="${file%.*}" # Removes the last extension
  ttx -o "$file" "$name.xml"
done <l.txt
