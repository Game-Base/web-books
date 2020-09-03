@echo off& setlocal enabledelayedexpansion

for /f "delims=" %%1 in ('dir /a /b') do (set wind=%%1

ren "%%~1" "!wind:OPE_=!")

