# mt-plugin-read-more
記事・ウェブページに「続きを読む」機能を提供します。
(The plugin provides "read more" function to an Entry/WebPage.)

## インストール(Install)

1. plugins/ReadMore を MT_DIR/plugins にコピーする
2. mt-static/plugins/ReadMore を MT_DIR/mt-static/plugins にコピーする ( mt-static を DocumentRoot 配下などに移動させている場合は、 DocumentRoot/mt-static/plugins にコピーする )
※ MT_DIR は mt.cgi が設置されているディレクトリに読み替えてください

## 使い方

１. 記事やウェブページの本文内にて、「続きを読む」を挿入したい箇所に次のタグを記入する（フォーマットは「なし」を選択して記入すること）。
```
<div class="readmore-link"></div>
```

２. 1を記入した以降の本文を
```
<p id="readmore" class="readmore-area">本文の続き（初期では非表示にする部分）</p>
```
などのようにid="readmore"、class="readmore-area"を指定したブロックタグで囲む。
