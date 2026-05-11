fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### release_all_platforms

```sh
[bundle exec] fastlane release_all_platforms
```

iOS・Android: ビルド→アップロード→審査提出。iOS は審査通過後に自動でストア公開

オプション: skip_build:true (既存ビルドを使用), skip_ios:true (iOSをスキップ), skip_android:true (Androidをスキップ)

----


## iOS

### ios release_all

```sh
[bundle exec] fastlane ios release_all
```

iOS + Android をビルドし、審査提出・iOS 自動公開（承認後）まで実行

----


## Android

### android release_all

```sh
[bundle exec] fastlane android release_all
```

Android をビルドし Google Play へ審査提出

オプション: skip_build:true (既存ビルドを使用)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
