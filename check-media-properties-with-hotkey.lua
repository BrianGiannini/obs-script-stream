obs = obslua

-- Name of the media source
media_source_name = "SRTcamera"  -- Change this to the name of your media source


-- Function to print extended media source properties
function print_extended_media_properties()
    local source = obs.obs_get_source_by_name(media_source_name)
    if source then
        local settings = obs.obs_source_get_settings(source)
        local local_file = obs.obs_data_get_string(settings, "local_file")
        local looping = obs.obs_data_get_bool(settings, "looping")
        local media_state = obs.obs_source_media_get_state(source)
        local media_duration = obs.obs_source_media_get_duration(source)
        local media_position = obs.obs_source_media_get_time(source)

        -- Media state conversion to readable format
        local state_string = "Unknown"
        if media_state == obs.OBS_MEDIA_STATE_PLAYING then
            state_string = "Playing"
        elseif media_state == obs.OBS_MEDIA_STATE_PAUSED then
            state_string = "Paused"
        elseif media_state == obs.OBS_MEDIA_STATE_STOPPED then
            state_string = "Stopped"
        elseif media_state == obs.OBS_MEDIA_STATE_ENDED then
            state_string = "Ended"
        end

        -- Print properties to the OBS log
        print("Extended Media Source Properties:")
        print("File Path: " .. local_file)
        print("Looping: " .. tostring(looping))
        print("State: " .. state_string)
        print("Duration: " .. media_duration .. " ms")
        print("Current Position: " .. media_position .. " ms")
        
        -- Release resources
        obs.obs_data_release(settings)
        obs.obs_source_release(source)
    else
        print("Media source not found.")
    end
end

-- Register function to a hotkey
hotkey_id = obs.OBS_INVALID_HOTKEY_ID

function on_hotkey_pressed(pressed)
    if pressed then
        print_extended_media_properties()
    end
end

function script_load(settings)
    hotkey_id = obs.obs_hotkey_register_frontend("print_media_properties_hotkey", "Print Extended Media Properties", on_hotkey_pressed)
    local hotkey_save_array = obs.obs_data_get_array(settings, "print_media_properties_hotkey")
    obs.obs_hotkey_load(hotkey_id, hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end

function script_save(settings)
    local hotkey_save_array = obs.obs_hotkey_save(hotkey_id)
    obs.obs_data_set_array(settings, "print_media_properties_hotkey", hotkey_save_array)
    obs.obs_data_array_release(hotkey_save_array)
end