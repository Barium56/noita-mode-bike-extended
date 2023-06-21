dofile_once("data/scripts/lib/utilities.lua")

ModMagicNumbersFileAdd("mods/bike/files/magic_numbers.xml")
ModMaterialsFileAdd("mods/bike/files/materials.xml")

--set ground not to spawn moss strength
local nxml = dofile_once("mods/bike/lib/nxml.lua")
local content = ModTextFileGetContent("data/materials.xml")
local xml = nxml.parse(content)
for element in xml:each_child() do
  if element.attr.name == "rock_hard" then
    element.attr._inherit_reactions = 0
  end
end
ModTextFileSetContent("data/materials.xml", tostring(xml))

-- ModLuaFileAppend("data/scripts/init.lua", "mods/bike/files/init_append.lua")

function OnPlayerSpawned(player_id)
end

function OnWorldPreUpdate()
	local world_state_entity = GameGetWorldStateEntity()
	edit_component( world_state_entity, "WorldStateComponent", function(comp,vars)
		vars.time = 0
		vars.time_dt = 0
		vars.fog = 0
		vars.fog_target = 0
		vars.fog_target_extra = 0
		vars.rain = 0
		vars.rain_target = 0
		vars.rain_target_extra = 0
		vars.intro_weather = 1
		vars.open_fog_of_war_everywhere = 1
	end)

    --Adding gui to force death
    local id = 2
    local function new_id()
      id = id + 1
      return id
    end
	
    gui = gui or GuiCreate()
    GuiStartFrame(gui)
	GuiLayoutBeginVertical(gui, 90, 2)
	
    if GuiButton(gui, new_id(), 0, 0, "Reset") then
		if GlobalsGetValue("bike_respawn_in_progress", "0") == "0" then
		  SetTimeOut(0, "mods/bike/files/head_checker.lua", "fake_death")
		end
    end
    GuiLayoutEnd(gui)
end

function OnPlayerDied(player)
end

function OnPausedChanged( is_paused, is_inventory_pause )
end