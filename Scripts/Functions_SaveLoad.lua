function SaveCharacter(SavingChar)
	local MetaData = {}
	
	if Map then
		MetaData = {
			Number = Map.Number,
			Px = SavingChar.Pxgrid,
			Py = SavingChar.Pygrid,
		}
	end
	
	MetaData.ItemsGot = SavingChar.MetaData.ItemsGot
	
	local FileText = ""
	FileText = FileText .. "return{\n"
	FileText = FileText .. "gold = "..SavingChar.gold..",\n"
	FileText = FileText .. "xp = "..SavingChar.xp..",\n"
	FileText = FileText .. "level = "..SavingChar.level..",\n"
	FileText = FileText .. "Name = '"..SavingChar.Name.."',\n"
	FileText = FileText .. "Hair = "..SavingChar.Hair..",\n"
	FileText = FileText .. "Face = "..SavingChar.Face..",\n"
	FileText = FileText .. "CTop = "..SavingChar.CTop..",\n"
	FileText = FileText .. "CBot = "..SavingChar.CBot..",\n"
	FileText = FileText .. "Inventory = "..Utils.table_to_string(SavingChar.Inventory)..",\n"
	FileText = FileText .. "MetaData = "..Utils.table_to_string(MetaData)..",\n"
	FileText = FileText .. "ClearedEvents = "..Utils.table_to_string(SavingChar.ClearedEvents)..",\n"
	FileText = FileText .. "SeenDialogs = "..Utils.table_to_string(SavingChar.SeenDialogs)..",\n"
	FileText = FileText .. "}"
	
	love.filesystem.write("Save00"..SavingChar.SaveSlot..".lua", FileText)
	
	loadSaveFiles()
end

function loadSaveFiles()

	LoadedChars = {}

	for i=1,3 do
	
		LoadedChars[i] = false
		if (love.filesystem.exists("Save00"..i..".lua")) then
			LoadedChars[i] = love.filesystem.load("Save00"..i..".lua")()
			LoadedChars[i].SaveSlot = i
		end
		
	end
end

function SaveUserData()
	local _,_,Mode = love.window.getMode()
	local FileText = ""
	FileText = FileText .. "return{\n"
	FileText = FileText .. "MasterV = "..tostring(love.audio.getVolume()*100)..",\n"
	FileText = FileText .. "Scale = 1.5,\n"
	FileText = FileText .. "FullScreen = "..tostring(Mode.fullscreen)..",\n"
	FileText = FileText .. "}"
	
	love.filesystem.write("Userdata.lua", FileText)
end

function LoadUserData()
	local UserData = nil
	if (love.filesystem.exists("Userdata.lua")) then
		UserData = love.filesystem.load("Userdata.lua")()
	else
		UserData = {
			MasterV = 100,
			Scale = 1,
			FullScreen = true
		}
	end
	
	love.audio.setVolume(UserData.MasterV/100)
	ToggleFullScreen(UserData.FullScreen)
end
