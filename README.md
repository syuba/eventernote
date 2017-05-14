# eventernote
# sample request
- 実行
```
$ sh ./src/get_sum_of_event.sh
```
- レスポンス
```
■ アカウント名は？
Schwarz_H
■ 何年から？
2013
■ 何年まで？
2013: finished
2014: finished
2015: finished
2016: finished
2017: finished
completed!
```
# sample tsv file
```
$ open ./result/Schwarz_H_2013-2017.tsv
```
```
	 1	2	3	4	5	6	7	8	9	10	11	12
2013	 1	0	2	1	0	4	3	8	5	10	12	12
2014	 14	16	35	17	14	16	21	32	33	28	40	32
2015	 10	15	43	13	26	15	19	19	10	16	18	16
2016	 13	5	15	14	11	6	6	9	7	4	5	6
2017	 5	1	7	3	2	9	2	4	6	0	1	0
```

1. エクセル開く
2. [グラフ]->[折れ線グラフ]選択
