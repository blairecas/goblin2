@echo off

echo.
echo ===========================================================================
echo Graphics
echo ===========================================================================
php -f ./scripts/conv_graphics.php
if %ERRORLEVEL% NEQ 0 ( exit /b )

echo.
echo ===========================================================================
echo Compiling 
echo ===========================================================================
php -f ../scripts/preprocess.php acpu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -l _acpu.lst _acpu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _acpu.lst ./release/gobli2.sav sav
if %ERRORLEVEL% NEQ 0 ( exit /b )

..\scripts\rt11dsk.exe d .\release\gobli2.dsk gobli2.sav >NUL
..\scripts\rt11dsk.exe a .\release\gobli2.dsk .\release\gobli2.sav >NUL

..\scripts\rt11dsk.exe d ..\..\03_dsk\hdd.dsk gobli2.sav >NUL
..\scripts\rt11dsk.exe a ..\..\03_dsk\hdd.dsk .\release\gobli2.sav >NUL

rem del _acpu.lst
del _acpu.mac

@2_run_ukncbtl.bat
rem @3_run_emustudio.bat