#!/usr/bin/env bash
fm () {
  while true; do
    selection="$(lsd -a -1 | fzf \
               --height 95% \
               --reverse \
               --info inline-right \
               --prompt "$ " \
               --border "bold" \
               --border-label "$(pwd)" \
               --bind "h:pos(2)+accept" \
               --bind "l:accept" \
               --bind "j:down" \
               --bind "k:up" \
               --bind "q:abort" \
               --preview-window=right:65% \
               --preview 'sel=$(echo {} | cut -d " " -f 2); cd_pre="$(echo $(pwd)/$(echo {}))";
                          echo $cd_pre;
                          lsd -a --color=always "${cd_pre}";
                           
                          cur_file="$(file $(echo $sel) | grep [Tt]ext | wc -l)";
                          if [[ "${cur_file}" -eq 1 ]]; then
                            bat --style=numbers --theme=ansi --color=always $sel 2>/dev/null
                          else
                            chafa -c full --color-space rgb --dither none -p on -w 9 2>/dev/null {}
                          fi')"
    if [[ -d ${selection} ]]; then
      >/dev/null cd "${selection}"
    elif [[ -f "${selection}" ]]; then
      file_type=$(file -b --mime-type "${selection}" | cut -d'/' -f1)
      case $file_type in
      "text")
        vi "${selection}"
        ;;
      "image")
        sxiv "${selection}"
        ;;
      "video")
        mpv -fs "${selection}" > /dev/null
        ;;
      "audio")
        mpv --no-audio-display "${selection}"
        clear
        ;;
      "application")
        for fType in ${selection}; do
        if [[ "${fType}" == *.pdf ]]; then
          gv 2>/dev/null "${selection}"
        fi
        done
        ;;
      esac
    else
      break
    fi
  done
}

clear
fm
