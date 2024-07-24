-- Function to remove specific substrings
function removeSubstrings(str, substrings)
    for _, substring in ipairs(substrings) do
        str = string.gsub(str, substring, "")
    end
    return str
end

-- Get the number of selected items
local num_items = reaper.CountSelectedMediaItems(0)

-- Iterate over all selected media items
for i = 0, num_items - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local take = reaper.GetActiveTake(item)
    if take then
        local take_name = reaper.GetTakeName(take)
        local new_name = removeSubstrings(take_name, { "%.wav", "%.WAV" })
        reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", new_name, true)
    end
end

-- Update the arrange view and undo history
reaper.UpdateArrange()
reaper.Undo_OnStateChange("Remove .wav and .WAV from selected items")
