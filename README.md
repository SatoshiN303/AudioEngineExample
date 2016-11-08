AudioEngineExample
===

## 概要

　録音時にエコーがかったようになってしまうバグの確認用プロジェクト　

## バグ発生箇所

[AudioEngineService.swift](https://github.com/satoshin-IST/AudioEngineExample/blob/master/AudioEngineExample/AudioEngineService.swift) 

64行目 `buffer.frameLength = size` 

上記を設定すると該当のバグ発生。コメントアウトすると問題なく録音される

## 備考

確認時は　iExploer 等を利用して直接　.caf を再生してください。
