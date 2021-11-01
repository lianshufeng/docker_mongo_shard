@echo off
cd /d  %~dp0\..


for /R %%s in (*.js) do (
  cmd /c %~dp0dos2unix.exe %%s
)
for /R %%s in (*.env) do (
  cmd /c %~dp0dos2unix.exe %%s
)
for /R %%s in (*.yml) do (
  cmd /c %~dp0dos2unix.exe %%s
)
for /R %%s in (*.sh) do (
  cmd /c %~dp0dos2unix.exe %%s
)
for /R %%s in (*.conf) do (
  cmd /c %~dp0dos2unix.exe %%s
)

pause 