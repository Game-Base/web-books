@echo off
color 0a
title    Ӳ�����       
mode con cols=90
sc config  winmgmt start= auto >nul 2<&1
net start winmgmt 2>1nul
setlocal  ENABLEDELAYEDEXPANSION
echo ����:
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ������   = %%b
     if "!tee!" == "4" echo       ��  ��   = %%b
     if "!tee!" == "5" echo       ���к�   = %%b
     if "!tee!" == "6" echo       ��  ��   = %%b
)
set tee=0
echo      BIOS:
for /f "tokens=1,* delims==" %%a in ('wmic bios  get 

CurrentLanguage^,Manufacturer^,SMBIOSBIOSVersion^,SMBIOSMajorVersion^,SMBIOSMinorVersion^,ReleaseDate /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��ǰ���� = %%b
     if "!tee!" == "4" echo       ������   = %%b
     if "!tee!" == "5" echo       �������� = %%b
     if "!tee!" == "6" echo       ��  ��   = %%b
     if "!tee!" == "7" echo       SMBIOSMajorVersion = %%b
     if "!tee!" == "8" echo       SMBIOSMinorVersion = %%b 
)
set tee=0
echo.
echo CPU:
for /f "tokens=1,* delims==" %%a in ('wmic cpu get name^,ExtClock^,CpuStatus^,Description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       CPU����   = %%b
     if "!tee!" == "4" echo       �������汾   = %%b
     if "!tee!" == "5" echo       ��   Ƶ   = %%b
     if "!tee!" == "6" echo       ���Ƽ���Ƶ��   = %%b
)
set tee=0
echo.
echo ��ʾ��:
for /f "tokens=1,* delims==" %%a in ('wmic DESKTOPMONITOR get name^,ScreenWidth^,ScreenHeight^ /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��    ��  = %%b
     if "!tee!" == "5" echo       ��Ļ��    = %%b
     if "!tee!" == "6" echo       ��Ļ��    = %%b
)
set tee=0
echo.
echo Ӳ  ��:
for /f "tokens=1,* delims==" %%a in ('wmic DISKDRIVE get model^,interfacetype^,size^,totalsectors^,partitions /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       �ӿ�����  = %%b
     if "!tee!" == "4" echo       Ӳ���ͺ�  = %%b
     if "!tee!" == "5" echo       ������    = %%b
     if "!tee!" == "6" echo       ��    ��  = %%b
     if "!tee!" == "7" echo       ������    = %%b
)
echo ������Ϣ:
wmic LOGICALDISK  where mediatype='12' get description,deviceid,filesystem,size,freespace
set tee=0
echo.

echo ��    ��: 
for /f "tokens=1,* delims==" %%a in ('systeminfo^|find "�ڴ�"') do (
    echo         %%a 4534 %%b 
)
echo.
echo ��    ��:
echo ���ڼ���...
del /f "%TEMP%\temp.txt" 2>nul
dxdiag /t %TEMP%\temp.txt
:�Կ�
rem ������Ҫ30������!
if EXIST "%TEMP%\temp.txt" (
    for /f "tokens=1,* delims=:" %%a in ('findstr /c:" Card name:" /c:"Display Memory:" /c:"Current Mode:" /c:"Monitor Model:" "%TEMP%\temp.txt"') do (
         set /a tee+=1
         if !tee! == 1 echo     �Կ��ͺ�: %%b
         if !tee! == 2 echo     �Դ��С: %%b
         if !tee! == 3 echo     ��ǰ����: %%b
		 if !tee! == 4 echo     ��ʾ��1 : %%b
		 if !tee! == 4 echo     ��ʾ��2 : %%b
)   ) else (
    ping /n 2 127.1>nul
    goto �Կ�
)
ipconfig
set /p var=��Ҫ������Ϣ��(y/n): 
if /i %var% == y notepad "%TEMP%\temp.txt"
del /f "%TEMP%\temp.txt" 2>nul
pause
