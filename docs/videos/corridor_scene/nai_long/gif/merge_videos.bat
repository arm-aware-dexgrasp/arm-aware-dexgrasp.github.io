@echo off
setlocal enabledelayedexpansion

REM 输出文件
set output=merged.mp4

REM 收集视频列表
set /a idx=0
set inputs=
set filter=

REM 遍历所有 mp4 文件
for %%f in (*.mp4) do (
    set inputs=!inputs! -i "%%f"
    set filter=!filter![!idx!:v]
    set /a idx+=1
)

if %idx% lss 2 (
    echo Need at least 2 videos to merge!
    pause
    exit /b
)

REM 构建 filter_complex
set filter_complex=%filter%hstack=inputs=%idx%

echo FFmpeg command:
echo ffmpeg %inputs% -filter_complex "%filter_complex%" -c:v libx264 -crf 23 -preset veryfast %output%
echo.

REM 执行 FFmpeg
ffmpeg %inputs% -filter_complex "%filter_complex%" -c:v libx264 -crf 23 -preset veryfast %output%

echo Done! Output: %output%
pause
