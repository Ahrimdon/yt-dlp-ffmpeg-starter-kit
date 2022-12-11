@echo off
::set /p url=<URL.txt
::set /p filename=<"Temp.txt"
goto asciiart

(
:asciiart
cls
echo.
echo.
echo.
echo.
echo.
echo.
echo                   ######  ########  ########    ###    ######## ######## ########     ########  ##    ##
echo                  ##    ## ##     ## ##         ## ##      ##    ##       ##     ##    ##     ##  ##  ##
echo                  ##       ##     ## ##        ##   ##     ##    ##       ##     ##    ##     ##   ####
echo                  ##       ########  ######   ##     ##    ##    ######   ##     ##    ########     ##
echo                  ##       ##   ##   ##       #########    ##    ##       ##     ##    ##     ##    ##
echo                  ##    ## ##    ##  ##       ##     ##    ##    ##       ##     ##    ##     ##    ##
echo                   ######  ##     ## ######## ##     ##    ##    ######## ########     ########     ##
echo.
echo                           ###    ##     ## ########  #### ##     ## ########   #######  ##    ##
echo                          ## ##   ##     ## ##     ##  ##  ###   ### ##     ## ##     ## ###   ##
echo                         ##   ##  ##     ## ##     ##  ##  #### #### ##     ## ##     ## ####  ##
echo                        ##     ## ######### ########   ##  ## ### ## ##     ## ##     ## ## ## ##
echo                        ######### ##     ## ##   ##    ##  ##     ## ##     ## ##     ## ##  ####
echo                        ##     ## ##     ## ##    ##   ##  ##     ## ##     ## ##     ## ##   ###
echo                        ##     ## ##     ## ##     ## #### ##     ## ########   #######  ##    ##
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto start
)

color 0D

(
:start
set /p ans= "SELECT ONE (CONVERT FORMAT [CF], CONVERT BITRATE [CB], EMBED IMAGE AS VIDEO THUMBNAIL [E], CHANGE RESOLUTION [R]): "
echo.
)

if %ans%==cf goto cf
if %ans%==Cf goto cf
if %ans%==CF goto cf
if %ans%=="convert format" goto cf
if %ans%=="Convert Format" goto cf
if %ans%=="CONVERT FORMAT" goto cf

if %ans%==cb goto cb
if %ans%==Cb goto cb
if %ans%==CB goto cb
if %ans%=="convert bitrate" goto cb
if %ans%=="Convert Bitrate" goto cb
if %ans%=="CONVERT BITRATE" goto cb

if %ans%==e goto cb
if %ans%==E goto cb
if %ans%=="embed image as video thumbnail" goto cb
if %ans%=="Embed Image As Video Thumbnail" goto cb
if %ans%=="EMBED IMAGE AS VIDEO THUMBNAIL" goto cb

if %ans%==r goto resizevideo
if %ans%==R goto resizevideo
if %ans%=="embed image as video thumbnail" goto resizevideo
if %ans%=="Embed Image As Video Thumbnail" goto resizevideo
if %ans%=="EMBED IMAGE AS VIDEO THUMBNAIL" goto resizevideo

::

(

(
:cf
set /p formatfrom1= "WHAT VIDEO FORMAT ARE YOU CONVERTING FROM? (mkv, mp4, webm): "
echo.
set /p formatto1= "WHAT VIDEO FORMAT ARE YOU CONVERTING TO? (mkv, mp4, webm): "

.\ffmpeg -i input.%formatfrom1% -movflags use_metadata_tags output.%formatto1%


)

(
:cb
set /p bitrate= "ENTER NEW BITRATE?: "
echo.
set /p sizeprompt= "CHANGE VIDEO RESOLUTION? (Y/N): "
if %sizeprompt%==YES goto resizevideo
if %sizeprompt%==Yes goto resizevideo
if %sizeprompt%==yes goto resizevideo
if %sizeprompt%==Y goto resizevideo
if %sizeprompt%==y goto resizevideo

if %sizeprompt%==NO goto noresizevideo
if %sizeprompt%==No goto noresizevideo
if %sizeprompt%==no goto noresizevideo
if %sizeprompt%==N goto noresizevideo
if %sizeprompt%==n goto noresizevideo


:resizevideo
echo [w:h] (Ex. 1920:1080, 2560:1440)
set /p size= "VIDEO RESOLUTION: "
echo.




set /p hwaccelprompt= "USE HARDWARE ACCELERATION?: "
if %hwaccelprompt%==NO goto noresizevideo
if %hwaccelprompt%==No goto noresizevideo
if %hwaccelprompt%==no goto noresizevideo
if %hwaccelprompt%==N goto noresizevideo
if %hwaccelprompt%==n goto noresizevideo

)

:resizevideo

:execmain
.\ffmpeg -i input.%ext1% output.%ext2%

:exec
.\ffmpeg -i "input.mp4" -vf scale=%scale1% -b:v %bitrate1%M output.mp4

:exec1
.\ffmpeg -i input.%ext5% -i image.png -map 1 -map 0 -c copy -disposition:0 attached_pic output.%ext6%

:exec2
.\ffmpeg -i input.%ext7% -b:a 128k output.%ext8%


)

exit