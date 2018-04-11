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
	FileText = FileText .. "gold = 0,\n"
	FileText = FileText .. "xp = 0,\n"
	FileText = FileText .. "level = 1,\n"
	FileText = FileText .. "Name = '"..SavingChar.Name.."',\n"
	FileText = FileText .. "hair = "..SavingChar.hair..",\n"
	FileText = FileText .. "face = "..SavingChar.face..",\n"
	FileText = FileText .. "clothesTop = "..SavingChar.clothesTop..",\n"
	FileText = FileText .. "clothesBot = "..SavingChar.clothesBot..",\n"
	FileText = FileText .. "Inventory = "..Utils.table_to_string(SavingChar.Inventory)..",\n"
	FileText = FileText .. "MetaData = "..Utils.table_to_string(MetaData)..",\n"
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
	local FullScreen, _ = love.window.getFullscreen()
	local FileText = ""
	FileText = FileText .. "return{\n"
	FileText = FileText .. "FullScreen = "..tostring(FullScreen)..",\n"
	FileText = FileText .. "MasterV = "..tostring(love.audio.getVolume()*100)..",\n"
	FileText = FileText .. "}"
	
	love.filesystem.write("Userdata.lua", FileText)
end

function LoadUserData()
	local UserData = nil
	if (love.filesystem.exists("Userdata.lua")) then
		UserData = love.filesystem.load("Userdata.lua")()
	else
		UserData = {
			FullScreen = false,
			MasterV = 100,
		}
	end
	
	love.window.setFullscreen(UserData.FullScreen)
	love.audio.setVolume(UserData.MasterV/100)
end
