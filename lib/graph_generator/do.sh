for f in *.py; do
  [ -f "$f" ] || continue
  echo "=== running $f ==="
  python3 "$f" || { echo "$f failed — stop"; break; }
done
