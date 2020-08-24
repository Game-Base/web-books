@echo off
color 0a
title    硬件检测       
mode con cols=90
sc config  winmgmt start= auto >nul 2<&1
net start winmgmt 2>1nul
setlocal  ENABLEDELAYEDEXPANSION
echo 主版:
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       制造商   = %%b
     if "!tee!" == "4" echo       型  号   = %%b
     if "!tee!" == "5" echo       序列号   = %%b
     if "!tee!" == "6" echo       版  本   = %%b
)
set tee=0
echo      BIOS:
for /f "tokens=1,* delims==" %%a in ('wmic bios  get 

CurrentLanguage^,Manufacturer^,SMBIOSBIOSVersion^,SMBIOSMajorVersion^,SMBIOSMinorVersion^,ReleaseDate /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       当前语言 = %%b
     if "!tee!" == "4" echo       制造商   = %%b
     if "!tee!" == "5" echo       发行日期 = %%b
     if "!tee!" == "6" echo       版  本   = %%b
     if "!tee!" == "7" echo       SMBIOSMajorVersion = %%b
     if "!tee!" == "8" echo       SMBIOSMinorVersion = %%b 
)
set tee=0
echo.
echo CPU:
for /f "tokens=1,* delims==" %%a in ('wmic cpu get name^,ExtClock^,CpuStatus^,Description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       CPU个数   = %%b
     if "!tee!" == "4" echo       处理器版本   = %%b
     if "!tee!" == "5" echo       外   频   = %%b
     if "!tee!" == "6" echo       名称及主频率   = %%b
)
set tee=0
echo.
echo 显示器:
for /f "tokens=1,* delims==" %%a in ('wmic DESKTOPMONITOR get name^,ScreenWidth^,ScreenHeight^ /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       类    型  = %%b
     if "!tee!" == "5" echo       屏幕高    = %%b
     if "!tee!" == "6" echo       屏幕宽    = %%b
)
set tee=0
echo.
echo 硬  盘:
for /f "tokens=1,* delims==" %%a in ('wmic DISKDRIVE get model^,interfacetype^,size^,totalsectors^,partitions /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       接口类型  = %%b
     if "!tee!" == "4" echo       硬盘型号  = %%b
     if "!tee!" == "5" echo       分区数    = %%b
     if "!tee!" == "6" echo       容    量  = %%b
     if "!tee!" == "7" echo       总扇区    = %%b
)
echo 分区信息:
wmic LOGICALDISK  where mediatype='12' get description,deviceid,filesystem,size,freespace
set tee=0
echo.

echo 内    存: 
for /f "tokens=1,* delims==" %%a in ('systeminfo^|find "内存"') do (
    echo         %%a 4534 %%b 
)
echo.
echo 显    卡:
echo 正在加载...
del /f "%TEMP%\temp.txt" 2>nul
dxdiag /t %TEMP%\temp.txt
:显卡
rem 这里需要30秒左右!
if EXIST "%TEMP%\temp.txt" (
    for /f "tokens=1,* delims=:" %%a in ('findstr /c:" Card name:" /c:"Display Memory:" /c:"Current Mode:" /c:"Monitor Model:" "%TEMP%\temp.txt"') do (
         set /a tee+=1
         if !tee! == 1 echo     显卡型号: %%b
         if !tee! == 2 echo     显存大小: %%b
         if !tee! == 3 echo     当前设置: %%b
		 if !tee! == 4 echo     显示器1 : %%b
		 if !tee! == 4 echo     显示器2 : %%b
)   ) else (
    ping /n 2 127.1>nul
    goto 显卡
)
ipconfig
set /p var=需要额外信息吗(y/n): 
if /i %var% == y notepad "%TEMP%\temp.txt"
del /f "%TEMP%\temp.txt" 2>nul
pause
