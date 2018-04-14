NPC = Utils.inheritsFrom( CharacterClass )
NPC.__index = NPC
SceneNPCs = {}

local Behaviors = love.filesystem.load( 'Scripts/NPCBehaviors.lua' )()

function NPC.create(charArgs, MapNo)
	local npc = {
		Name = charArgs.Name,
		Id = charArgs.Id,
		Mood = charArgs.mood or 1,
		
		Pxgrid = charArgs.Px, 
		Pygrid = charArgs.Py,
		Px = charArgs.Px*40-40, 
		Py = charArgs.Py*40-40, 
		Speed = 5,
		Facing = 1,
		
		Hair = charArgs.Hair,
		CBot = charArgs.CBot,
		Face = charArgs.Face,
		CTop = charArgs.CTop,
		
		Behavior = charArgs.Behavior or 0,
		OverMove = "none",
		Timer = 0,
		TimerLimit = math.random()*5,
		Locked = false,
		
		CharSpt = {}, 
	}
	
	SceneNPCs[MapNo or Map.Number][npc.Id] = npc
	Map.CharacterPos[npc.Pygrid + 1][npc.Pxgrid] = npc
	
	setmetatable(npc,NPC)
	
	npc:loadSprites()
		
	return npc
end

function NPC:BehaviorCall(dt)
	if not self.Path then
		Behaviors[self.Behavior](self, dt)
	end
end

function ClearNPCs(MapNo)
	SceneNPCs[MapNo] = {}
end

function NPC.createRandom(Pxgrid, Pygrid, behavior, MapNo)
	local npc = {
		Name = "Rose Lalonde",
		Id = '0',
		Mood = 1,
		
		Px = Pxgrid, 
		Py = Pygrid,
		
		Hair = 2,
		CBot = 1,
		Face = 1,
		CTop = 1,
		
		Behavior = behavior,
	}
		
	return NPC.create(npc, MapNo)
end