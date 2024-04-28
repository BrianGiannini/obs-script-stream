obs = obslua

-- Media source names
srt_camera_name = "SRTcamera"
waiting_video_name = "WaitingVideo"

-- Function to mute a media source, only if it is not already muted
function mute_source_if_not_already_muted(source_name)
    local source = obs.obs_get_source_by_name(source_name)
    if source then
        local already_muted = obs.obs_source_muted(source)  -- Check if the source is already muted
        if not already_muted then
            obs.obs_source_set_muted(source, true)  -- Mute the source only if it is not already muted
            print(source_name .. " has been muted.")
        else
            -- print(source_name .. " was already muted.")
        end
        obs.obs_source_release(source)
    end
end

-- Check the current position of the media source
function check_media_position()
    local source = obs.obs_get_source_by_name(srt_camera_name)
    if source then
        local position = obs.obs_source_media_get_time(source)  -- Get current position in milliseconds
        -- print(srt_camera_name .. " current position: " .. position .. " ms")
        if position ~= 0 then
            mute_source_if_not_already_muted(waiting_video_name)  -- Mute the WaitingVideo source if SRTcamera is not at 0 ms
        end
        obs.obs_source_release(source)
    else
        print("Failed to find source: " .. srt_camera_name)
    end
end

-- Timer to periodically check the media position
function script_load(settings)
    obs.timer_add(check_media_position, 1000)  -- Check every 1000 ms (1 second)
    print("Script loaded and timer started.")
end

function script_unload()
    obs.timer_remove(check_media_position)
    print("Timer stopped and script unloaded.")
end
