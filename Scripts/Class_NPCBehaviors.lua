local NPCBehaviors = {}

NPCBehaviors[1] = function(NPC, dt)
	if not NPC.Locked then
		
		NPC.Timer = NPC.Timer + dt
		if NPC.Timer > NPC.TimerLimit then
			NPC.Timer = 0
			NPC.TimerLimit = 10
			NPC:MoveRandomSquare()
		end
	
	end
end

return NPCBehaviors