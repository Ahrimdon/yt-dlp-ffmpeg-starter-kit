@echo off

::Convert Bitrate 
.\ffmpeg -i "input.mp4" -vf scale=2560:1440 -b:v 1M output.mp4

:::Convert Bitrate w/ Hardware Acceleration
::.\ffmpeg -hwaccel cuda -i "input.mp4" -vf scale=w:h -b:v 20M output.mp4

:::Embed Thumbnai
::.\ffmpeg -i input.mp4 -i image.png -map 1 -map 0 -c copy -disposition:0 attached_pic output.mp4

:::Convert .wav to .m4a
::.\ffmpeg -i input.wav -b:a 128k output.m4a

:::Convert .wav to .mp3
::.\ffmpeg -i input.wav -b:a 320k output.mp3