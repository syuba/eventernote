curl -k -s  "https://www.eventernote.com/users/Schwarz_H/events" | grep -v colspan | grep "year=" | grep 2016 | sed -e "s/<[^>]*month=//g" | sed -e "s/\">/   /g" -e "s/<\/a>//g" -e "s/           //g”
