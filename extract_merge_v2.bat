@echo off
setlocal EnableDelayedExpansion

rem === 1. Where to put the extracted files ===============================
set "DEST=final_output"
if not exist "%DEST%" md "%DEST%"

rem === 2. File types to consider (add/remove extensions if you wish) ====
set "EXT_LIST=7z zip rar tar gz bz2 xz tgz tbz2 txz wim cab iso img lzh lzma z jar arj rpm deb cpio msi swm crx dmg"

echo 🔄 Step 1: Extracting all supported archives...
for %%E in (%EXT_LIST%) do (
    for %%F in ("*.%%E") do (
        if exist "%%~F" (
            echo ➤ Extracting: %%~nxF
            "C:\Program Files\7-Zip\7z.exe" x "%%~F" -o"%DEST%" -y >nul
            if errorlevel 1 (
                echo   ⚠️  Skipped %%~nxF – not a valid or supported archive.
            )
        )
    )
)

echo ✅ Step 1 complete: Extraction finished.

echo.
echo 🔄 Step 2: Looking for 'cstrike' folders to flatten...

set "FOUND=0"

rem === Loop through all 'cstrike' folders inside DEST (even nested) ===
for /d /r "%DEST%" %%D in (cstrike) do (
    if exist "%%D" (
        echo ➤ Found: %%D
        set "FOUND=1"

        echo    📁 Moving contents from %%D to %DEST%...
        xcopy /e /i /y "%%D\*" "%DEST%\" >nul

        echo    🗑️ Deleting folder: %%D
        rmdir /s /q "%%D"
    )
)

if "%FOUND%"=="0" (
    echo ✅ No 'cstrike' folders found. Nothing to flatten.
) else (
    echo ✅ Step 2 complete: All 'cstrike' folders flattened!
)

pause
