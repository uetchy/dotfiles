


# youtube-dl "$1" --add-metadata --all-subs --merge-output-format mkv -f 'bestvideo[vcodec=vp9][height<=480]+bestaudio'

ydlmin() {
  youtube-dl "$1" --add-metadata --all-subs -f 'best[height<=360]'
}

ydl() {
  youtube-dl "$1" --add-metadata --all-subs -f 'best[height<=720]'
}

ydlmax() {
  youtube-dl "$1" --add-metadata --all-subs -f 'best'
}

ydla() {
  youtube-dl "$1" -x --embed-thumbnail --add-metadata --audio-format=mp3
}

convert-video-to-mp3() {
  local INPUT="${1}"
  local FILENAME="${1:r}"
	local DIR=$(dirname $1)
	ffmpeg -y -i "${INPUT}" -vframes 1 "${FILENAME}.jpg"
	ffmpeg -y -i "${INPUT}" -i "${FILENAME}.jpg" -acodec libmp3lame -b:a 96k -c:v copy -map 0:a:0 -map 1:v:0 "${FILENAME}.mp3"
	rm "${FILENAME}.jpg"
}

convert-video() {
  local from=${1:?'usage: convert-video <from> [<to>]'}
  local to=${2:-mp4}
  for f (*.${from}) [[ ! -f ${f:r}.${to} ]] && ffmpeg -i ${f:r}.{${from},${to}}
}

convert-twitter-video() {
  local from=${1:?'usage: convert-twitter-video <from>'}
  ffmpeg -i "$from" -t 140 -vf scale=1280:720:flags=lanczos+accurate_rnd -b:v 2048k -r 30000/1001 -g 15 -bf 2 -pix_fmt nv12 -c:v h264 -profile:v high422 -c:a aac -b:a 128k -profile:a aac_low -movflags +faststart "${from:r}.output.${from:e}"
}

# waifu2x
waifu2x() {
  curl -X POST http://polka.local:8812/api \
    -F style=art \
    -F scale=2 \
    -F noise=0 \
    -F "file=@${1}" \
    --output "${1%.*}-waifu2x.png"
}

waifu2x.local() {
  docker run --rm -it -v $(pwd):/srv/waifu2x nothink/waifu2x -q -m noise_scale --noise_level 2 --scale_ratio "2.0" -i "/srv/waifu2x/$1" -o "/srv/waifu2x/${1%.*}-waifu2x.png"
}

# pdf utils
alias convert-dir-to-pdf="find . -type d | while read d; do convert \"\${d}\"/*.(jpeg|JPEG|jpg|JPG|png|PNG|webp) \"./\${d##*/}.pdf\"; done"

reduce-pdf() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="${1%.*}-reduced.pdf" "${1}"
  mv "${1}" "${1%.*}-orig.pdf"
  mv "${1%.*}-reduced.pdf" "${1}"
}
