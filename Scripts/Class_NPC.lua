NPC = Utils.inheritsFrom( CharacterClass )
NPC.__index = NPC
SceneNPCs = {}

local Behaviors = love.filesystem.load( 'Scripts/Class_NPCBehaviors.lua' )()

function NPC.create(Pxgrid, Pygrid, behavior, MapNo)
	local npc = {}
	
	npc = {
		Name = "Rose Lalonde",
		characterId = '0',
		Mood = 1,
		
		Px = Pxgrid*40-40, 
		Py = Pygrid*40-40, 
		Pxgrid = Pxgrid, 
		Pygrid = Pygrid,
		Speed = 5,
		Facing = 1,
		
		hair = 2,
		clothesBot = 1,
		face = 1,
		clothesTop = 1,
		
		Behavior = behavior,
		OverMove = "none",
		Timer = 0,
		TimerLimit = math.random()*5,
		Locked = false,
		
		CharSpt = {}, 
	}
	
	SceneNPCs[MapNo][npc.characterId] = npc
	Map.CharacterPos[Pygrid + 1][Pxgrid] = npc
	
	setmetatable(npc,NPC)
	
	npc:loadSprites()
		
	return npc
end

function NPC:BehaviorCall(dt)
	Behaviors[self.Behavior](self, dt)
end

function ClearNPCs(MapNo)
	SceneNPCs[MapNo] = {}
end