-- Override these with nothing, to prevent
--
-- 1. Unwanted weather updates
-- 2. Default death logic
--
function OnWorldPreUpdate() end
function OnPlayerDied( player_entity )
	GameDestroyInventoryItems( player_entity )
	GameTriggerGameOver()
end

function OnPausedChanged( is_paused, is_inventory_pause )
  -- TODO: For some reason this doesn't work. Can't kill entities just before pause?
end

-- function weather_update() end

-- function weather_init( year, month, day, hour, minute )
  -- weather = {}
  -- weather.rain_type = RAIN_TYPE_NONE
-- end
