-- default biome functions that get called if we can't find a a specific biome that works for us
CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biomes/mountain/mountain.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffC4189B, "spawn_trees" )
RegisterSpawnFunction( 0xffC41820, "spawn_big_bushes" )
RegisterSpawnFunction( 0xffC41860, "spawn_vines" )
RegisterSpawnFunction( 0xffc4186a, "spawn_wasd" )
RegisterSpawnFunction( 0xffc45f7b, "spawn_wasd_trigger" )
RegisterSpawnFunction( 0xffc4186b, "spawn_mouse" )
RegisterSpawnFunction( 0xffc4187b, "spawn_mouse_trigger" )
RegisterSpawnFunction( 0xffc4187c, "spawn_grass" )
RegisterSpawnFunction( 0xffff5a0f, "spawn_music_trigger" )
RegisterSpawnFunction( 0xff80FF5A, "spawn_vines_b" )
RegisterSpawnFunction( 0xff3c8ca6, "spawn_goal" )
RegisterSpawnFunction( 0xff3c8786, "spawn_goal2" )
RegisterSpawnFunction( 0xff3c4886, "spawn_goal3" )
RegisterSpawnFunction( 0xff34f73e, "spawn_goal_end" )
RegisterSpawnFunction( 0xff3c8123, "spawn_star" )

function spawn_wands( x, y ) end

g_trees =
{
	total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/tree_spruce_1.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/tree_spruce_2.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/tree_spruce_3.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/tree_spruce_4.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/tree_spruce_5.xml"
	},
}

g_big_bushes =
{
	total_prob = 0,
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/plant_bush_big_1.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/plant_bush_big_2.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/plant_bush_big_3.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/plant_bush_big_4.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/plant_bush_big_5.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/vegetation/plant_bush_1.xml"
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,		
		entity 	= "data/entities/vegetation/plant_bush_2.xml"
	},
}

g_vines =
{
	total_prob = 0,
	{
		prob   		= 0.4,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine.xml"
	},
	{
		prob   		= 0.3,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_long.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_short.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/verlet_chains/vines/verlet_vine_shorter.xml"
	},
}

g_props =
{
	total_prob = 0,
	{
		prob   		= 0.2,
		min_count	= 0,
		max_count	= 0,
		offset_y 	= 0,    
		entity 	= ""
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_01.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_02.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_03.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_04.xml"
	},
}

function init( x, y, w, h )
  -- print(math.floor(x / 512))
  local load_what = math.floor(x / 512) + 3
  for _y=1,2 do
    for _x=1,2 do
      local x_coord = x + (256 * (_x-1))
      local y_coord = y + (256 * (_y-1))
      LoadPixelScene("mods/bike/files/track_" .. (load_what*2-(2-_x)) .. "_" .. _y .. ".png", "", x_coord, y_coord, "", true)
      print("Loading: " .. "mods/bike/files/track_" .. (load_what*2-(2-_x)) .. "_" .. _y .. ".png at " .. x_coord .. ", " .. y_coord)
    end
  end
end

function spawn_trees( x, y )
	spawn( g_trees, x, y+28, 0, 0 )
end

function spawn_big_bushes( x, y )
	spawn( g_big_bushes, x, y+12, 0, 0 )
end

function spawn_vines( x, y )
	spawn( g_vines, x, y )
end

function spawn_vines_b(x, y)
	spawn(g_vines,x,y)
end

function spawn_wasd( x, y )
	if (GameGetIsGamepadConnected() == false) then
		EntityLoad( "data/entities/particles/image_emitters/controls_wasd.xml", x, y )
	else
		EntityLoad( "data/entities/particles/image_emitters/controls_stick.xml", x-1, y-1 )
	end
end

function spawn_mouse( x, y )
	if (GameGetIsGamepadConnected() == false) then
		EntityLoad( "data/entities/particles/image_emitters/controls_mouse.xml", x, y )
	else
		EntityLoad( "data/entities/particles/image_emitters/controls_lt.xml", x, y-2 )
	end
end

function spawn_wasd_trigger( x, y )
	if ( GameIsIntroPlaying() == false ) then 
		EntityLoad( "data/entities/buildings/controls_wasd_trigger.xml", x, y )
	end
end

function spawn_mouse_trigger( x, y )
	EntityLoad( "data/entities/buildings/controls_mouse_trigger.xml", x, y )
end

function spawn_grass( x, y )
	EntityLoad( "data/entities/props/mountain_left_entrance_grass.xml", x, y )
end

function spawn_potions( x, y ) end

function spawn_music_trigger( x, y )
	EntityLoad( "data/entities/buildings/music_trigger_mountain_left_entrance.xml", x, y )
end

function spawn_props(x, y)
	spawn(g_props,x,y,0,0)
end

function spawn_goal(x, y)
	EntityLoad("mods/bike/files/goal.xml", x, y )
end

function spawn_goal2(x, y)
	EntityLoad("mods/bike/files/goal2.xml", x, y )
end

function spawn_goal3(x, y)
	EntityLoad("mods/bike/files/goal3.xml", x, y )
end

function spawn_goal_end(x, y)
	EntityLoad("mods/bike/files/goal_end.xml", x, y )
end

function spawn_star(x, y)
	EntityLoad("mods/bike/files/star.xml", x, y )
end
