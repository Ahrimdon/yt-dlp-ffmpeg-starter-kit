@echo off
goto asciiart
::set /p url=<URL.txt

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

::
::color 0D

(
:start
set /p url= "VIDEO URL: "
echo.
set /p ans= "WHAT DO YOU WISH TO DOWNLOAD? (Video [V], Audio [A], Thumbnail [T], Data [D]): "
echo.
if %ans%==v goto seg
if %ans%==V goto seg
if %ans%==video goto seg
if %ans%==Video goto seg
if %ans%==VIDEO goto seg

if %ans%==a goto seg2
if %ans%==A goto seg2
if %ans%==audio goto seg2
if %ans%==Audio goto seg2
if %ans%==AUDIO goto seg2

if %ans%==t goto thumbnail
if %ans%==T goto thumbnail
if %ans%==thumbnail goto thumbnail
if %ans%==Thumbnail goto thumbnail
if %ans%==THUMBNAIL goto thumbnail

if %ans%==d goto data
if %ans%==D goto data
if %ans%==data goto data
if %ans%==Data goto data
if %ans%==DATA goto data
)

::

(
:seg
set /p segans= "DOWNLOAD VIDEO SEGMENT? (Y/N): "
echo.
if %segans%==YES goto segvideo
if %segans%==Yes goto segvideo
if %segans%==yes goto segvideo
if %segans%==Y goto segvideo
if %segans%==y goto segvideo

if %segans%==NO goto fullvideo
if %segans%==No goto fullvideo
if %segans%==no goto fullvideo
if %segans%==N goto fullvideo
if %segans%==n goto fullvideo
)

(
:seg2
set /p segans1= "DOWNLOAD AUDIO SEGMENT? (Y/N): "
echo.
if %segans1%==YES goto segaudio
if %segans1%==Yes goto segaudio
if %segans1%==yes goto segaudio
if %segans1%==Y goto segaudio
if %segans1%==y goto segaudio

if %segans1%==NO goto fullaudio
if %segans1%==No goto fullaudio
if %segans1%==no goto fullaudio
if %segans1%==N goto fullaudio
if %segans1%==n goto fullaudio
)

::

(
:fullvideo
set /p ans1= "WHAT VIDEO CODEC DO YOU WISH TO DOWNLOAD THE VIDEO IN? (mkv, mp4, webm) or (Default [D]): "

if %ans1%==mkv goto mkv
if %ans1%==Mkv goto mkv
if %ans1%==MKV goto mkv

if %ans1%==mp4 goto mp4
if %ans1%==Mp4 goto mp4
if %ans1%==MP4 goto mp4

if %ans1%==webm goto webm
if %ans1%==Webm goto webm
if %ans1%==WEBM goto webm

if %ans1%==d goto defaultvideo
if %ans1%==D goto defaultvideo
if %ans1%==Default goto defaultvideo
if %ans1%==DEFAULT goto defaultvideo

(
:mkv
.\yt-dlp -v -f "(bestvideo+bestaudio/best)" --add-metadata --embed-thumbnail --embed-metadata --embed-chapters --console-title --progress --windows-filenames --merge-output-format mkv -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:mp4
.\yt-dlp -v -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --add-metadata --embed-thumbnail --embed-chapters --embed-metadata --console-title --progress --windows-filenames --merge-output-format mp4 -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:webm
.\yt-dlp -v -f "(bestvideo+bestaudio/best)" --merge-output-format webm --add-metadata --embed-thumbnail --embed-chapters --embed-metadata --console-title --progress --windows-filenames -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:defaultvideo
.\yt-dlp -v -f "(bestvideo+bestaudio/best)" --add-metadata --embed-thumbnail --embed-metadata --embed-chapters --console-title --progress --windows-filenames -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)
)

::

(
:segvideo
set /p segans1= "WHAT VIDEO CODEC DO YOU WISH TO DOWNLOAD THE SEGMENT IN? (mkv, webm) or (Default [D]): "
echo.

if %segans1%==mkv goto timesegmkv
if %segans1%==Mkv goto timesegmkv
if %segans1%==MKV goto timesegmkv

if %segans1%==webm goto timesegwebm
if %segans1%==Webm goto timesegwebm
if %segans1%==WEBM goto timesegwebm

if %segans1%==d goto timesegdefault
if %segans1%==D goto timesegdefault
if %segans1%==default goto timesegdefault
if %segans1%==Default goto timesegdefault
if %segans1%==DEFAULT goto timesegdefault

:timesegdefault
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestvideo+bestaudio/best)[protocol!*=dash]" --add-metadata --embed-thumbnail --embed-metadata --embed-chapters --console-title --progress --windows-filenames -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:timesegwebm
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestvideo+bestaudio/best)[protocol!*=dash]" --add-metadata --embed-thumbnail --embed-metadata --embed-chapters --console-title --progress --windows-filenames --merge-output-format webm -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:timesegmkv
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestvideo+bestaudio/best)[protocol!*=dash]" --add-metadata --embed-thumbnail --embed-metadata --embed-chapters --console-title --progress --windows-filenames --merge-output-format mkv -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)


::


(
:fullaudio
set /p ans2= "WHAT AUDIO CODEC DO YOU WISH TO DOWNLOAD THE AUDIO IN? (wav, mp3, m4a) or (Default [D]): "

if %ans2%==wav goto wav
if %ans2%==Wav goto wav
if %ans2%==WAV goto wav

if %ans2%==mp3 goto mp3
if %ans2%==Mp3 goto mp3
if %ans2%==MP3 goto mp3

if %ans2%==m4a goto m4a
if %ans2%==M4a goto m4a
if %ans2%==M4A goto m4a

if %ans2%==d goto defaultaudio
if %ans2%==D goto defaultaudio
if %ans2%==Default goto defaultaudio
if %ans2%==DEFAULT goto defaultaudio

(
:wav
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --audio-format wav --no-playlist --console-title --progress --windows-filenames --paths "Audio/.wav" -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto wav2
(
:wav2
echo YOUR AUDIO IS IN THE "Audio/.wav" FOLDER.
echo.
pause
exit
)
)

(
:mp3
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --audio-format mp3 --add-metadata --embed-thumbnail --embed-metadata --no-playlist --console-title --progress --windows-filenames --paths "Audio/.mp3" -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto mp32
(
:mp32
echo YOUR AUDIO IS IN THE "Audio/.mp3" FOLDER.
echo.
pause
exit
)
)

(
:m4a
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --audio-format m4a --add-metadata --embed-thumbnail --embed-metadata --no-playlist --console-title --progress --windows-filenames --paths "Audio/.m4a" -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto m4a
(
:m4a2
echo YOUR AUDIO IS IN THE "Audio/.m4a" FOLDER.
echo.
pause
exit
)
)
)

(
:segaudio
set /p segans2= "WHAT AUDIO CODEC DO YOU WISH TO DOWNLOAD THE SEGMENT IN? (wav, mp3, m4a) or (Default [D]): "
echo.

if %segans2%==wav goto timesegwav
if %segans2%==Wav goto timesegwav
if %segans2%==WAV goto timesegwav

if %segans2%==m4a goto timesegm4a
if %segans2%==M4a goto timesegm4a
if %segans2%==M4A goto timesegm4a

if %segans2%==mp3 goto timesegmp3
if %segans2%==Mp3 goto timesegmp3
if %segans2%==MP3 goto timesegmp3

if %segans2%==d goto timesegaudiodefault
if %segans2%==D goto timesegaudiodefault
if %segans2%==default goto timesegaudiodefault
if %segans2%==Default goto timesegaudiodefault
if %segans2%==DEFAULT goto timesegaudiodefault

(
:timesegaudiodefault
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --no-playlist --console-title --progress --windows-filenames --paths "Audio/Segments" -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:timesegwav
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --audio-format wav --no-playlist --console-title --progress --windows-filenames --paths "Audio/Segments" -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:timesegmp3
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --audio-format mp3 --no-playlist --console-title --progress --windows-filenames --paths "Audio/Segments" -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)

(
:timesegm4a
set /p starttime= "PLEASE ENTER THE SEGMENT START TIME (hr:min:sec.ms): "
echo.
set /p endtime= "PLEASE ENTER THE SEGMENT END TIME (hr:min:sec.ms): "
.\yt-dlp -v -f "(bestaudio)" --extract-audio --audio-quality 0 --audio-format m4a --no-playlist --console-title --progress --windows-filenames --paths "Audio/Segments" -o "%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %starttime% -to %endtime%" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto converter
)
)

::

(
:thumbnail
.\yt-dlp -v --skip-download --write-thumbnail --convert-thumbnail png --no-playlist --console-title --progress --windows-filenames --paths "Thumbnails" -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto thumbnail2
(
:thumbnail2
echo YOUR THUMBNAIL IS IN THE "Thumbnails" FOLDER.
echo.
pause
exit
)
)

(
:data
set /p comments="WRITE COMMENTS? (Y/N): "
if %comments%==Y goto datacomments
if %comments%==y goto datacomments
if %comments%==N goto datanocomments
if %comments%==n goto datanocomments
(
:datacomments
.\yt-dlp -v --skip-download --write-comments --write-description --write-info-json --write-subs --sub-langs all --no-playlist --console-title --progress --windows-filenames --paths "Data" -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto data2
)
(
:datanocomments
.\yt-dlp -v --skip-download --write-description --write-info-json --write-subs --sub-langs all --no-playlist --console-title --progress --windows-filenames --paths "Data" -o "%%(title)s.%%(ext)s" "%url%"
if errorlevel 1 goto asciiart
color 0A
echo.
echo Done
echo.
goto data2
)

(
:data2
echo YOUR DATA (.json/.description) FILES ARE IN THE "Data" FOLDER.
echo DATA INCLUDE SUBTITLES, THUMBNAILS, COMMENTS, VIDEO METADATA, ETC.
echo.
echo *TIP: USE "BEAUTIFY JSON" EXTENSION FOR VISUAL STUDIO CODE FOR EASY VIEWING!
echo.
pause
exit
)
)

:converter
echo.
set /p menu="DO YOU WANT TO REMUX (CONVERT) THIS VIDEO? (Y/N): "
if %menu%==Y goto Yes
if %menu%==y goto Yes
if %menu%==N goto No
if %menu%==n goto No

:Yes
call "Converter"

pause


:No
exit