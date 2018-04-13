function CanMove(coordinates)
	Position = Map[coordinates.y][coordinates.x]
	
	if hasCharacter(coordinates) then return false end
	
	return Position=="0" or Position:find("W") ~= nil or Position:find("E") ~= nil
end

function CanNPCMove(coordinates)
	Position = Map[coordinates.y][coordinates.x]
	
	if hasCharacter(coordinates) then return false end
	
	return Position=="0" or Position:find("W") ~= nil
end

function hasCharacter(coordinates)
	return Map.CharacterPos[coordinates.y][coordinates.x] ~= nil
end

function getEvent(coordinates)
	return Map.Events[coordinates.x.."-"..coordinates.y]
end

function lockEvent(coordinates)
	local EventId = Map.Events[coordinates.x.."-"..coordinates.y].id
	Map.Events[coordinates.x.."-"..coordinates.y] = nil
	for key, event in pairs(Map.Events) do
		if event.id == EventId then Map.Events[key] = nil end
	end
end

function GetCharacterById(id)
	if SceneNPCs[Map.Number][id] then
		return SceneNPCs[Map.Number][id]
	end
	return nil
end
