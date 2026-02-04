# VTuberKitPoseEditor (Game Tool App)

このプロジェクトは、VRMモデルを読み込み、姿勢やカメラ、表情などを調整できるツールアプリです。
ゲーム制作時のキャラクター調整やポーズ確認のためのユーティリティとして使うことを想定しています。

## Features
- VRMモデルの読み込みと表示
- 姿勢（ボーン）調整
- カメラ位置・画角の調整
- 表情（BlendShape）の調整

## Requirements
- macOS
- Xcode
- iOS実機またはシミュレータ

## Setup
1. `VTuberKitPoseEditor.xcodeproj` をXcodeで開きます。
2. 依存ライブラリ（Swift Package）が解決されるのを待ちます。
3. 実機またはシミュレータでビルド・実行します。

## Usage
- アプリ起動時に `AliciaSolid.vrm` を読み込みます。
- 画面上のボタンで姿勢・カメラ・表情を調整できます。
- Save: 現在の姿勢パラメータを保存します。`Replay`でこの姿勢を再現できます。
- Reset: 姿勢・移動・カメラ・表情を起動時の状態に戻し、保存データも初期化します。
- Replay: 保存した姿勢パラメータを読み込み、現在の状態から保存時の姿勢へ移行します。

## Assets / Credits
- `AliciaSolid.vrm` は以下の配布元・利用条件に従います。
- 配布元: https://hub.vroid.com/characters/515144657245174640/models/6438391937465666012
- 利用条件: アバター利用OK / 暴力表現OK / 性的表現OK / 法人利用OK / 個人の商用利用は非営利のみ / 再配布OK / 改変OK / クレジット表記不要

## Notes
- 設定値はUserDefaultsに保存されます。

## License
- コードはMITライセンスに従います。
- モデルや素材は各ライセンスに従います。
