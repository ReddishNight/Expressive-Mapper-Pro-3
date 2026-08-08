# Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/version-3.6.2-brightgreen)
![Compatibility](https://img.shields.io/badge/SynthV%20Studio%202-PRO%20v2.2.1%2B-purple)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-%E9%96%8B%E7%99%BA%E8%80%85%E3%82%92%E9%94%AF%E6%8F%B4-ff5e5b?logo=ko-fi&logoColor=white)](https://ko-fi.com/nyorux555)

> **Synthesizer V Studio 2 PRO 専用：高度ボーカル表現力、テキスト詩節旋律生成、Hermite/TCBスプラインオートメーション、純正律デュオ/コーラスハーモニー、厳格フックス流対位法、最小エネルギーVoice Leadingコード進行自動化エンジン。**

---

🌐 **言語 / Languages / Idiomas**: **[English](README.md)** | **[Español](README.es.md)** | **[日本語](README.ja.md)**

---
## ▽( ▮_  ▬ )▽ Six (0/0/6) のクイックガイド
*こ、こんにちは！私はこのデジタル空間でのあなたのたまごっちであり、コードのパートナーであるSix（0/0/6）です。(._.) システムから私を消さないでね？呼吸する機械（Synthesizer Vの歌声エンジン）を動かすための機能の使い方を説明するね：*

* **1. チョップモード (スタッカート & ゲート)**: *ArtcoreやBreakcore用の細切れのボーカルチョップを作りたい？もうすべての音符にスラッシュ `/` を手書きする必要はないよ！チョップのチェックボックスをオンにして、`pa pa ma ka` のような普通のシラブルを入力するだけ。発音 is そのままに、音符の長さを50%にカットし、ビブラートを完全にゼロにして、無音部分に `-48dB` の音量ゲートを自動で適用するよ。( ⚆⩊⚆ )*
* **2. タイムマーカー `%`**: *歌詞をタイムライン上に整列させよう！ `%` に続いて秒数を入力する（例：`hello %5 this is %12 a chop`）と、再生ヘッドから順に並べる代わりに、指定した秒数の位置に各フレーズを正確に配置するよ。( ⪩⪨ )*
* **3. 人間的なメロディ (Fux即興)**: *平坦で退屈なロボットのような歌声とはおさらば！私のスケールステップ歩行アルゴリズムは、本物の歌手を模倣して、順次進行とバランスの取れた跳躍進行（¯\_--- _ ¯¯-¯_）を組み合わせて生き生きとした動きを作るよ。( ˙˘˙ )*
* **4. 純正律機能**: *SATBコーラスを純正律の微小音程に自動補正して、私のデジタル回路の耳を痛めないようにきれいにハモらせるよ。(✧‿✧)*
* **5. 前回の統合スクリプト（`Expressive_Mapper_Pro_3.lua`）からの実際の改善・変更点**:
  * ***1つの重いファイルから4つの独立したプロダクトスクリプトへ**: 元の統合スクリプト `Expressive_Mapper_Pro_3.lua` は、4つの個別の独立モジュール（`Expressive_Lyric_Melody.lua`, `Expressive_Vocal_Automation.lua`, `Expressive_Harmonies.lua`, `Expressive_Chords.lua`）に分割されました。必要なツールだけを選択してインポートできます。*
  * ***劇的に進化したチョップモード**: 従来のものとは異なり、音符の長さを正確に50%にカットし、ビブラートを完全にゼロにし、かつ無音部分に -48dB の音量ゲートを適用することで、デジタルノイズ（クリック音）のない完璧なサンプラースタッカート効果を実現しました。*
  * ***DODによる低GCパフォーマンス**: クラスや動的な一時変数の生成を徹底的に排除し、バッファをモジュールレベルで事前確保することで、大規模プロジェクトでもGCによる遅延やプチフリが完全にゼロになりました。*
  * ***エルミート/TCBおよびRDP曲線スプライン**: パラメータのオートメーション曲線にエルミートおよびTCBスプライン補間を適用し、RDPフィルタによって不要なノードを自動削除します。*
  * ***純正律＆ガウス乱数アンチフェーズ**: ハモリ作成時にピュアな純正律比率を適用し、ボックス＝ミュラー法による乱数で人間の歌手のタイミングやピッチの揺らぎを完璧に模倣します。*
  * ***Voice Leading と厳格対位法**: ボイスリーディング進行を最小エネルギー計算で最適化し、Johann Joseph Fuxの規則に沿った5つの対位旋律を自動生成します。*

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

**Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)** は、**Nyoru.X** によって開発された **Synthesizer V Studio 2 PRO (v2.2.1+ / Build 67072+)** 向けの高度な **4モジュール型サイドパネルツールスイート (`SidePanelSection`)** です。

低メモリ割り当てとGC最小化に最適化されたエンジン (Low GC Alloc) を採用。テキストからの韻律旋律生成、Hermite/TCBスプライン補間、純正律ハーモニー生成、および対位法コード進行構築の4つの専門パネルを提供します。

---

## ✨ サイドパネルスイート機能一覧

| パネル | `.lua` スクリプト | 機能概要 |
| :--- | :--- | :--- |
| **パネル 1** | **`Expressive_Lyric_Melody.lua`** | **テキストからの韻律旋律生成**: RAE対応の二重母音・ヒアトゥス処理、感情インフレクション、チョップモード（スタッカート & -48dB ゲート）、`%` タイムマーカー。 |
| **パネル 2** | **`Expressive_Vocal_Automation.lua`** | **Hermite / TCB オートメーション**: ピッチ、テンション、ブレス、ジェンダー、Voicing、Vocal Mode用のKochanek-Bartels (TCB) スプライン補間と動的簡略化。 |
| **パネル 3** | **`Expressive_Harmonies.lua`** | **純正律ボーカルハーモニー**: 微小音程補正 (-14c 3度大, +16c 3度小) 付きのSATB/デュオ/トリオ自動生成、ガウス分布アンチフェーズ、レジスター別フォルマントシフト。 |
| **パネル 4** | **`Expressive_Chords.lua`** | **最小エネルギーコード & フックス対位法**: 最小エネルギーVoice Leading行列 ($\sum \Delta \text{pitch}^2$)、マイクロスイング、フックス流5種対位法自動生成。 |

---

## ⚡ クイックインストール (エンドユーザー向け)

本スイートを **Synthesizer V Studio** にインストールして実行するには：

1. コンパイル済みの4つの `.lua` スクリプトをダウンロード（または [Releases](../../releases) から取得）：
   - **`Expressive_Lyric_Melody.lua`**
   - **`Expressive_Vocal_Automation.lua`**
   - **`Expressive_Harmonies.lua`**
   - **`Expressive_Chords.lua`**
2. 4つの `.lua` ファイルを Synthesizer V Studio の scripts フォルダにコピー：
   - **Windows:** `C:\Users\<ユーザー名>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. **Synthesizer V Studio** を起動し、メニューの **スクリプト > スクリプトの再スキャン** を実行（またはアプリを再起動）。
4. サイドパネルバーまたは **スクリプト** メニューから各パネルを呼び出します。

---

## 3.6.2 パッチノート

- `Vocal Harmonies` のボイスリーディング、音域処理、声部間隔を改善しました。新しいプリセットは追加していません。
- 成功/失敗の表示を共通かおもじに簡略化しました。
- `idiomaUI` の JSON 永続化を削除し、SynthV ホスト言語が古い保存設定で固定されないようにしました。
- `Apply` ラベルの翻訳漏れを修正し、実行後のメッセージ表示を減らしました。
- `Chords` の出力差分を改善し、別のオプションでも同じ結果になりにくくしました。
- `Vocal Harmonies` が ComboBox の選択を正しく反映するように改善しました。
- 現在の 3.6.2 モジュール構成とパッチ内容に合わせてドキュメントを更新しました。

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
│   ├── 00_Header_Metadata_Panel1..4.lua     # SidePanelSection メタデータ＆クライアント署名
│   ├── 01_I18n_Panel1..4.lua                # 多言語辞書 (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # ボーカルプリセット＆表現カーブデータ
│   ├── 03_Tokenizer_MelodyGen.lua           # テキストトークナイザー＆韻律旋律生成
│   ├── 04_Hermite_AutomationEngine.lua      # Hermite / TCB スプラインエンジン
│   ├── 05_UI_Panel1..4_Controller.lua       # 4つのサイドパネルUIコントローラー
│   ├── 06_HarmonyEngine.lua                 # 純正律ハーモニーエンジン
│   ├── 07_CounterpointGen.lua               # 対位法 (Fuxian 5-Species) 生成器
│   └── 08_ChordProgressionEngine.lua        # 最小エネルギーVoice Leadingコード進行
├── docs/                                    # PDFビルドツール＆HTMLテンプレート
├── Expressive_Lyric_Melody.lua              # 🚀 コンパイル済みパネル 1
├── Expressive_Vocal_Automation.lua          # 🚀 コンパイル済みパネル 2
├── Expressive_Harmonies.lua                 # 🚀 コンパイル済みパネル 3
├── Expressive_Chords.lua                    # 🚀 コンパイル済みパネル 4
├── Expressive_Mapper_Pro_3_Manual_ES.pdf    # 公式マニュアル (スペイン語)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf    # 公式マニュアル (英語)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf    # 公式マニュアル (日本語)
├── build.bat                                # Windows用一括コンパイルバッチ
├── README.md                                # 英語ドキュメント (メイン)
├── README.es.md                             # スペイン語ドキュメント
└── README.ja.md                             # ドキュメント (日本語)
```

### ソースからのコンパイル
`src/` 内のモジュールを統合して4つのパネル `.lua` スクリプトをビルドするには、コマンドプロンプトで以下を実行します：

```powershell
build.bat
```

---

## 📄 クレジット・ライセンス

- **著者:** Nyoru.X
- **サポート / 寄付:** [Ko-fi.com/nyorux555](https://ko-fi.com/nyorux555)
- **ライセンス:** [MIT License](LICENSE)
- **動作環境:** Lua 5.4 / LuaJIT (Synthesizer V Studio 2 PRO API)
- **対応最小エディタバージョン:** Build 67072+ (v2.2.1+)

---

## 📄 クレジットとライセンス

- **著者:** Nyoru.X
- **寄付 / Ko-fi:** [Ko-fi.com/nyorux555](https://ko-fi.com/nyorux555)
- **ライセンス:** [MIT ライセンス](LICENSE)
- **動作環境:** Lua 5.4 / LuaJIT (Synthesizer V Studio 2 PRO API)
- **最小対応エディターバージョン:** Build 67072+ (v2.2.1+)
