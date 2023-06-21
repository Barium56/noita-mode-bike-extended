dofile_once("data/scripts/lib/utilities.lua")

function get_player()
  local players = get_players()
  if players ~= nil then
    return players[1]
  end

  -- TODO: What does this mean anyway? Player is dead..?
  return nil
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
  
local player = get_player()
local px, py = EntityGetTransform(player)

if px < x + 30 and px > x - 30 then
  local phrases = { "You Made It! Congratulations!"  }
  GamePrintImportant(phrases[Random(1, #phrases)], "You have mastered this Jank Noita Bike!")
  GlobalsSetValue("bike_ending", "1")
  GameAddFlagRun("ending_game_completed")
  GameOnCompleted()
  EntityKill(entity_id)
end