# mt-plugin-read-more
記事・ウェブページに「続きを読む」機能を提供します。
(The plugin provides "read more" function to an Entry/WebPage.)

## インストール(Install)

1. plugins/ReadMore を MT_DIR/plugins にコピーする
2. mt-static/plugins/ReadMore を MT_DIR/mt-static/plugins にコピーする ( mt-static を DocumentRoot 配下などに移動させている場合は、 DocumentRoot/mt-static/plugins にコピーする )
※ MT_DIR は mt.cgi が設置されているディレクトリに読み替えてください

## 使い方

### 所定のタグを記述して各記事・ウェブページの任意の箇所に「続きを読む」を挿入する使い方

１. 記事やウェブページの本文内にて、「続きを読む」を挿入したい箇所に次のタグを記入する（フォーマットは「なし」を選択して記入すること）。
```
<div class="readmore-link"></div>
```

２. 1を記入した以降の本文を
```
<p id="readmore" class="readmore-area">本文の続き（初期では非表示にする部分）</p>
```
などのようにid="readmore"、class="readmore-area"を指定したブロックタグで囲む。

### 文字数を指定して全記事・ウェブページに一括で「続きを読む」を挿入する使い方

1. ReadMore のプラグイン設定を開き、「文字数で挿入する」にチェックを入れ、「文字数」に数値を指定する。
2. 再構築する

#### 注意事項

1. プラグインは本文の指定した文字数目に「続きを読む」の挿入を試みますが、HTMLタグの途中で「続きを読む」を挿入してHTMLが壊れてしまう場合はその位置での挿入をやめて、その位置の後でHTML構造が壊れない直近の位置に挿入を行います。
2. プラグインは本文に含まれるHTMLタグも文字数にカウントします。そのため、見た目上にて必ずしも指定した文字数目に「続きを読む」が挿入されません。
3. この使い方をする場合、プラグインは本文を次のタグで囲みます。
```
<div id="readmore-wraptext"></div>
```
