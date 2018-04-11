require ('SubmenuScripts')
require ('SubmenuDraw')

function drawMenu()
	if Menu then
		if Menu.Cred then
			love.graphics.draw(CredImg, 0, 0)
		else
			love.graphics.draw(MenuImg[Menu.Submenu], 0, 0)
			if Menu.Submenu == 0 then
				mainMenuDraw()
			elseif Menu.Submenu == 1 then
				FileSelectDraw()
			elseif Menu.Submenu == 2 then
				CharacterCreateDraw()
			elseif Menu.Submenu == 3 then
				OptionsDraw()
			end
		end
	end
end

function menuUpdate(dt)
	if Menu.Cred and KeyList[1] ~= "" then
		Menu = SetupMenu(3)
		MyLib.KeyRefresh()
	elseif Menu.Submenu == 0 then
		mainMenuUpdate()
	elseif Menu.Submenu == 1 then
		FileSelectUpdate()
	elseif Menu.Submenu == 2 then
		CharacterCreateUpdate()
	elseif Menu.Submenu == 3 then
		OptionsMenuUpdate(dt)
	end
end

function SetupMenu(Select)
	local Select = Select or 1
	local FullScreen, _ = love.window.getFullscreen()
	return {
		Submenu = 0, 
		SelectMenu = Select, 
		Cred = false,
		Erasing_File = false,
		TypingName = false,
		MasterV = 100*love.audio.getVolume(),
		VControl = true,
		FullScreen = FullScreen,
		Changing = nil,
	}
end
