@echo off
setlocal enabledelayedexpansion

set "input_dir=C:\Users\lance\AppData\Roaming\Stand\Lua Scripts\resources\corgi\dark"
set "output_dir=C:\Users\lance\AppData\Roaming\Stand\Lua Scripts\resources\corgi\dark"

for %%F in ("%input_dir%\*.png") do (
    set "input_file=%%~nxF"
    set "output_file=flipped_%%~nF.png"
    
    ffmpeg -i "!input_dir!\!input_file!" -vf "hflip" "!output_dir!\!output_file!"
)

echo All images flipped successfully.

pause