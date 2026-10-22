@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================
echo   Piper Studio Pro
echo ============================================
echo.

set PY=.venv\Scripts\python.exe

if not exist "%PY%" (
    echo [*] Creating virtual environment...
    where py >nul 2>nul
    if errorlevel 1 (
        echo [X] Python "py" launcher not found. Install Python 3.12 first.
        pause & exit /b 1
    )
    py -3.12 -m venv .venv
    "%PY%" -m pip install --upgrade pip
    "%PY%" -m pip install piper-tts soundfile numpy pygame
    echo.
)

"%PY%" -c "import piper, soundfile, numpy, pygame" 2>nul
if errorlevel 1 (
    echo [!] Some packages missing. Installing...
    "%PY%" -m pip install piper-tts soundfile numpy pygame
)

if not exist "piper_studio_pro.py" (
    echo [X] piper_studio_pro.py missing next to this .bat
    pause & exit /b 1
)

where ffmpeg >nul 2>nul
if errorlevel 1 (
    if exist "ffmpeg.exe" (echo [*] ffmpeg.exe found locally.) else (echo [!] ffmpeg not found - WAV only.)
) else (
    echo [*] ffmpeg found on PATH.
)

echo.
echo [*] Launching Piper Studio Pro...
"%PY%" piper_studio_pro.py
if errorlevel 1 (
    echo.
    echo [X] GUI crashed. Scroll up for details.
    pause
)