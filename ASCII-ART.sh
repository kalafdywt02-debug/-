case "$out" in
  1)
    if [ "$c" = "1" ]; then
      jp2a --width="$width" --colors --color-depth=24 "${extra[@]}" "$img"
    else
      printf '\e[38;5;%sm' "${CCODE[$c]}"
      jp2a --width="$width" "${extra[@]}" "$img"
      printf '\e[0m'
    fi
    ;;
  2)
    jp2a --width="$width" "${extra[@]}" "$img" --output="$outdir/$name.txt" \
      && echo "[OK] Saved: $outdir/$name.txt"
    ;;
  3)
    f="$outdir/$name.html"
    if [ "$c" = "1" ]; then
      jp2a --width="$width" --colors --html "${extra[@]}" "$img" --output="$f"
    else
      {
        echo "<html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"></head>"
        echo "<body style=\"background:#000;color:${CHEX[$c]}\"><pre style=\"font-family:monospace;line-height:1;font-size:8px\">"
        jp2a --width="$width" "${extra[@]}" "$img" | sed 's/&/\&amp;/g;s/</\&lt;/g;s/>/\&gt;/g'
        echo "</pre></body></html>"
      } > "$f"
    fi
    echo "[OK] Saved: $f"
    ;;
  *) echo "[!] Invalid option." ;;
esac

[ -n "$tmp" ] && rm -f "$tmp"
