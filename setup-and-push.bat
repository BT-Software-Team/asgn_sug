@echo off
setlocal enabledelayedexpansion

echo ============================================
echo  AmplideX Docs - GitHub Setup and Push
echo ============================================
echo.

:: Move to the directory this script lives in
cd /d "%~dp0"

:: Check for gh CLI
where gh >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] GitHub CLI (gh) is not installed or not in PATH.
    echo.
    echo Please install it from: https://cli.github.com
    echo Then re-run this script.
    pause
    exit /b 1
)

echo [1/5] Checking GitHub auth...
gh auth status >nul 2>&1
if %errorlevel% neq 0 (
    echo Not logged in. Opening GitHub login...
    gh auth login
)

echo [2/5] Initialising git repo...
git init
git checkout -b main

echo [3/5] Creating GitHub repo: A1R-software-user-guide (private)...
gh repo create A1R-software-user-guide --private --source=. --remote=origin --description="AmplideX One Reporter Software User Guide"
if %errorlevel% neq 0 (
    echo.
    echo [WARN] Repo may already exist or name is taken.
    echo Trying to set remote manually...
    git remote remove origin 2>nul
    gh repo view hannaheborel/A1R-software-user-guide >nul 2>&1
    if %errorlevel% equ 0 (
        git remote add origin https://github.com/hannaheborel/A1R-software-user-guide.git
    ) else (
        echo [ERROR] Could not find or create the repo. Check your GitHub access and try again.
        pause
        exit /b 1
    )
)

echo [4/5] Committing files...
git add .
git commit -m "Initial docs structure - AmplideX One Reporter v2.0"

echo [5/5] Pushing to GitHub...
git push -u origin main

echo.
echo ============================================
echo  Done! Repo is live at:
gh repo view --web
echo ============================================
pause
