

# youtube-dl
ydl() {
  youtube-dl "$1" -f mp4 --add-metadata --all-subs
}

ydla() {
  youtube-dl "$1" -x --audio-format=mp3 --embed-thumbnail --add-metadata
}

convert-video-to-mp3() {
  local INPUT="${1}"
  local FILENAME="${1:r}"
	local DIR=$(dirname $1)
	ffmpeg -y -i "${INPUT}" -vframes 1 "${FILENAME}.jpg"
	ffmpeg -y -i "${INPUT}" -i "${FILENAME}.jpg" -acodec libmp3lame -b:a 96k -c:v copy -map 0:a:0 -map 1:v:0 "${FILENAME}.mp3"
	rm "${FILENAME}.jpg"
}

# waifu2x
waifu2x() {
  docker run --rm -it -v $(pwd):/srv/waifu2x nothink/waifu2x -q -m noise_scale --noise_level 2 --scale_ratio "2.0" -i "/srv/waifu2x/$1" -o "/srv/waifu2x/${1%.*}-waifu2x.png"
}

# pdf utils
alias convert-dir-to-pdf="find . -type d | while read d; do convert \"\${d}\"/*.(jpeg|JPEG|jpg|JPG|png|PNG|webp) \"./\${d##*/}.pdf\"; done"

reduce-pdf() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${1%.*}-reduced.pdf" "${1}"
  mv "${1}" "${1%.*}-orig.pdf"
  mv "${1%.*}-reduced.pdf" "${1}"
}