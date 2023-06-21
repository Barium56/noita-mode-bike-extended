dofile_once("data/scripts/lib/utilities.lua")

function get_player()
  local players = get_players()
  if players ~= nil then
    return players[1]
  end

  -- TODO: What does this mean anyway? Player is dead..?
  return nil
end

function remove_wheels(entity)
  local removable_components = {
	"PhysicsJointComponent", "PhysicsJoint2Component", "PhysicsImageShapeComponent", "PhysicsBody2Component"
  }
  for i, comp_name in pairs(removable_components) do
	local comps = EntityGetComponentIncludingDisabled(entity, comp_name)

	for i, comp in ipairs(comps or {}) do
	  EntityRemoveComponent(entity, comp)
	end
  end
end

--Close Wand Edit GUI
local entity_id = get_player()
local inventory_gui_component = EntityGetFirstComponentIncludingDisabled(entity_id, "InventoryGuiComponent")
ComponentSetValue2(inventory_gui_component, "mActive", false)

function fake_death()

	local entity_id = get_player()
	local x, y, rot = EntityGetTransform(entity_id)

	if GlobalsGetValue("bike_ending", "0") == "0" then

	  GlobalsSetValue("bike_respawn_in_progress", "1")
	  GlobalsSetValue("star_number", 0)
	  
	  -- EntityInflictDamage(entity_id, 999, "DAMAGE_PHYSICS_HIT", "Motor Vehicle Accident", "NORMAL", 0, 0)
	  remove_wheels(entity_id)
	  
	  --remove cape
	  local cape_entity = EntityGetWithName("cape")
	  EntityKill(cape_entity)
	  
	  --disable sprite
	  local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
	  EntitySetComponentIsEnabled( entity_id, sprite_component, false )
	  
	  EntitySetComponentsWithTagEnabled(entity_id, "controls", false)
	  
	  GamePlaySound("data/audio/Desktop/animals.bank", "animals/damage/physics_hit", x, y)
	  
	  local player_vel_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
	  local corpse_spawner = EntityLoad("mods/bike/files/corpse.xml", x, y)
	  EntitySetTransform(corpse_spawner, x, y, rot)
	  
	  SetTimeOut(4, "mods/bike/files/head_checker.lua", "clear")
	  
	  SetTimeOut(5, "mods/bike/files/head_checker.lua", "respawn")
	else
	
		EntityLoad("mods/bike/files/explosion.xml", x, y)
		EntityLoad("data/entities/projectiles/deck/all_spells_loader.xml", x, y)
	end
  
end

if GlobalsGetValue("bike_respawn_in_progress", "0") == "0" then

	local entity_id = get_player()
	local x, y, rot = EntityGetTransform(entity_id)

	local nx = math.cos(rot - math.rad(90))
	local ny = math.sin(rot - math.rad(90))

	local did_hit, hit_x, hit_y = RaytraceSurfaces(x + nx * 14, y + ny * 14, x + nx * 14, y + ny * 14)

	if did_hit then

		fake_death()

		  -- EntityApplyTransform(entity_id, x, y - 50, 0)
		  -- add_wheels(entity_id)

	end

end

function damage_received(damage, message, entity_thats_responsible, is_fatal)
  if is_fatal and GlobalsGetValue("bike_ending", "0") == "0" then
	local entity_id = GetUpdatedEntityID()
	local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "DamageModelComponent" )
	if ( comp ~= nil ) then
		local max_hp = ComponentGetValue2( comp, "max_hp" )
		ComponentSetValue2( comp, "hp", max_hp )
	end
	if GlobalsGetValue("bike_respawn_in_progress", "0") == "0" then
		fake_death()
	end
  end
end

function clear()

	local entity_id = get_player()
	local x, y, rot = EntityGetTransform(entity_id)

	EntityLoad("mods/bike/files/clear_bike.xml", x, y)

end

function respawn()

	local respawn_x = tonumber(GlobalsGetValue("bike_respawn_x", "-962"))
    local respawn_y = tonumber(GlobalsGetValue("bike_respawn_y", "-31"))

	local entity_id = get_player()
	local x, y, rot = EntityGetTransform(entity_id)
	
	local eater = EntityGetInRadiusWithTag(x, y, 999999, "matter_eater")
	EntityKill(eater)

	function add_wheels(entity)

		EntityAddComponent2(entity, "PhysicsBody2Component", {
			allow_sleep=true ,
			linear_damping=0.1 ,
			hax_wait_till_pixel_scenes_loaded=true,
			angular_damping=0.5,
			kill_entity_after_initialized=false,
			kill_entity_if_body_destroyed=false
		})

		EntityAddComponent2(entity, "PhysicsImageShapeComponent", {
			body_id=1,
			centered=true,
			is_root=true,
			image_file="mods/bike/files/bike.png",
			material=CellFactory_GetType("tire_rubber")
		})

		EntityAddComponent2(entity, "PhysicsImageShapeComponent", {
			body_id=2,
			centered=true,
			is_circle=true,
			image_file="mods/bike/files/wheel_left.png",
			z=-1,
			material=CellFactory_GetType("tire_rubber")
		})
		
		EntityAddComponent2(entity, "PhysicsImageShapeComponent", {
			body_id=3,
			centered=true,
			is_circle=true,
			image_file="mods/bike/files/wheel_right.png",
			z=-1,
			material=CellFactory_GetType("tire_rubber")
		})
		
		EntityAddComponent2(entity, "PhysicsJoint2Component", {
			type="REVOLUTE_JOINT",
			break_force=40,
			body1_id=1,
			body2_id=3,
			offset_x=5,
			offset_y=1
		})
		
		EntityAddComponent2(entity, "PhysicsJoint2Component", {
			type="REVOLUTE_JOINT",
			break_force=40,
			body1_id=1,
			body2_id=2,
			offset_x=-7,
			offset_y=1
		})
	end

	EntityApplyTransform(entity_id, respawn_x, respawn_y, 0)
	
	--full heal
	local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "DamageModelComponent" )
	if ( comp ~= nil ) then
		local max_hp = ComponentGetValue2( comp, "max_hp" )
		ComponentSetValue2( comp, "hp", max_hp )
	end

	--add cape
	local cape_entity = EntityLoad("mods/bike/files/cape.xml", x, y)
	EntityAddChild(entity_id, cape_entity)

	--disable sprite
	local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
	EntitySetComponentIsEnabled( entity_id, sprite_component, true )

	add_wheels(entity_id)
	
	EntitySetComponentsWithTagEnabled(entity_id, "controls", true)
	
	GlobalsSetValue("bike_respawn_in_progress", "0")

end