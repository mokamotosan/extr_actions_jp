# はじめに
## Extract Social Knowledge: 社会的知識の抽出
Extract Social Knowlegeは，人が社会的推論を行う際の知識体系の解明を目指すプロジェクトです．
## 社会的推論とは
人は，他者や社会的集団あるいは自分自身についてさまざまな推論を行います．たとえば，他者の行動の意図や目的，特定の社会的集団が持っているであろう信念やものごとに対する態度，他者の性格といった情報は，さまざまな場面で関心の対象となります．しかし，これらは直接知ることはできず，窺い知るしかありません．他者の内面的な性質や状態について間接的に知ろうとすることを社会的推論といいます．
## 社会的推論の２つの方略
これまでの研究によって，社会的推論には２つの異なる推論方法が存在することが提唱されています．
ひとつは「理論説」とよばれる方法です．これは社会的カテゴリ（性別や職業，年齢，人種など）に関する既有の知識にもとづく推論方法です．人は特定の社会的カテゴリについて一定のイメージを持っています．これをステレオタイプと言います．このステレオタイプを特定の個人や社会的な集団に当てはめて行う社会的推論の方略を「理論説」と言います．たとえば，「あの人は社長なのできっと活動的で優秀にちがいない」といった推論です．
もうひとつの方法は「シミュレーション説」とよばれるものです．これは相手の立場になってその気持ちを推し量るような推論方法です．この推論には２つのステップがあるとされます．まず初めに自分自身が相手の立場だったらどう感じるかというように，自分自身についての推論を行います．つぎに，この自分自身についての推論を基準（係留点）として，自身と相手の相違点などを考慮して推論の補正を行います．一見すると，相手の立場になって考える優れた方法のようにも思えますが，実際には，自分自身についての推論となっています．しかも，自分自身の内的状態を正確に理解できている補償はありませんし，その後の補正も不十分であることが指摘されています．
## 日常的概念による行動の説明
「理論説」では社会的カテゴリに関するステレオタイプを知識として社会的推論を行います．しかし，社会的推論に用いられる既有の知識は，それだけではありません．我々は対象者を特定の社会的カテゴリに分類することなく，その内的な性質を推論することがあります．例えば，人助けしているひとをみかけて「あの人はきっといい人に違いない」というような推論を行うことは日常的にも珍しくないと思います．実際，ある行動を観察した際に起こる推論の思考過程を調べた研究では，行為者の素性をほとんど知らさなかったにも関わらず，その行動が意図的か，行動の目的は何か，行為者がどのような考えで行動したか，などといったさまざまな推論が行われていることが示されています（Malle, 1999, 2000）．Malleは，ある行為を知覚した際に，その行為を解釈・説明するために起こるさまざまな推論を体系的に調べ，「日常的概念による行動の説明」という理論を提唱しています．

# このプロジェクトについて
## 本プロジェクトの目的
本プロジェクトの目的は「日常的概念による行動の説明」に関する知識体系を明らかにすることです．一般に，推論とは既知の事柄から何らかの規則にもとづいて未知の事柄を明らかにすることです．「日常的概念による行動の説明」に関する推論においても，われわれは行為や内的な性質（意図，目的，考え方，価値観など）に関して一定の知識にもっており，それらにもとづいてさまざまな社会的推論を行うと考えられます．コンピュータの場合，知識はあるルールにもとづいて整理されデータベースに保存されます．また，それらの知識を何らかの規則（アルゴリズム）によって結び付けることで推論が行われます．ヒトの社会的推論の場合も，既有の知識が構造化されたうえで記憶として保持され，なんらかのアルゴリズムにもとづいて推論が行われている可能性が考えられます．本プロジェクトでは，社会的推論に関する知識構造と推論のアルゴリズムを明らかにするための解析ツールを開発および公開することを目標にします．
## このプロジェクトの特徴：計量テキスト分析および自然言語処理技術の活用
Malleらは，「日常的概念による行動の説明」に関する推論過程を，記述された文章を解析することによって明らかにしてきました．本プロジェクトもそれに倣い，テキストデータの解析を行います．従来の社会的推論の研究では，実験条件を厳密に統制する心理実験の手法が広く用いられてきましたが，このような手法は精緻で厳密な結果を得られると期待できる一方で，複雑で多岐にわたる推論過程を網羅的に調べるにはやや不向きでした．それに比べ，テキストデータの解析は，より自然で日常的な推論の過程を網羅的に調べられると期待されています．近年，計量テキスト分析や自然言語処理技術といった自然言語を解析する手法は著しく発展しており，それらを社会的推論の研究に援用することで，「日常的概念による行動の説明」における知識構造および推論アルゴリズムに関する研究をさらに発展させられるのではないかと考えます．また，テキスト解析で得られた知見と，厳密な実験条件の統制を伴う研究へとつなげることで，より精緻で網羅的な社会的推論の研究の発展に繋がると期待されます．
## プロジェクトが行うこと
本プロジェクトでは，日本語文書への計量テキスト分析および自然言語処理技術の適用を目指します．社会的推論に関するテキスト分析の研究は英語圏でよく見られる一方で，日本語での研究は少ない傾向にあります．社会的推論には文化差が指摘されており，日本語文書に関する解析ツールの提供は，日本語文化圏における社会的推論を明らかにするうえで重要です．
このプロジェクトでは，新聞や雑誌，書籍，記述式のアンケートなどをテキストデータとして用いることを想定しています．これらのテキストデータから社会的推論に関する知識構造および推論アルゴリズムの様式を明らかにするため，以下のツール群の開発を行います．
### キーワード抽出ツール
行為を表す言語表現や，社会的推論の際のキーワードとなる語を抽出するツールを開発します．
直近の課題として，社会的推論にかかわる動詞や助動詞，形容詞などなどを抽出するツールを開発します．
### 抽出された語の評価ツール
テキストデータ解析によって得られた語をテキストベースおよび認知心理学的な実験で評価するためのツールを開発します．
- 抽出された語どうしの関係性をテキストベースで定量的に評価
- 抽出された語の心理実験的評価
- 抽出された語どうしの関係性を認知心理学的な実験で定量的に評価
### コーパス
コーパスの構築のためのツールの開発も進めます．
## 本プロジェクトの意義
以下に要点を示します．
### 日本語での研究は少ない
先述のように，テキスト解析をベースにした社会的推論の研究は英語圏で見られるものの，日本語の研究はあまりおおくありません．社会的推論には文化差が報告されており，日本語圏での社会的推論のありかたをテキストベースで調べることは，社会的推論の文化における差異や共通点を議論するうえで重要になると考えられます．
### 推論の双方向性
「日常的概念による行動の説明」では，観察した行動を説明する際におこる推論に焦点が当てられています．しかし，われわれは日常的に，既知の内的性質（推論によって得られた相手の性格や感情）から，相手の取りそうな行動を予測することもあります．つまり，行動と内的性質は双方向性に結び付けられていることが考えられます．本プロジェクトでは，両者の相互の結びつきに着目し，それらがどうのように結び付いているのかを明らかにします．
### 「人間の理解」を理解する
日常的な場面で「相手を理解する」と言った場合には，相手の考えや気持ちを理解することに加えて，相手に人間としての尊厳を認め尊重するニュアンスも含まれます．しかしながら，これまでの社会的推論に関する研究の結果は，相手を理解することと，人間として尊重することはときとしてうまく両立しないことがあることを示しています．おそらくその理由は，われわれが日常的に行う社会的推論には多くの制約があることだと思われます．たとえば，社会的推論は直感的な推論であり，科学的研究のように客観的な事実を積み上げて一つの結論を導くわけではありません．多くの場合，その場で見聞きした情報だけ（偏ったデータ）を頼りに，直感的に（非論理的に）相手の内面を推し量ります．このような推論方式には，多くの場面でおおむね妥当な結果を瞬間的に得ることができるというメリットがある一方で，弊害もあります．相手を特定のカテゴリに当てはめる推論（「理論説」）では，多面的かつ多様な個人の内面を，特定の社会集団に期待される一様な「らしさ」にあてはめることで，偏見や差別に繋がる恐れがあります．また，相手の立場になって考える場合（「シミュレーション説」）でも，相手と自分の立場の違いを十分に認識できないために，ひとりよがりで独善的な価値観を相手に押し付けてしまう恐れもあります．
しかしながら，他者をひとりの人間として尊重するためには，他者をよりよく知らなければならないことは，多くの人が経験的に感じていることではないかとおもいます．われわれが他者を（あるいは自己も）どのように理解しているのかを明らかにすることは，さまざまな制約を抱えながらも，どのようにすればお互いが尊重しあえる社会を築けるのかを考える糸口になるのではないかと期待しています．
## このプロジェクトが有益な理由
このプロジェクトの重要な点はオープンソースであることです．だれでも自由に使えることで，結果の再現性が高まります．また，だれでも自由にソースコードを見ることができ，解析プロセスの透明性が確保されます．さらに，だれでも自由に開発に参加できることで，共通の理解にもとづいたツールを開発することができます．

# このプロジェクトの使い始め方
## ユーザとして
Under construction.
## コントリビュータとして
[こちら](https://github.com/mokamotosan/extr_actions_jp/blob/master/contributing.md)をご覧ください．
どのようなご提案でも大歓迎です．

# このプロジェクトに関するヘルプをどこで得るか
まずは下記のメンテナンス者もしくはコントリビュータにご連絡ください．
今後はWikiなどを作成して拡充していく予定です．

# lisence
MITライセンスで管理しています．
くわしくは[こちら](https://github.com/mokamotosan/extr_actions_jp/blob/master/LICENSE)をご覧ください．

# contact
このプロジェクトのメンテナンス者とコントリビュータ
## メンテナンス者
@mokamotosan
## コントリビュータ
募集中
