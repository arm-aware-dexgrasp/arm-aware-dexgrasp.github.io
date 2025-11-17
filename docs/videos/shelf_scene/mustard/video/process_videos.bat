@echo off
setlocal enabledelayedexpansion

:: === 配置区域 ===
set X_OFFSET=330
set VIDEO_BITRATE=3000k
set OUTPUT_DIR=..\gif

:: 创建输出目录
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo Processing videos (1:1 crop + 3x speed + no audio)...

for %%f in (*.mp4) do (
    echo ------------------------------
    echo Processing: %%f

    ffmpeg -i "%%f" ^
    -filter_complex "crop=ih:ih:%X_OFFSET%:0,setpts=PTS/3" ^
    -c:v libx264 -preset fast ^
    -an ^
    "%OUTPUT_DIR%\%%~nf.mp4"
)

echo Done!
pause