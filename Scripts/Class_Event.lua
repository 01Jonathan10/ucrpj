EventClass = {}
EventClass.__index = EventClass

function EventClass.create(event)	
	setmetatable(event,EventClass)
	return event
end

function EventClass:beginEvent()
	SaveCharacter(Player)
	local newEvent = type(Map.EventQueue) == "nil"
	Map.EventQueue = Map.EventQueue or {}
	for _, eachEvent in ipairs(self.queue) do table.insert(Map.EventQueue, eachEvent) end
	if newEvent then EventClass.triggerEvent() end
	if self.single then Player.ClearedEvents[self.id] = true end
end

function EventClass.triggerEvent()
	if Map.EventQueue then
		if table.getn(Map.EventQueue) == 0 then Map.EventQueue = nil lockGMenu = false return end
		
		lockGMenu = true
		event = Map.EventQueue[1]
		table.remove(Map.EventQueue, 1)
		event()
	end
end

function EventClass.lockEvent(coordinates)
	local EventId = Map.Events[coordinates.x.."-"..coordinates.y].id
	Map.Events[coordinates.x.."-"..coordinates.y] = nil
	for key, event in pairs(Map.Events) do
		if event.id == EventId then Map.Events[key] = nil end
	end
end

function EventClass.getEvent(coordinates)
	return Map.Events[coordinates.x.."-"..coordinates.y]
end