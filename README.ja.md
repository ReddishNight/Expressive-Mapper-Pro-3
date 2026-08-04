# Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/version-3.6.1-brightgreen)
![Compatibility](https://img.shields.io/badge/SynthV%20Studio%202-PRO%20v2.2.1%2B-purple)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-%E9%96%8B%E7%99%BA%E8%80%85%E3%82%92%E9%94%AF%E6%8F%B4-ff5e5b?logo=ko-fi&logoColor=white)](https://ko-fi.com/nyorux555)

> **Synthesizer V Studio 2 PRO 専用：高度ボーカル表現力、テキスト詩節旋律生成、Hermite/TCBスプラインオートメーション、純正律デュオ/コーラスハーモニー、厳格フックス流対位法、最小エネルギーVoice Leadingコード進行自動化エンジン。**

---

🌐 **言語 / Languages / Idiomas**: **[English](README.md)** | **[Español](README.es.md)** | **[日本語](README.ja.md)**

---

## ☕ 開発のサポート・寄付 (Support & Donations)

**Expressive Mapper Pro 3** があなたの Synthesizer V での楽曲制作やボーカル調声に役立った場合、開発者へのサポート（任意）をご検討いただけますと幸いです！

<p align="center">
  <a href="https://ko-fi.com/nyorux555" target="_blank">
    <img src="https://storage.ko-fi.com/cdn/kofi2.png?v=3" alt="Ko-fiでサポートする" height="48">
  </a>
</p>

> 💖 **[Ko-fi で Nyoru.X を支援する](https://ko-fi.com/nyorux555)**  
> 開発への温かいサポートが、今後のアップデートや新機能追加の励みになります！

---

## 🚀 概要

**Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)** は、**Nyoru.X** によって開発された **Synthesizer V Studio 2 PRO (v2.2.1+ / Build 67072+)** 向けの最高峰モジュール型Luaスクリプトです。

データ指向設計 (Data-Oriented Design) を採用し、**ランタイムでのGCメモリ割り当てゼロ (GC Alloc = 0 Bytes)** を実現。歌詞テキストからの自動旋律生成から、ピッチ・テンション・ブレス・ジェンダー・Voicing・Vocal Modeの高度なスプライン補間制御まで一括で処理します。

---

## ✨ 主な機能と動作モード

| 1. コンパイル済みスクリプトファイル **[`Expressive_Mapper_Pro_3.lua`](Expressive_Mapper_Pro_3.lua)** をダウンロード（または [Releases](../../releases) から取得）。
2. `Expressive_Mapper_Pro_3.lua` を Synthesizer V Studio の scripts フォルダに保存：
   - **Windows:** `C:\Users\<ユーザー名>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. **Synthesizer V Studio** を起動し、メニューの **スクリプト > スクリプトの再スキャン** を実行（またはアプリを再起動）。
4. ノートまたはトラックを選択し、**スクリプト** メニューから `Mapeador Expresivo Pro 3` を実行します。

---

## 📘 公式マニュアル (PDF)

詳細なPDFドキュメントが3言語で用意されています：

- 🇯🇵 **[公式マニュアル (日本語 PDF)](Expressive_Mapper_Pro_3_Manual_JA.pdf)**
- 🇺🇸 **[Official Manual in English (PDF)](Expressive_Mapper_Pro_3_Manual_EN.pdf)**
- 🌎 **[Manual Oficial en Español (PDF)](Expressive_Mapper_Pro_3_Manual_ES.pdf)**

---

## 🛠️ ソースコード構造とビルド

```text
Expressive-Mapper-Pro-3/
├── src/                                     # モジュール化Luaソースコード
│   ├── 00_Header_Metadata.lua               # メタデータ＆SynthVクライアント署名
│   ├── 01_I18n_Localization.lua             # 多言語辞書 (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # ボーカルプリセット＆表現カーブデータ
│   ├── 03_Tokenizer_MelodyGen.lua           # テキストトークナイザー＆韻律旋律生成
│   ├── 04_Hermite_AutomationEngine.lua      # Hermite / TCB スプラインエンジン
│   ├── 05_UI_MainController.lua             # ダイナミックUIダイアログ＆統括コントローラー
│   ├── 06_HarmonyEngine.lua                 # 純正律ハーモニーエンジン
│   ├── 07_CounterpointGen.lua               # 対位法 (Fuxian 5-Species) 生成器
│   └── 08_ChordProgressionEngine.lua        # 最小エネルギーVoice Leadingコード進行
├── docs/                                    # PDFビルドツール＆HTMLテンプレート
├── Expressive_Mapper_Pro_3_Manual_ES.pdf   # 公式マニュアル (スペイン語)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf   # 公式マニュアル (英語)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf   # 公式マニュアル (日本語)
├── Expressive_Mapper_Pro_3.lua              # 🚀 コンパイル済み単一Luaスクリプト
├── build.bat                                # Windows用一括コンパイルバッチ
├── README.md                                # 英語ドキュメント (メイン)
├── README.es.md                             # スペイン語ドキュメント
└── README.ja.md                             # ドキュメント (日本語)
```

### ソースからのコンパイル
`src/` 内のモジュールを統合して単一の `Expressive_Mapper_Pro_3.lua` をビルドするには、コマンドプロンプトで以下を実行します：なPDFドキュメントが3言語で用意されています：

- 🇯🇵 **[公式マニュアル (日本語 PDF)](Expressive_Mapper_Pro_3_Manual_JA.pdf)**
- 🇺🇸 **[Official Manual in English (PDF)](Expressive_Mapper_Pro_3_Manual_EN.pdf)**
- 🌎 **[Manual Oficial en Español (PDF)](Expressive_Mapper_Pro_3_Manual_ES.pdf)**

---

## 🛠️ ソースコード構造とビルド

```text
Expressive-Mapper-Pro-3/
├── src/                                     # モジュール化Luaソースコード
│   ├── 00_Header_Metadata.lua               # メタデータ＆SynthVクライアント署名
│   ├── 01_I18n_Localization.lua             # 多言語辞書 (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # ボーカルプリセット＆表現カーブデータ
│   ├── 03_Tokenizer_MelodyGen.lua           # テキストトークナイザー＆韻律旋律生成
│   ├── 04_Hermite_AutomationEngine.lua      # Hermite / TCB スプラインエンジン
│   ├── 05_UI_MainController.lua             # ダイナミックUIダイアログ＆統括コントローラー
│   ├── 06_HarmonyEngine.lua                 # 純正律ハーモニーエンジン
│   ├── 07_CounterpointGen.lua               # 対位法 (Fuxian 5-Species) 生成器
│   └── 08_ChordProgressionEngine.lua        # 最小エネルギーVoice Leadingコード進行
├── docs/                                    # PDFビルドツール＆HTMLテンプレート
├── Expressive_Mapper_Pro_3_Manual_ES.pdf   # 公式マニュアル (スペイン語)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf   # 公式マニュアル (英語)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf   # 公式マニュアル (日本語)
├── Expressive_Mapper_Pro_3.lua                    # 🚀 コンパイル済み単一Luaスクリプト
├── build.bat                                # Windows用一括コンパイルバッチ
├── README.md                                # 英語ドキュメント (メイン)
├── README.es.md                             # スペイン語ドキュメント
└── README.ja.md                             # ドキュメント (日本語)
```

### ソースからのコンパイル
`src/` 内のモジュールを統合して単一の `Expressive_Mapper_Pro_3.lua` をビルドするには、コマンドプロンプトで以下を実行します：

```powershell
build.bat
```

---

## 📄 クレジットとライセンス

- **著者:** Nyoru.X
- **寄付 / Ko-fi:** [Ko-fi.com/nyorux555](https://ko-fi.com/nyorux555)
- **ライセンス:** [MIT ライセンス](LICENSE)
- **動作環境:** Lua 5.4 / LuaJIT (Synthesizer V Studio 2 PRO API)
- **最小対応エディターバージョン:** Build 67072+ (v2.2.1+)
