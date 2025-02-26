while IFS= read -r file; do
  name="${file%.*}" # Removes the last extension
  ttx -o "$name.xml" "$file"
done <l.txt
