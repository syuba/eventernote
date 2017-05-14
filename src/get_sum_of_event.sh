#/bin/bash
# 年・月別イベント参加数

# 定義
NOW=`date +"%Y"`
# curl 実行
function exec_curl(){
    curl -k -s  "https://www.eventernote.com/users/${1}/events" | grep -v colspan | grep -v "本日開催" | grep "year=" | grep ${2} | sed -e "s/<[^>]*month=//g" | sed -e "s/\">/	/g" -e "s/<\/a>//g" -e "s/           //g"
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
        # 出力ファイル名定義
        FILE_NAME=${user}_${START}-${END}
        # 出力ファイルが既に有ればbak
        if [ -e ${FILE_NAME}.tsv ];then 
            mv ${FILE_NAME}.tsv ${FILE_NAME}.tsv.old
        fi
        # 年別出力
        for y in `seq $((START)) $((END))`
        do
            echo ${y}": finished"
            exec_curl ${user} ${y} | sed -e "s/^ //g" > ${y}.txt
        done


        # グラフ用のデータ作成
        if [ -f ${FILE_NAME}.tsv ];then
            mv ${FILE_NAME}.tsv ${FILE_NAME}.tsv.old
        fi
        # 月
        echo "	1	2	3	4	5	6	7	8	9	10	11	12" > ${FILE_NAME}.tsv
        for i in `seq $((START)) $((END))`
        do
            retu=("$i")
            join -a 1 month.txt $i.txt | while read line
            do
                month=`echo ${line} | awk '{print $1}'`
                atai=`echo ${line} | awk '{print $2}'`
                month=$((month))
                if [ "$atai" = "" ];then
                    atai=0
                else
                    atai=$((atai))
                fi
                retu=("${retu[@]}" $atai)
                if [ "$month" = 12 ];then
                    echo "${retu[@]}" | sed -e "s/ /	/g" >> ${FILE_NAME}.tsv
                fi
            done
        done
#        rm *txt
        echo "completed!"
        exit
    fi
done
