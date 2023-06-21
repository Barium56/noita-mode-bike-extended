dofile_once("data/scripts/lib/utilities.lua")

function physics_body_modified( is_destroyed )
	if GlobalsGetValue("bike_respawn_in_progress", "0") == "0" then
	  SetTimeOut(0, "mods/bike/files/head_checker.lua", "fake_death")
	end
end