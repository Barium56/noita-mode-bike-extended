function clear()

	local entity_id = GetUpdatedEntityID()
	print(entity_id)
	local x, y, rot = EntityGetTransform(entity_id)

	EntityLoad("mods/bike/files/clear_bike.xml", x, y)

end