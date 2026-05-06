# ikaiCMS

PHP 8.0+ で動作する軽量な企業向けコンテンツ管理システム（CMS）。フレームワーク不要、すぐに使えます。

A lightweight enterprise CMS built with PHP 8.0+. No framework dependency, ready to use out of the box.

公式サイト / Official: [https://www.ikaicms.com](https://www.ikaicms.com)

## 特徴 / Features

### AI コンテンツアシスタント / AI Content Assistant
- **5社のAIプロバイダー** — OpenAI, Claude (Anthropic), DeepSeek, Qwen, GLM
- **ワンクリック生成** — タイトル・要約・タグ・URLスラッグ・本文を一括生成
- **API Key暗号化** — AES-128-CBC で安全に保存

### コンテンツ管理 / Content Management
- **カテゴリ管理** — 無制限階層、ドラッグ＆ドロップ並べ替え、8種類のカテゴリタイプ
- **記事システム** — 多カテゴリ、ピン留め・おすすめ・人気マーク、TinyMCE エディタ
- **製品センター** — 多階層カテゴリ、ブランド、タグ、画像ギャラリー、仕様・価格
- **事例紹介** — 業界ソリューション＆成功事例
- **採用管理** — 求人情報、給与・学歴・経験フィルター
- **ダウンロード** — ファイルカテゴリ管理、ダウンロードカウント
- **固定ページ** — 会社概要、サービスフロー等

### テーマシステム / Theme System
- **テーマ切り替え** — 管理画面からワンクリック切替
- **3つの内蔵テーマ** — Default（スタンダード）、Minimal（ミニマル）、Business（ビジネス）
- **テンプレート階層** — layouts / blocks / partials の3層構造

### メディア管理 / Media Management
- **メディアライブラリ** — 画像・ファイル統合管理、自動サムネイル生成
- **アルバム管理** — 複数アルバム、画像ドラッグ並べ替え
- **バナー管理** — PC/モバイル対応、時限表示、ボタン設定

### お問い合わせ＆インタラクション / Inquiry & Interaction
- **お問い合わせシステム** — 製品詳細ページ内インラインフォーム、5段階ステータス管理
- **メール通知** — 4種類のメールテンプレート（登録・パスワードリセット・お問い合わせ通知）
- **フォームビルダー** — ビジュアルフォームデザイナー、`[form-slug]` ショートコード
- **会員システム** — フロント登録/ログイン

### トップページカスタマイズ / Homepage Customization
- 7つの設定可能ブロック：バナー、会社概要、統計、強み、カテゴリコンテンツ、お客様の声、CTA
- ブロック順序ドラッグ調整、個別ON/OFF
- スクロールアニメーション（fade / stagger / 数字カウント）

### 多言語対応 / Multilingual
- **言語パック** — 日本語（ja）、中国語（zh-CN）、英語（en）内蔵
- **管理画面言語切替** — ワンクリックで日本語⇔中国語切替
- **コンテンツ翻訳** — AI翻訳連携、辞書ベース翻訳

### システム管理 / System Management
- **ロール権限** — スーパー管理者/編集者/運営者、8種類の権限制御
- **操作ログ** — 全操作履歴記録
- **データベース管理** — バックアップ・インポート・テーブル情報
- **プラグインシステム** — WordPress風フック機構、ホットプラグ
- **SEO管理** — Sitemap / Robots.txt / OGタグ / サイト認証

---

## 動作環境 / Requirements

| 項目 | 要件 |
|------|------|
| PHP | >= 8.0 |
| データベース | MySQL 5.7+（utf8mb4）または SQLite 3 |
| Webサーバー | Apache（`mod_rewrite` 必須）または Nginx |
| PHP拡張（必須） | pdo, json, mbstring |
| PHP拡張（推奨） | gd, openssl, curl, fileinfo |

## インストール / Installation

```bash
# 1. ソースコードを配置
git clone https://github.com/ikaicms/ikaicms.git

# 2. ブラウザでアクセス
# http://yourdomain.com/install/

# 3. 画面の指示に従ってインストール完了
```

## テーマ / Themes

| テーマ | 説明 |
|--------|------|
| Default | スタンダードな企業サイトテーマ |
| Minimal | ミニマルデザインテーマ |
| Business | ダークビジネス風、建築・製造業向け |

## 内蔵プラグイン / Built-in Plugins

| プラグイン | 説明 |
|------------|------|
| back-to-top | トップに戻るボタン |
| menu-sort | 管理画面メニュー並べ替え |
| search-replace | データベース検索・置換 |

## ディレクトリ構成 / Directory Structure

```
├── admin/          # 管理画面
├── assets/         # CSS, JS, 画像
├── config/         # 設定ファイル
├── includes/       # コアライブラリ・モデル
├── install/        # インストーラー
├── lang/           # 言語パック
├── plugins/        # プラグイン
├── themes/         # テーマ
├── uploads/        # アップロードファイル
├── storage/        # キャッシュ・ログ
├── index.php       # フロントエントリ
└── .htaccess       # URL書き換えルール
```

## ライセンス / License

MIT License

## 開発 / Development

**イーカイ株式会社** (ikai Inc.)

- 公式サイト: [https://www.ikaicms.com](https://www.ikaicms.com)
- GitHub: [https://github.com/ikaicms/ikaicms](https://github.com/ikaicms/ikaicms)
