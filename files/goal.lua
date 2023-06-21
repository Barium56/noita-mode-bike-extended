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

if GetValueBool("fireworks", false) == false then
	if px < x + 30 and px > x - 30 then
	  local phrases = { "Nice One!" , "Awesome!", "Excellent!", "Amazing!", "Congratulations!", "Legendary!" }
	  SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
	  GamePrintImportant(phrases[Random(1, #phrases)], "You reached a Checkpoint")
	  GlobalsSetValue("bike_respawn_x", x)
	  GlobalsSetValue("bike_respawn_y", y)

	  SetValueBool("fireworks", true)
	end
end

if GetValueBool("fireworks", false) == true then
	local number = GetValueNumber("number", 0)
	if GameGetFrameNum() % 30 == 0 then
		local colors = { "green" , "blue", "pink", "orange" }
		SetRandomSeed(GameGetFrameNum(), GameGetFrameNum())
		shoot_projectile(0, "data/entities/projectiles/deck/fireworks/firework_" .. colors[Random(1, #colors)] .. ".xml", x, y - 20, Random(-30, 30), Random(-20, -150))
		  
		SetValueNumber("number", number + 1)
	end
	if number >= 10 then
		EntityKill(entity_id)
	end
end
