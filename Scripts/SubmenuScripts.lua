function FadeToSubmenu(Destination)
	MyLib.FadeToColor(0.3,{"LuaCall>SetSubmenu("..Destination..",1)"},{nil},"fill",{0,0,0,255},true)
	MyLib.KeyRefresh()
end

function SetSubmenu(Destination, Select)
	Menu.SelectMenu = Select
	Menu.Submenu = Destination
end

function EscGoesTo(Destination, Select)
	if KeyList[3] then
		local Select = Select or 1
		MyLib.FadeToColor(0.3,{"LuaCall>SetSubmenu("..Destination..","..Select..")"},{nil},"fill",{0,0,0,255},true)
		MyLib.KeyRefresh()
	end
end

function mainMenuUpdate()
	if KeyList[3] then
		love.event.push('quit')
	end
	if KeyList[4] then
		if Menu.SelectMenu>1 then
			Menu.SelectMenu=Menu.SelectMenu - 1
		end
	elseif KeyList[5] then
		if Menu.SelectMenu<4 then
			Menu.SelectMenu=Menu.SelectMenu + 1
		end
	elseif KeyList[2] then
		if Menu.SelectMenu == 1 then
			FadeToSubmenu(1)
			Menu.Erasing_File = false
		elseif Menu.SelectMenu == 2 then
			FadeToSubmenu(3)
		elseif Menu.SelectMenu == 3 then
			Menu.Cred = true
			MyLib.KeyRefresh()
		elseif Menu.SelectMenu == 4 then
			love.event.push('quit')
		end
	end
end

function FileSelectUpdate()
	EscGoesTo(0)
	if KeyList[4] then
		if Menu.SelectMenu>1 then
			Menu.SelectMenu=Menu.SelectMenu - 1
		end
	elseif KeyList[5] then
		if Menu.SelectMenu<4 then
			Menu.SelectMenu=Menu.SelectMenu + 1
		end
	elseif KeyList[7] and Menu.SelectMenu==4 then
		Menu.SelectMenu = 5
	elseif KeyList[6] and Menu.SelectMenu==5 then
		Menu.SelectMenu = 4
	elseif KeyList[2] then
		if Menu.SelectMenu < 4 then
			if Menu.Erasing_File and LoadedChars[Menu.SelectMenu] then
				love.filesystem.remove("Save00"..Menu.SelectMenu..".lua")
				loadSaveFiles()
				Menu.Erasing_File = false
			elseif LoadedChars[Menu.SelectMenu] then
				Player = PlayerClass.create(nil, nil, LoadedChars[Menu.SelectMenu])
				BeginGame()
			else
				MyLib.FadeToColor(0.3,{"LuaCall>SetSubmenu(2, "..Menu.SelectMenu..")"},{nil},"fill",{0,0,0,255},true)
				MyLib.KeyRefresh()
				Menu.SelectMenuCustom = 1
				Menu.Changing = nil
				NewCharacter = PlayerClass.create(nil, nil, PlayerClass:BlankCharacter(), Menu.SelectMenu)
			end
		elseif Menu.SelectMenu == 4 then
			FadeToSubmenu(0)
		elseif Menu.SelectMenu == 5 then
			Menu.Erasing_File = not Menu.Erasing_File
		end
	end
end
	
function CharacterCreateUpdate()
	EscGoesTo(1)
	if not Menu.TypingName then
		if Menu.Changing == nil then
			if KeyList[4] then
				if Menu.SelectMenuCustom>1 then
					Menu.SelectMenuCustom=Menu.SelectMenuCustom - 1
				end
			elseif KeyList[5] then
				if Menu.SelectMenuCustom < 4 and Menu.SelectMenuCustom > 0 then
					Menu.SelectMenuCustom = Menu.SelectMenuCustom + 1
				end
			elseif KeyList[6] then
				if Menu.SelectMenuCustom == 0 then
					Menu.SelectMenuCustom = 1
				end
			elseif KeyList[7] then
				Menu.SelectMenuCustom = 0
			end
		else
			if KeyList[7] then
				NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] = NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] + 1
				NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] = (NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] - 1) % SELECT_CUSTOM_LEN[Menu.SelectMenuCustom] + 1
			elseif KeyList[6] then
				NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] = NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] - 1
				NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] = (NewCharacter[SELECT_CUSTOM_KEYS[Menu.SelectMenuCustom]] - 1) % SELECT_CUSTOM_LEN[Menu.SelectMenuCustom] + 1
			end
		end
	end
	
	if KeyList[1] == "space" and not Menu.TypingName then
		if Menu.Changing == nil then
			Menu.Changing = Menu.SelectMenuCustom
		else
			Menu.Changing = nil
		end
	end
	
	Menu.TypingName = Menu.Changing == 0
	
	if KeyList[1] == "return" then
		SaveCharacter(NewCharacter, Menu.SelectMenu)
		Player = NewCharacter
		BeginGame()
	end
	
end

function OptionsMenuUpdate(dt)
	EscGoesTo(0,2)
	love.audio.setVolume(Menu.MasterV/100)

	if MyLib.isKeyDown('right','d') and Menu.VControl then
		if Menu.MasterV < 100 then
			Menu.MasterV = Menu.MasterV + 60*dt
		end
	elseif MyLib.isKeyDown('left','a') and Menu.VControl then
		if Menu.MasterV > 0 then
			Menu.MasterV = Menu.MasterV - 60*dt
		end
	elseif KeyList[5] then
		MyLib.KeyRefresh()
		Menu.SelectMenu = Menu.SelectMenu + 1
	elseif KeyList[4] then
		MyLib.KeyRefresh()
		Menu.SelectMenu = Menu.SelectMenu - 1
	elseif KeyList[2] and not Menu.VControl then
		if Menu.SelectMenu == 2 then

		elseif Menu.SelectMenu == 3 then
			MyLib.FadeToColor(0.3,{"LuaCall>Menu = SetupMenu(2)"},{nil},"fill",{0,0,0,255},true)
			MyLib.KeyRefresh()
		end
	end
	
	Menu.SelectMenu = Menu.SelectMenu % 4
	Menu.VControl = (Menu.SelectMenu == 0)
	
end