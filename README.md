# teamist

チームでの練習などを管理、提案するサービス

# 用語定義

| 名前 | 英語表記 | 意味 |
| --- | --- | --- |
| ユーザー | user | teamistの利用者 |
| チーム | team | 学校での部活動などの組織 |
| 管理者 | admin | チームを作成した人 |
| 先生 | teacher | 管理者に任命されたチームの指導者 |
| メンバー | member | チームに所属する特別な権限を持たないユーザー |
| 引退メンバー | retirement-member | 昔チームに所属していたユーザー |
| 練習 | practice | チームでの練習 |
| 練習メニュー | menu | 練習で行う内容 |
| ルーティーン | routine | 練習メニューの中で毎回同じタイミングでするもの |
| ポイント | point | 練習の量に応じて付与される得点 |
| 振り返り | review | 練習後の振り返り |
| 出欠 | attendance | 練習に出席したか欠席したかどうか |
| 評価 | assessment | 練習語の振り返りでつける5段階評価 |
| カテゴリー | category | 練習メニューの分類 |
| 提案 | recommend | 練習メニューのおすすめの提案 |
| 所要時間 | required-time | 練習メニューをするのに必要な時間 |
| 通知 | notification | アプリ側から届く連絡 |
| 連絡 | mail | 管理者や先生側から届く連絡 |
| チャット | chat | チーム内でのオンラインコミュニケーション |
| 当番 | duty | チームでの一週間の役割 |
| メモ | memo | ノート代わりになる練習を記録するもの |

# 概要

部活動などのチームでの練習で、練習メニューを自動提案し練習を管理、効率化するサービス。
自分の学校の部活動でよく何の練習をするかで時間が無くなったり、いつも同じような練習をしたりしてしまっているので様々な練習メニューをまんべんなくして、効率よく練習できたらいいなと思ったから作った。

# 機能、データモデル

## 練習

- 作成できる（公式練習は管理者、先生のみ　自主練習は全員）
    - uuidで練習のIDが登録される
    - 練習名、練習の概要、カテゴリーの選択、練習開始時刻と終了時刻を設定できる練習メニューを提案するかを選択できる
    - 更新日、作成者のユーザーID、練習の種類（公式練習か自主練習か）、参加メンバー（配列）、チームIDが登録される
    - 練習が作成されると通知が送られる
- 開始できる（作成者のみ）
    - 練習の開始時刻になるか作成者が開始させると全員に通知が送られる
    - 練習が開始されると最初のルーティーン、練習（提案するを選択した場合自動的に練習が提案される）、最後のルーティーンの順番で練習が行われる
    - それぞれの練習メニューごとでタイマーがセットされる
    - 参加すると参加メンバー（配列）に名前が追加される
- 終了できる（作成者のみ）
    - 練習の終了時刻になるか作成者が終了させると全員に振り返りが送られる
    - 公式練習の場合、終了するまでに参加しないと欠席となる
- 編集できる（作成者のみ）
    - 練習が開始する前なら練習名、練習の概要、カテゴリーの選択、練習開始時刻と終了時刻を編集できる
    - 練習メニューを提案するかも編集できる
    - 更新日が更新される
- 削除できる（作成者のみ）
    - 練習が開始する前なら練習を削除することができる
- 練習メニューが提案される（アプリ側）
  - 練習時間（練習終了時刻から練習開始時刻を引いた時間）でできる練習の中から最近していない練習に優先順位をつけ練習を提案する
  - 提案された練習をスキップしたり、自分で選ぶこともできる
- ルーティーンが提案される（アプリ側）
  - 練習の最初は初めのルーティーンが、練習の最後は終わりのルーティーンが行われる
  - ルーティーンの時間は必ず確保される
- 出欠が取れる（アプリ側）
  - 練習の終了時刻までに参加したメンバーは出席、練習の終了時刻になっても参加しなかったメンバーは欠席になる
- 公式練習後に振り返りができる（練習参加者）
  - 練習後は行った練習メニューや時間、ポイントの確認や練習の自己評価を５段階でつけることができる
  - 管理者や先生は全員の振り返りを確認できる
- 練習別のグラフや統計が見れる（全員）
  - 一日の練習時間や獲得ポイントをグラフなどで確認できる
  - 管理者や先生は全員の統計を確認できる

## カテゴリー

- 作成できる（管理者、先生のみ）
  - 練習メニューやルーティーンの種類（基礎練習、屋内練習など）をまとめるためのもの
  - 連番でカテゴリーのIDが登録され、カテゴリー名を設定できる
  - 更新日、チームIDが登録される
- 編集できる（管理者、先生のみ）
  - カテゴリー名を編集できる
  - 更新日が更新される
- 削除できる（管理者、先生のみ）

## 練習メニュー

- 作成できる（管理者、先生のみ）
  - 連番で練習メニューのIDが登録される
  - 練習メニュー名、練習メニューの概要、カテゴリーの選択、所要時間を設定できる
  - 更新日、チームID、今日の日付が登録される
- 編集できる（管理者、先生のみ）
  - 練習メニュー名、練習メニューの概要、カテゴリーの選択、所要時間を編集できる
  - 更新日が更新される
- 削除できる（管理者、先生のみ）
- 練習メニュー別のグラフや統計が見れる
  - 頻度（回数）、練習した時間、ポイントで見れる

## ルーティーン

- 作成できる（カテゴリー別でさらに練習の最初、最後で保存できる　管理者、先生のみ）
  - 連番でルーティーンのIDが登録される
  - ルーティーン名、ルーティーンの概要、カテゴリーの選択、所要時間、ルーティーンの順番、最初か最後かを設定できる
  - 更新日、チームID、ルーティーンの順番、最初か最後が登録される
- 編集できる（管理者、先生のみ）
  - ルーティーン名、ルーティーンの概要、カテゴリーの選択、所要時間、ルーティーンの順番、最初か最後かを編集できる
  - 更新日が更新される
- 削除できる（管理者、先生のみ）

## ランキング

- 練習メニューのポイント別、年間ポイント別でランキングが見れる

## メモ

- 作成できる（文字と写真で書くことができる）
  - uuidでメモのIDが登録される
  - メモ名、メモの内容、添付画像が設定できる
  - 更新日、チームID、作成者のユーザーIDが登録される
- 編集できる
  - メモ名、メモの内容、添付画像が編集できる
  - 更新日が更新される
- 削除できる
- メモにコメントできる（管理者、先生のみ）
  - uuidでコメントのIDが登録され、文字で入力できる
  - メモID、投稿者のユーザーIDが登録される
  - コメントされると通知が送られる
- コメントを削除できる（コメントの投稿者のみ）

## 当番

- 作成できる（当番に曜日ごとにメンバーを振り分けできる 管理者、先生のみ）
  - 連番で当番のIDが登録される
  - 当番名、当番の概要、当番の内容（連想配列）が設定できる
  - 更新日、チームのIDが登録される
- 編集できる（管理者、先生のみ）
  - 当番名、当番の概要、当番の内容（連想配列）が編集できる
  - 更新日が更新される
- 削除できる（管理者、先生のみ）
- その日当番の人に通知が送られる

## 連絡

- 送信できる（文字と写真で書くことができる　管理者、先生のみ）
  - uuidで連絡のIDが登録される
  - 連絡名、連絡の内容、添付画像が設定できる
  - 更新日、チームのID、作成者のユーザーIDが登録される
- 編集できる（文字と写真で書くことができる　管理者、先生のみ）
  - 連絡名、連絡の内容、添付画像が編集できる
  - 更新日が更新される
- 削除できる（管理者、先生のみ）
- 連絡が送信されるか編集されると通知が送られる

## チャット

- 送信できる（リアルタイムで文字のチャットを送信できる）
  - 連番でチャットのIDが登録される
  - チャットの内容を設定できる
  - 送信日、チームのID、送信者のユーザーIDが登録される
- 削除できる
- チャットは送信されると通知が送られる

## チーム

- 作成できる（チーム名、チームの概要）
  - uuidでチームのIDが登録される
  - チーム名、チームの概要を設定できる
  - 作成日、更新日、作成者のユーザーID、先生（配列）、引退（配列）が登録される
- 編集できる（チーム名、チームの概要　管理者のみ）
  - チーム名、チームの概要を編集できる
  - 更新日が更新される
- 削除できる（管理者のみ）
- 先生を任命できる（アカウントから先生権限を与える）
  - 先生（配列）に該当のアカウントのユーザーIDが追加される
  - 更新日が更新される
- 先生を任命を解除できる（アカウントから先生権限を取り消す）
  - 先生（配列）から該当のアカウントのユーザーIDが削除される
  - 更新日が更新される
- メンバーを引退メンバーに変更できる
  - 引退（配列）に該当のアカウントのユーザーIDが追加される
  - 更新日が更新される

## アカウント

- 作成できる
  - uuidでユーザーIDが登録される
  - メールアドレス認証、Google認証、LINE認証、Apple認証で作成できる
  - ユーザー名、アイコン、自己紹介、パスワードを設定できる
  - 作成日、更新日が登録される
- 編集できる（ユーザー名、アイコン、自己紹介、パスワード）
  - ユーザー名、アイコン、自己紹介、パスワードを編集できる
  - 更新日が更新される
- 削除できる
- ログインできる（メールアドレス認証、Google認証、LINE認証、Apple認証）
- ログアウトできる
- チームを変更できる（複数のチームに所属している場合）

## データベース

### チーム（team）

ユーザーに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| チームのID | teamID | uuid |
| チームの名前 | teamName | 文字 |
| チームの概要 | teamAbout | 文字 |
| 作成日 | createdDate | 日付 |
| 更新日 | editedDate | 日付 |
| 作成者 | createdBy | 英数字（userID） |
| メンバー | member |
| メンバーのユーザーID | userID | 英数字 |
| メンバーの種類 | memberKinds | 文字 |

### ユーザー（user）

ユーザーに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| ユーザーのID | userID | uuid |
| ユーザーの名前 | userName | 文字 |
| ユーザーの概要 | userAbout | 文字 |
| パスワード | password | 英数字 |
| 作成日 | createdDate | 日付 |
| 更新日 | editedDate | 日付 |
| アイコン画像 | icon | 画像 |

### 練習（practice）

練習に関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| 練習のID | practiceID | uuid |
| 練習名 | practiceName | 文字 |
| 練習の概要 | practiceAbout | 文字 |
| 更新日 | editedDate | 日付 |
| 作成者 | createdBy | 英数字（userID） |
| チームID | teamID | 英数字（teamID） |
| カテゴリー | category | 英数字（categoryID） |
| 開始時刻 | startTime | 時刻 |
| 終了時刻 | endTime | 時刻 |
| 提案の有無 | recommend | 文字 |
| 練習の種類 | practiceKinds | 文字 |
| メンバー（出欠・振り返り） | member |
| メンバーの出欠 | attendance | 文字 |
| 振り返り | review | 文字 |

### 練習メニュー（menu）

練習メニューに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| 練習メニューのID | menuID | 連番 |
| 練習メニュー名 | menuName | 文字 |
| 練習メニューの概要 | menuAbout | 文字 |
| 更新日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |
| カテゴリー | category | 英数字（categoryID） |
| 所要時間 | requiredTime | 時間 |
| 最終練習日 | lastDate | 日付 |

### カテゴリー（category）

カテゴリーに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| カテゴリーのID | categoryID | 連番 |
| カテゴリー名 | categoryName | 文字 |
| 更新日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |

### ルーティーン（routine）

ルーティーンに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| ルーティーンのID | routineID | 連番 |
| ルーティーン名 | routineName | 文字 |
| ルーティーンの概要 | routineAbout | 文字 |
| カテゴリー | category | 英数字（categoryID） |
| 所要時間 | requiredTime | 時間 |
| 更新日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |
| ルーティーンの順番 | order | 数字 |
| 最初か最後か | FirstOrLast | 文字 |

### メモ（memo）

メモに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| メモのID | memoID | uuid |
| メモ名 | memoName | 文字 |
| メモの内容 | memoContent | 文字 |
| 添付画像 | memoImage |
| 添付画像のデータ | base64 | base64 |
| 更新日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |
| 作成者 | createdBy | 英数字（userID） |

### 当番（duty）

当番に関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| 当番のID | dutyID | 連番 |
| 当番名 | dutyName | 文字 |
| 当番の概要 | dutyAbout | 文字 |
| 当番の内容 | dutyContent |
| 月 | monday |
| 火 | tuesday |
| 水 | wednesday |
| 木 | thursday |
| 金 | friday |ID
| 土 | saturday |
| 日 | sunday |
| 当番のユーザーID | userID | 英数字 |
| 更新日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |

### 連絡（mail）

連絡に関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| 連絡のID | mailID | uuid |
| 連絡名 | mailName | 文字 |
| 連絡の内容 | mailContent | 文字 |
| 添付画像 | mailImage |
| 添付画像のデータ | base64 | base64 |
| 更新日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |
| 作成者 | createdBy | 英数字（userID） |

### チャット（chat）

チャットに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| チャットのID | mailID | uuid |
| チャットの内容 | mailContent | 文字 |
| 送信日 | editedDate | 日付 |
| チームID | teamID | 英数字（teamID） |
| 送信者 | createdBy | 英数字（userID） |

### ポイント（point）

ポイントに関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| ポイントのID | pointID | 連番 |
| ポイント | point | 数字 |
| 練習ID | practiceID | 英数字（practiceID） |
| 練習内容 | practiceContent | 文字（JSON、practiceID） |
| チームID | teamID | 英数字（teamID） |
| ユーザーID | userID | 英数字（userID） |

### 通知（notification）

通知に関するデータベース

| カラム名 | 英語表記 | 形式 |
|---|---|---|
| 通知のID | notificationID | 連番 |
| 通知名 | notificationName | 数字 |
| 通知の内容 | notificationContent | 英数字（practiceID） |
| 送信日 | editedDate | 文字（JSON、practiceID） |
| チームID | teamID | 英数字（teamID） |
| ユーザーID | userID | 英数字（userID） |
| 既読状況 | read | 文字 |

## 依存関係


- user
  - userID
    - userName
    - userAbout
    - password
    - createdDate
    - editedDate
    - icon
    - memo（サブコレクション）
      - memoID
        - memoName
        - memoContent
        - memoImage（サブコレクション）
          - base64
        - editedDate
        - teamID
        - createdBy

- team
  - teamID
    - teamName
    - teamAbout
    - createdDate
    - editedDate
    - createdBy
    - member（サブコレクション）
      - userID
        - userKind
    - practice
      - practiceID
        - practiceName
        - practiceAbout
        - editedDate
        - createdBy
        - teamID
        - category
        - startTime
        - endTime
        - recommend
        - practiceKinds
        - member（サブコレクション）
          - userID
            - attendance
            - review
    - menu
      - menuID
        - menuName
        - menuAbout
        - editedDate
        - teamID
        - category
        - requiredTime
        - lastDate
    - category
      - categoryID
        - categoryName
        - editedDate
        - teamID
    - routine
      - routineID
        - routineName
        - routineAbout
        - category
        - requiredTime
        - editedDate
        - teamID
        - FirstOrLast
    - duty
      - dutyID
        - dutyName
        - dutyAbout
        - dutyContent
          - monday（サブコレクション）
            - userID
          - tuesday（サブコレクション）
            - userID
          - wednesday（サブコレクション）
            - userID
          - thursday（サブコレクション）
            - userID
          - friday（サブコレクション）
            - userID
          - saturday（サブコレクション）
            - userID
          - sunday（サブコレクション）
            - userID
        - editedDate
        - teamID
    - mail
      - mailID
        - mailName
        - mailContent
        - mailImage（サブコレクション）
          - base64
        - editedDate
        - teamID
        - createdBy

## 開発計画

| 目標日 | 内容 |
| --- | --- |
| ~ 12/31 | 要件定義 |
| ~ 1/9 | Firebase勉強 |
| ~ 1/31 | データベース、認証、通知などの勉強 |
| ~ 2/15 | リリースについての勉強 |
| ~ 3/4 | テストアプリ作成 |
| ~ 3/25 | teamistの基礎機能作成、未踏提案書記入 |
| ~ 6/30 | teamistの追加機能作成 |
| ~ 7/31 | teamistのデザイン作成 |
| ~ 8/20 | 公開準備、公開 |
| ~ 10/15 | teamistの追加機能（2）作成 |

## アーキテクチャ

![アーキテクチャ](teamist-architecture.png)

![提案機能の仕組み](teamist-menu.png)