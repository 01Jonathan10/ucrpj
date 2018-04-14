MenuClass = {}
MenuClass.__index = MenuClass
Menu = {}

require ('SubmenuScripts')
require ('SubmenuDraw')

function MenuClass.BuildMenu()
	Menu = {
		Submenu = 0, 
		SelectMenu = 1, 
		Cred = false,
		Erasing_File = false,
		TypingName = false,
		MasterV = 100*love.audio.getVolume(),
		VControl = true,
		Changing = nil,
		CharImg = {Hair = {}, CTop = {}, CBot = {}, Face = {}},
		LoadQueue = 0,
	}
	
	setmetatable(Menu,MenuClass)
	Menu:LoadImgs()
end


function MenuClass:LoadImgs()
	self.Imgs = {
		Selecao = love.graphics.newImage('Graphics/Misc/Selecao.png'),
		CredImg = love.graphics.newImage('Graphics/Misc/Credits.png'),
	}
		
	local i = 0
	while love.filesystem.exists('Graphics/Misc/Menu '..i..'.png') do
		self.Imgs[i] = love.graphics.newImage('Graphics/Misc/Menu '..i..'.png')
		i = i + 1
	end
end


function MenuClass:LoadFromQueue()
	local id = math.floor(Menu.LoadQueue/4) + 1
	local iter = Menu.LoadQueue % 4 + 1
	
	Menu.LoadQueue = Menu.LoadQueue + 1
	
	if iter == 1 and love.filesystem.exists('Graphics/Chars/Hair/Hair_'..id..'_F.png') then
		Menu.CharImg.Hair[id] = {}
		Menu.CharImg.Hair[id][0] = love.graphics.newImage('Graphics/Chars/Hair/Hair_'..id..'_F.png')
		Menu.CharImg.Hair[id][1] = love.graphics.newImage('Graphics/Chars/Hair/Hair_'..id..'_B.png')
	elseif iter == 2 and love.filesystem.exists('Graphics/Chars/CTop/CTop_'..id..'.png') then
		Menu.CharImg.CTop[id] = love.graphics.newImage('Graphics/Chars/CTop/CTop_'..id..'.png')
	elseif iter == 3 and love.filesystem.exists('Graphics/Chars/CBot/CBot_'..id..'.png') then
		Menu.CharImg.CBot[id] = love.graphics.newImage('Graphics/Chars/CBot/CBot_'..id..'.png')
	elseif iter == 4 and love.filesystem.exists('Graphics/Chars/Face/Face_'..id..'.png') then
		Menu.CharImg.Face[id] = love.graphics.newImage('Graphics/Chars/Face/Face_'..id..'.png')
	else
		Menu.LoadQueue = nil
	end
end

function MenuClass:SetupMenu(Select)
	local Select = Select or 1
	self.SelectMenu = Select
	self.Erasing_File = false
	self.TypingName = false
	self.MasterV = 100*love.audio.getVolume()
	self.Cred = false
end

function MenuClass:drawMenu()
	if self.Cred then
		love.graphics.draw(self.Imgs.CredImg, 0, 0)
	else
		love.graphics.draw(self.Imgs[self.Submenu], 0, 0)
		if self.Submenu == 0 then
			mainMenuDraw()
		elseif self.Submenu == 1 then
			FileSelectDraw()
		elseif self.Submenu == 2 then
			CharacterCreateDraw()
		elseif self.Submenu == 3 then
			OptionsDraw()
		end
	end
end

function MenuClass:menuUpdate(dt)
	if self.Cred and KeyList[1] ~= "" then
		self:SetupMenu(3)
		MyLib.KeyRefresh()
	elseif self.Submenu == 0 then
		mainMenuUpdate()
	elseif self.Submenu == 1 then
		FileSelectUpdate()
	elseif self.Submenu == 2 then
		CharacterCreateUpdate()
	elseif self.Submenu == 3 then
		OptionsMenuUpdate(dt)
	end
end
