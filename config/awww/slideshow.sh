#!/usr/bin/env bash
set -euo pipefail

wallpaper_dir="${HOME}/Wallpapers"
interval_seconds="${AWWW_SLIDESHOW_INTERVAL:-900}"

while ! awww query >/dev/null 2>&1; do
  sleep 1
done

while true; do
  if [[ -d "${wallpaper_dir}" ]]; then
    mapfile -d '' wallpapers < <(
      find "${wallpaper_dir}" -maxdepth 1 -type f \
        \( -iname '*.avif' -o -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.jxl' -o -iname '*.png' -o -iname '*.webp' \) \
        -print0
    )

    if (( ${#wallpapers[@]} > 0 )); then
      wallpaper="$(printf '%s\0' "${wallpapers[@]}" | shuf -z -n 1 | tr -d '\0')"
      awww img \
        --transition-type random \
        --transition-duration 2 \
        --transition-fps 60 \
        "${wallpaper}"
    fi
  fi

  sleep "${interval_seconds}"
done
