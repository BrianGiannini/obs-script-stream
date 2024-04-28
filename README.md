# obs-script-stream

mute-media-when-displayed.lua : check every second if a media "SRTcamera" is displayed by checking the "position" of the media (not zero means it's playing) if it's displayed, it mutes the "WaitingVideo" media. Just rename with the according media names. To demute I prefer to use Advance Scene switcher Macro to check when the media source ended, wait the according time before unmute.

check-media-properties-with-hotkeys.lua : file just is useful to check properties with a hotkey. After loading the script, just go to File -> Settings -> Hotkeys > look for "Print Extended Media Properties" to set the hotkey
