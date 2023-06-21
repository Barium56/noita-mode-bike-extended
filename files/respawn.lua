dofile_once("data/scripts/lib/utilities.lua")

function respawn()

	local entity_id = GetUpdatedEntityID()
	print(entity_id)
	local x, y, rot = EntityGetTransform(entity_id)

	function add_wheels(entity)

		EntityAddComponent2(entity, "PhysicsBody2Component", {
			allow_sleep=true ,
			linear_damping=0.1 ,
			hax_wait_till_pixel_scenes_loaded=true,
			angular_damping=0.5,
			kill_entity_after_initialized=false
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
			break_force=20,
			body1_id=1,
			body2_id=3,
			offset_x=5,
			offset_y=1
		})
		
		EntityAddComponent2(entity, "PhysicsJoint2Component", {
			type="REVOLUTE_JOINT",
			break_force=20,
			body1_id=1,
			body2_id=2,
			offset_x=-7,
			offset_y=1
		})
	end

	EntityApplyTransform(entity_id, -962, - 71, 0)

	--add cape
	local cape_entity = EntityLoad("mods/bike/files/cape.xml", x, y)
	EntityAddChild(entity_id, cape_entity)

	--disable sprite
	local sprite_component = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
	EntitySetComponentIsEnabled( entity_id, sprite_component, true )

	add_wheels(entity_id)
	
	GlobalsSetValue("bike_respawn_in_progress", "0")

end