# スケーラブルなデータ管理アーキテクチャ提案

## 現在の問題点

### 1. データ構造の分散
- 学習記録: LearningRecordService (個別キー管理)
- 履歴管理: ProblemHistoryManager (別のキー体系)  
- ガチャ設定: 各ガチャページで個別管理
- 移行処理: LegacyDataMigration (一時的)

### 2. キー管理の複雑さ
```
現在のキー体系:
'{problemId}_status'           // 学習記録
'{problemId}_history'          // 履歴
'history_map'                  // 履歴マップ
'{prefix}_problem_statuses_v1' // ガチャ設定
'{prefix}_gacha_filter_mode_v1' // フィルタ設定
```

## 提案するアーキテクチャ

### 1. 統一データサービス層
```
DataService (統一インターフェース)
├── LearningDataService (学習記録)
├── HistoryDataService (履歴管理)
├── GachaDataService (ガチャ設定)
└── MigrationService (データ移行)
```

### 2. 階層化されたキー体系
```
app_data/
├── learning/
│   ├── status/{problemId}
│   └── history/{problemId}
├── gacha/
│   ├── {gachaType}/settings
│   └── {gachaType}/filters
└── system/
    ├── migration_flags
    └── app_version
```

### 3. 型安全なデータ管理
- 各データタイプごとの専用サービス
- ジェネリック型による型安全性
- バリデーション機能

### 4. プラグイン可能な拡張システム
- 新しいガチャタイプの追加が容易
- 新しい問題タイプの追加が容易
- データ移行の自動化

## 実装のメリット

1. **保守性向上**: 統一されたインターフェース
2. **拡張性**: 新しい機能の追加が容易
3. **型安全性**: コンパイル時エラー検出
4. **テスト容易性**: 各サービスが独立
5. **データ整合性**: 一元化されたデータ管理
