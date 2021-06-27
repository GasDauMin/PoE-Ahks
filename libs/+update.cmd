@echo off

cd %~dp0

rmdir /Q /S AhkJson
rmdir /Q /S AhkEval

git clone https://github.com/cocobelgica/AutoHotkey-JSON.git ./AhkJson
git clone https://github.com/Pulover/Eval.git ./AhkEval