#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# generate_all_limits.py
# すべての極限問題のグラフを生成するメインスクリプト

import os
import sys
import subprocess

def main():
    """すべての極限問題のグラフを生成"""
    
    # スクリプトのディレクトリを取得
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # 出力ディレクトリを作成
    output_dir = "/Users/nakamurashunsuke/Documents/joymath/assets/graphs/problems_limits"
    os.makedirs(output_dir, exist_ok=True)
    
    print("=" * 60)
    print("極限問題のグラフ生成を開始します")
    print("=" * 60)
    
    # 各カテゴリのグラフ生成スクリプトを実行
    generators = [
        ("基本極限問題", "limit_basic_generator.py"),
        ("有理化問題", "limit_rationalization_generator.py"),
        ("三角関数極限問題", "limit_trigonometric_generator.py"),
    ]
    
    for category, script_name in generators:
        print(f"\n{category}のグラフを生成中...")
        script_path = os.path.join(script_dir, script_name)
        
        try:
            result = subprocess.run([sys.executable, script_path], 
                                  capture_output=True, text=True, cwd=script_dir)
            if result.returncode == 0:
                print(f"✅ {category}のグラフ生成完了")
            else:
                print(f"❌ {category}のグラフ生成でエラーが発生しました:")
                print(result.stderr)
        except Exception as e:
            print(f"❌ {category}のグラフ生成で例外が発生しました: {e}")
    
    print("\n" + "=" * 60)
    print("すべての極限問題のグラフ生成が完了しました！")
    print(f"出力先: {output_dir}")
    print("=" * 60)

if __name__ == "__main__":
    main()
