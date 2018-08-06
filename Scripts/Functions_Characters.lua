function CanMove(coordinates)
	Position = Map[coordinates.y][coordinates.x]
	
	return CanNPCMove(coordinates) or Position:find("E") ~= nil
end

function CanNPCMove(coordinates)
	Position = Map[coordinates.y][coordinates.x]
	
	if hasCharacter(coordinates) then return false end
	
	return Position=="0" or Position:find("W") ~= nil
end

function hasCharacter(coordinates)
	return Map.char_grid[coordinates.y][coordinates.x] ~= nil
end

function GetCharacterById(id)
	if GameController.world.area.NPCs[Map.id][id] then
		return GameController.world.area.NPCs[Map.id][id]
	end
	return nil
end
