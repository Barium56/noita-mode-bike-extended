dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

local player = EntityGetInRadiusWithTag(x, y, 15, "player_unit")
local px, py = EntityGetTransform(player[1])

if GetValueBool("collected", false) == false then
	if #player > 0 then
	  local stars = tonumber(GlobalsGetValue("star_number", "0"))
	  GlobalsSetValue("star_number", stars + 1)
	  shoot_projectile( entity_id, "data/entities/particles/gold_pickup_huge.xml", px, py, 0, 0 )
	  EntitySetComponentsWithTagEnabled(entity_id, "enabled_in_hand", true)
	  EntitySetComponentsWithTagEnabled(entity_id, "enabled_in_world", false)
	  SetValueBool("collected", true)
	  -- print("collected star")
	end
end

if GlobalsGetValue("bike_respawn_in_progress", "0") == "1" then
  EntitySetComponentsWithTagEnabled(entity_id, "enabled_in_hand", false)
  EntitySetComponentsWithTagEnabled(entity_id, "enabled_in_world", true)
  SetValueBool("collected", false)
  -- print("reset stars")
end
