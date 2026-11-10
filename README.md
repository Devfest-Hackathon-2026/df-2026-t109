# Memory Map — 自分だけのGoogle Mapを作ろう

**DevFest Hackathon 2026（Team 109：`df-2026-t109`）提出リポジトリ**

訪問場所・写真・レビュー・思い出を地図上に保存し、視覚的に振り返ることができるモバイルアプリケーションです。写真フォルダや過去の記録を1つずつ検索しなくても、地図を見れば訪れた場所や当時の思い出を振り返ることが出来ます。

---

## 主な機能（MVP機能）

1. **Google Maps による訪問地点・移動ルートの表示**
   - 訪問した場所（ピン）や旅行中の移動軌跡を地図上に表示し、紐づく思い出を確認できます。
2. **写真・思い出・レビューの保存**
   - 場所や旅行ごとに写真・タイトル・レビュー・訪問日時を記録・再閲覧できます。
3. **都道府県の形に沿った写真プレビュー**
   - 訪問・記録した地域の境界ポリゴンに沿って写真を切り抜いて地図上にオーバーレイ表示し、訪れた地域が増える達成感を視覚的に楽しめます。
4. **ユーザー認証（Google ログイン / ゲストモード）**
   - Firebase Authentication（Google Sign-In）によるアカウント管理と、すぐに試せるゲストモードに対応しています。
5. **グループ機能**
   - 複数人でチーム（グループ）を作成・招待し、グループ単位で思い出や訪問場所を共有できます。
6. **シェア機能**
   - 思い出や訪問記録の共有リンク発行・公開範囲の管理が可能です。

---

## 実行方法①：Android 端末へ APK を直接インストールする場合（GitHub Releases）

Android 実機またはエミュレータをご利用の場合は、[GitHub Releases](https://github.com/Devfest-Hackathon-2026/df-2026-t109/releases) に添付されている実行可能ファイル（`.apk`）をダウンロードして直接インストール・実行できます。

1. [GitHub Releases ページ](https://github.com/Devfest-Hackathon-2026/df-2026-t109/releases) から最新リリースの APK ファイル（`app-release.apk`）をダウンロードします。
2. Android 端末（または Android Emulator）に APK を転送・インストールして起動します。
   - ADB 経由でインストールする場合：
     ```bash
     adb install app-release.apk
     ```

---

## 実行方法②：ソースコードからビルド・実行する方法（iOS / Android 共通）

> **※ iOS 向けアプリについて**  
> iOS アプリは Apple のコード署名制限により署名なし IPA ファイルの他環境へのインストールが困難なため、iOS 環境（シミュレータ／実機）での動作確認は以下の手順に沿ってソースコードからビルド・実行してください。

### 1. 前提環境

- **Flutter SDK**: `3.x`（Dart SDK `^3.12.2`）
- **Android ビルド時**:
  - Android Studio / Android SDK
  - Java 17（JDK 17）
- **iOS ビルド時（macOS のみ）**:
  - Xcode（最新安定版推奨）
  - CocoaPods（`sudo gem install cocoapods` または `brew install cocoapods`）

### 2. リポジトリのクローンとパッケージ取得

```bash
git clone https://github.com/Devfest-Hackathon-2026/df-2026-t109.git
cd df-2026-t109
flutter pub get
```

### 3. Google Maps API キーの設定

セキュリティ保護のため、Google Maps API キーはリポジトリに含めていません。ビルド前に以下の設定ファイルを作成し、Maps SDK for Android / Maps SDK for iOS（および Places API）が有効化された API キーを設定してください。

#### Android 向け設定（`android/local.properties`）
`android/local.properties` ファイルを開き（存在しない場合は新規作成し）、以下の行を追加します：

```properties
GOOGLE_MAPS_API_KEY=あなたのGoogleMapsAPIキー
```

#### iOS 向け設定（`ios/Flutter/Secrets.xcconfig`）
`ios/Flutter/Secrets.xcconfig` ファイルを新規作成し、以下の行を記述します：

```xcconfig
GOOGLE_MAPS_API_KEY=あなたのGoogleMapsAPIキー
```

### 4. アプリのビルド・起動

#### iOS シミュレータ / 実機で実行する場合（macOS）

```bash
cd ios
pod install
cd ..
flutter run -d ios
```
（※ 特定の iOS シミュレータを指定する場合は `flutter devices` でデバイス ID を確認し、`flutter run -d <デバイスID>` を実行してください）

#### Android エミュレータ / 実機で実行する場合

```bash
flutter run -d android
```

#### Android リリース APK をビルドする場合

```bash
flutter build apk --release
```
ビルド完了後、`build/app/outputs/flutter-apk/app-release.apk` に APK ファイルが生成されます。

---

## 技術スタック

- **フレームワーク / 言語**: Flutter / Dart
- **対象プラットフォーム**: iOS / Android
- **地図・位置情報**:
  - `google_maps_flutter`（Google Maps SDK for Android / iOS）
  - Google Places API（場所検索・オートコンプリート）
  - `geolocator`（現在地取得・移動ルートトラッキング）
- **バックエンド / BaaS (Firebase)**:
  - Firebase Authentication / Google Sign-In（ユーザー認証）
  - Cloud Firestore（旅行記録・ピン・グループ・共有データの保存）
  - Cloud Storage for Firebase（写真データの保存）

---

## ライセンス

[MIT License](LICENSE)
