#!/bin/bash

checkinput()
{
    if ! grep -E '^[0-9]+$' > /dev/null 2>&1 <<< "$1"; then
        return 1
    fi
    return 0
}

declare -a FACES

FACES[1]='( ͡° ͜ʖ ͡°)'
FACES[2]='¯\_(ツ)_/¯'
FACES[3]='▄︻̷̿┻̿═━一'
FACES[4]='( ͡°( ͡° ͜ʖ( ͡° ͜ʖ ͡°)ʖ ͡°) ͡°)'
FACES[5]='ʕ•ᴥ•ʔ'
FACES[6]='(▀̿Ĺ̯▀̿ ̿)'
FACES[7]='(ง ͠° ͟ل͜ ͡°)ง'
FACES[8]='ಠ_ಠ'
FACES[9]='(づ｡◕‿‿◕｡)づ'
FACES[10]='[̲̅$̲̅(̲̅5̲̅)̲̅$̲̅]'
FACES[11]='(ง'̀-'́)ง'
FACES[12]='(ಥ﹏ಥ)'
FACES[13]='(ノಠ益ಠ)ノ彡┻━┻'
FACES[14]='[̲̅$̲̅(̲̅ ͡° ͜ʖ ͡°̲̅)̲̅$̲̅]'
FACES[15]='(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧'
FACES[16]='(☞ﾟ∀ﾟ)☞'
FACES[17]='(◕‿◕✿)'
FACES[18]='(ᵔᴥᵔ)'
FACES[19]='(¬‿¬)'
FACES[20]='ლ(ಠ益ಠლ)'
FACES[21]='ಠ╭╮ಠ'
FACES[22]='(;´༎ຶД༎ຶ`)'
FACES[23]='♥‿♥'
FACES[24]='ヾ(⌐■_■)ノ♪'
FACES[25]='~(˘▾˘~)'
FACES[26]='◉_◉'
FACES[27]='(~˘▾˘)~'
FACES[28]='༼ʘ̚ل͜ʘ̚༽'
FACES[29]='┬┴┬┴┤(･_├┬┴┬┴'
FACES[30]='ᕙ(⇀‸↼‶)ᕗ'
FACES[31]='ᕦ(ò_óˇ)ᕤ'
FACES[32]='(｡◕‿‿◕｡)'
FACES[33]='ಥ_ಥ'
FACES[34]='ヽ༼ຈل͜ຈ༽ﾉ'
FACES[35]='⌐╦╦═─'
FACES[36]='(☞ຈل͜ຈ)☞'
FACES[37]='˙ ͜ʟ˙'
FACES[38]='☜(˚▽˚)☞'
FACES[39]='(•ω•)'
FACES[40]='(ง°ل͜°)ง'
FACES[41]='(｡◕‿◕｡)'
FACES[42]='(っ˘ڡ˘ς)'
FACES[43]='ಠ⌣ಠ'
FACES[44]='ლ(´ڡ`ლ)'
FACES[45]='(°ロ°)☝'
FACES[46]='｡◕‿‿◕｡'
FACES[47]='╚(ಠ_ಠ)=┐'
FACES[48]='(─‿‿─)'
FACES[49]='ƪ(˘⌣˘)ʃ'
FACES[50]='(；一_一)'
FACES[51]='(¬_¬)'
FACES[52]='☜(⌒▽⌒)☞'
FACES[53]='｡◕‿◕｡'
FACES[54]='¯\(°_o)/¯'
FACES[55]='(ʘ‿ʘ)'
FACES[56]='ლ,ᔑ•ﺪ͟͠•ᔐ.ლ'
FACES[57]='(´・ω・`)'
FACES[58]='ಠ~ಠ'
FACES[59]='(´・ω・)っ由'
FACES[60]='ಠ_ಥ'
FACES[61]='Ƹ̵̡Ӝ̵̨̄Ʒ'
FACES[62]='(&gt;ლ)'
FACES[63]='ಠ‿↼'
FACES[64]='ʘ‿ʘ'
FACES[65]='(ღ˘⌣˘ღ)'
FACES[66]='ಠoಠ'
FACES[67]='ರ_ರ'
FACES[68]='(▰˘◡˘▰)'
FACES[69]='◔̯◔'
FACES[70]='(✿´‿`)'
FACES[71]='¬_¬'
FACES[72]='ب_ب'
FACES[73]='｡゜(｀Д´)゜｡'
FACES[74]='(ó ì_í)=óò=(ì_í ò)'
FACES[75]='°Д°'
FACES[76]='٩◔̯◔۶'
FACES[77]='≧☉_☉≦'
FACES[78]='☼.☼'
FACES[79]='^̮^'
FACES[80]='(>人<)'
FACES[81]='〆(・∀・＠)'
FACES[82]='(~_^)'
FACES[83]='>_>'
FACES[84]='(^̮^)'
FACES[85]='=U'
FACES[86]='(･.◤)'
FACES[87]='¯\_(ツ)_/¯'
IFS=$'\n'
COUNT=1

if [ $# -eq 0 ]; then
    {  for face in ${FACES[*]}; do echo $COUNT $face; COUNT=$((COUNT+1)); done; } | column
    echo -n "Choose a face: [1-90] "
    read INPUT
else
    INPUT=$1
fi

if ! checkinput $INPUT; then
    exit 1
fi

echo "Clipboarding ${FACES[INPUT]}"
echo "${FACES[INPUT]}" | xclip -se c -r
