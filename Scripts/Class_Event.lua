EventClass = {}
EventClass.__index = EventClass

function EventClass.create(event)	
	setmetatable(event,EventClass)
	return event
end

function EventClass:beginEvent()
	local newEvent = type(Map.EventQueue) == "nil"
	Map.EventQueue = Map.EventQueue or {}
	for _, eachEvent in ipairs(self.queue) do table.insert(Map.EventQueue, eachEvent) end
	if newEvent then EventClass.triggerEvent() end
	if self.single then GameController.player.ClearedEvents[self.id] = true end
end

function EventClass.triggerEvent()
	if Map.EventQueue then
		GameController.world.state = Constants.EnumWorldState.EVENT
		
		if table.getn(Map.EventQueue) == 0 then 
			Map.EventQueue = nil 
			DataManager.save(GameController.player)
			GameController.world.state = Constants.EnumWorldState.ROAMING
			return 
		end
		
		event = Map.EventQueue[1]
		table.remove(Map.EventQueue, 1)
		event()
	end
end

function EventClass.lockEvent(coordinates)
	local EventId = Map.events[coordinates.x.."-"..coordinates.y].id
	Map.events[coordinates.x.."-"..coordinates.y] = nil
	for key, event in pairs(Map.events) do
		if event.id == EventId then Map.events[key] = nil end
	end
end

function EventClass.getEvent(coordinates)
	return Map.events[coordinates.x.."-"..coordinates.y]
end