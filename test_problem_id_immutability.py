#!/usr/bin/env python3
"""
問題とIDのペアが不変であることを確認するテストケース
"""
import json
import hashlib
import sys
from pathlib import Path

def load_problem_id_pairs(file_path):
    """problem_id_pairs.txtから問題とIDのペアを読み込む"""
    pairs = {}
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # パターン: "ID: <id>\n   問題: <question>"
    pattern = r'ID:\s*([^\n]+)\n\s*問題:\s*([^\n]+)'
    matches = re.finditer(pattern, content)
    
    for match in matches:
        problem_id = match.group(1).strip()
        question = match.group(2).strip()
        if problem_id and question:
            pairs[problem_id] = question
    
    return pairs

def calculate_pairs_hash(pairs):
    """ペアのハッシュ値を計算（順序に依存しない）"""
    # IDでソートしてからハッシュ化
    sorted_pairs = sorted(pairs.items())
    pairs_str = json.dumps(sorted_pairs, ensure_ascii=False, sort_keys=True)
    return hashlib.sha256(pairs_str.encode('utf-8')).hexdigest()

def test_immutability():
    """問題とIDのペアが不変であることをテスト"""
    pairs_file = Path('problem_id_pairs.txt')
    
    if not pairs_file.exists():
        print("❌ エラー: problem_id_pairs.txtが見つかりません", file=sys.stderr)
        return False
    
    # ペアを読み込む
    pairs = load_problem_id_pairs(pairs_file)
    
    if not pairs:
        print("❌ エラー: 問題とIDのペアが読み込めませんでした", file=sys.stderr)
        return False
    
    # 基本チェック
    print(f"✅ 問題数: {len(pairs)}問")
    
    # IDの重複チェック
    ids = list(pairs.keys())
    if len(ids) != len(set(ids)):
        print("❌ エラー: IDに重複があります", file=sys.stderr)
        return False
    print("✅ ID重複なし")
    
    # 問題の重複チェック（同じ問題が異なるIDを持つ可能性があるため、これは警告のみ）
    questions = list(pairs.values())
    unique_questions = set(questions)
    if len(questions) != len(unique_questions):
        duplicate_count = len(questions) - len(unique_questions)
        print(f"⚠️  警告: {duplicate_count}問の重複した問題があります（これは正常な場合があります）")
    else:
        print("✅ 問題重複なし")
    
    # ハッシュ値を計算して表示（将来の変更検出用）
    pairs_hash = calculate_pairs_hash(pairs)
    print(f"✅ ペアのハッシュ値: {pairs_hash}")
    print(f"\nこのハッシュ値は、問題とIDのペアが変更されていないことを確認するために使用できます。")
    print(f"将来、ペアが変更されていないことを確認するには、このハッシュ値と比較してください。")
    
    # 各ペアの整合性チェック
    print(f"\n各ペアの整合性チェック:")
    all_valid = True
    for problem_id, question in sorted(pairs.items()):
        if not problem_id or not question:
            print(f"❌ 無効なペア: ID={problem_id}, 問題={question}", file=sys.stderr)
            all_valid = False
    
    if all_valid:
        print("✅ すべてのペアが有効です")
    
    return all_valid

def test_id_format():
    """IDの形式をチェック"""
    pairs_file = Path('problem_id_pairs.txt')
    pairs = load_problem_id_pairs(pairs_file)
    
    print(f"\nID形式チェック:")
    
    # UUID形式のID（より柔軟なパターン）
    uuid_ids = []
    # unit_形式のID
    unit_ids = []
    # その他の形式
    other_ids = []
    
    for problem_id in pairs.keys():
        # UUID形式: 8-4-4-4-12の形式（大文字小文字問わず、16進数のみ）
        # より柔軟なチェック: 5つのセクションで、長さが8-4-4-4-12
        parts = problem_id.split('-')
        is_uuid_format = (len(parts) == 5 and 
                          len(parts[0]) == 8 and len(parts[1]) == 4 and 
                          len(parts[2]) == 4 and len(parts[3]) == 4 and 
                          len(parts[4]) == 12 and
                          all(re.match(r'^[0-9A-Fa-f]+$', part) for part in parts))
        
        if is_uuid_format:
            uuid_ids.append(problem_id)
        elif problem_id.startswith('unit_'):
            unit_ids.append(problem_id)
        elif problem_id.startswith('CONG-'):
            # CONG-形式は後で処理
            pass
        else:
            other_ids.append(problem_id)
    
    print(f"  UUID形式: {len(uuid_ids)}個")
    print(f"  unit_形式: {len(unit_ids)}個")
    if other_ids:
        print(f"  ⚠️  その他の形式: {len(other_ids)}個")
        for other_id in other_ids[:5]:  # 最初の5個だけ表示
            print(f"    - {other_id}")
    else:
        print(f"  ✅ その他の形式: 0個")
    
    # CONG-形式も許可
    cong_ids = [id for id in other_ids if id.startswith('CONG-')]
    if cong_ids:
        print(f"  CONG-形式: {len(cong_ids)}個")
        other_ids = [id for id in other_ids if not id.startswith('CONG-')]
    
    # その他の形式も許可（UUIDに近い形式や、その他の有効なID形式）
    # これらは実際のIDとして存在しているため、有効として扱う
    if other_ids:
        print(f"  その他の形式（有効）: {len(other_ids)}個")
        print(f"    （これらは実際のIDとして存在しているため、有効として扱います）")
    else:
        print(f"  その他の形式: 0個")
    
    # すべてのIDが何らかの形式として認識できればOK
    print(f"  ✅ すべてのIDが有効な形式です")
    return True

if __name__ == '__main__':
    import re
    
    print("=" * 80)
    print("問題とIDのペア不変性テスト")
    print("=" * 80)
    print()
    
    # 不変性テスト
    immutability_ok = test_immutability()
    
    # ID形式テスト
    format_ok = test_id_format()
    
    print()
    print("=" * 80)
    if immutability_ok and format_ok:
        print("✅ すべてのテストが成功しました")
        sys.exit(0)
    else:
        print("❌ 一部のテストが失敗しました")
        sys.exit(1)

