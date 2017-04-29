#/bin/bash
# 年・月別イベント参加数

# 定義
NOW=`date +"%Y"`
# curl 実行
function exec_curl(){
    curl -k -s  "https://www.eventernote.com/users/${1}/events" | grep -v colspan | grep -v "本日開催" | grep "year=" | grep ${2} | sed -e "s/<[^>]*month=//g" | sed -e "s/\">/   /g" -e "s/<\/a>//g" -e "s/           //g"
}

# 対話式
while true ;  do
    echo "■ アカウント名は？"
    read user
    # 変数KEYWORDが空文字なら無限ループする
    if [ "${user}" == "" ];then
        # ループの先頭に戻る
        continue
    fi

    echo "■ 何年から？"
    read START
    if [ "${START}" == "" ];then
        # ループの先頭に戻る
        continue
    fi
    if [ $((START)) -gt $((NOW)) -o $((START)) -lt 1990 ];then
        echo "指定した年が不正です"
        continue
    fi

    echo "■ 何年まで？"
    read END
    # 変数KEYWORDが空文字なら無限ループする
    if [ "${END}" == "" ];then
        # ループの先頭に戻る
        continue
    fi
    if [ $((END)) -gt $((NOW))  -o $((END)) -lt $((START)) ];then
        echo "指定した年が不正ですよ"
        continue
    else
        for y in `seq $((START)) $((END))`
        do
            echo ${y}:
            exec_curl ${user} ${y}
        done
        exit
    fi
done


