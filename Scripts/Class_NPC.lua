NPC = Utils.inheritsFrom( Character )
NPC.__index = NPC

local Behaviors = love.filesystem.load( 'Scripts/NPCBehaviors.lua' )()

function NPC.create(charArgs)
	local npc = {
		name = charArgs.name,
		Id = charArgs.Id,
		Mood = charArgs.mood or 1,
		
		Pxgrid = charArgs.Px, 
		Pygrid = charArgs.Py,
		Px = charArgs.Px*40-40, 
		Py = charArgs.Py*40-40, 
		Speed = 5,
		Facing = 1,
		
		looks = {
			Hair = charArgs.looks.Hair,
			CBot = charArgs.looks.CBot,
			Face = charArgs.looks.Face,
			CTop = charArgs.looks.CTop,
		},
		
		behavior = charArgs.Behavior or 0,
		OverMove = "none",
		Timer = 0,
		TimerLimit = math.random()*5,
		Locked = false,
		
		CharSpt = {},
	}
	
	local map = MapClass.get_active()
	
	GameController.world.area.NPCs[map.id][npc.Id] = npc
	map.char_grid[npc.Pygrid + 1][npc.Pxgrid] = npc
	
	setmetatable(npc,NPC)
	
	npc:loadSprites()

	return npc
end

function NPC:BehaviorCall(dt)
	-- if not self.Path then
		-- Behaviors[self.Behavior](self, dt)
	-- end
end

function NPC.createRandom(Pxgrid, Pygrid, behavior)
	local npc = {
		name = "Rose Lalonde",
		Id = '0',
		Mood = 1,
		
		Px = Pxgrid, 
		Py = Pygrid,
		
		looks = {
			Hair = 2,
			CBot = 1,
			Face = 1,
			CTop = 1,
		},
		behavior = behavior,
	}
		
	return NPC.create(npc)
end