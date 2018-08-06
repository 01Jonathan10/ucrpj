function MainMenu:keypress_submenu()
	local keypress_functions = {
		[Constants.EnumMainSubmenu.MAIN] = function() self:main_menu_keypress() end,
		[Constants.EnumMainSubmenu.FILE_SELECT] = function() self:file_options_keypress() end,
		[Constants.EnumMainSubmenu.OPTIONS] = function() self:options_keypress() end,
		[Constants.EnumMainSubmenu.CHARACTER_CREATION] = function() self:character_select_keypress() end,
		[Constants.EnumMainSubmenu.CREDITS] = function() self:credits_keypress() end,
		[Constants.EnumMainSubmenu.NAME_INPUT] = function() self:name_input_keypress() end,
	}
	
	if keypress_functions[self.submenu] then keypress_functions[self.submenu]() end
end

function MainMenu:fade_to_submenu(submenu, option)
	local option = option or 1
	MyLib.FadeToColor(0.3,{"LuaCall>GameController.menu:set_submenu("..submenu..","..option..")"},{},"fill",{0,0,0,255},true)
	MyLib.KeyRefresh()
end

function MainMenu:set_submenu(submenu, option)
	self.option = option
	self.submenu = submenu
end

function MainMenu:esc_goes_to(submenu, option)
	if MyLib.key_list.escape then
		self:fade_to_submenu(submenu, option)
	end
end

function MainMenu:menu_controls(max_option)
	if MyLib.key_list.up then
		self.option=(self.option - 2) % max_option + 1
	elseif MyLib.key_list.down then
		self.option=(self.option % max_option) + 1
	end
end

function MainMenu:main_menu_keypress()
	if MyLib.key_list.escape then
		love.event.push('quit')
	end
	self:menu_controls(4)
	if MyLib.key_list.confirm then
		if self.option == 4 then
			love.event.push('quit')
		else
			self:fade_to_submenu(self.option)
		end
	end
end

function MainMenu:file_options_keypress()
	self:esc_goes_to(Constants.EnumMainSubmenu.MAIN)
	self:menu_controls(4)
	if MyLib.key_list.right and self.option==4 then
		self.option = 5
	elseif MyLib.key_list.left and self.option==5 then
		self.option = 4
	elseif MyLib.key_list.confirm then
		if self.option < 4 then
			if self.state == Constants.EnumMenuState.ERASING_FILE and GameController.menu.loaded_chars[self.option] then
				love.filesystem.remove("Save00"..self.option..".lua")
				DataManager.load_files()
				self.state = Constants.EnumMenuState.NORMAL
			elseif self.loaded_chars[self.option] then
				GameController.save_slot = self.option
				GameController.player = Player.create(GameController.menu.loaded_chars[self.option])
				World.begin_game()
			else
				GameController.save_slot = self.option
				self.template_chars = {Player.blank_character(), Player.blank_character()}
				self.template_chars[1].picture = love.graphics.newImage('Graphics/Chars/MainChars/Protagonist_F/picture.png')
				self.template_chars[2].gender = Constants.EnumGender.MALE
				self.template_chars[2].picture = love.graphics.newImage('Graphics/Chars/MainChars/Protagonist_M/picture.png')
				self:fade_to_submenu(Constants.EnumMainSubmenu.CHARACTER_CREATION)
			end
		elseif self.option == 4 then
			self:fade_to_submenu(0)
		elseif self.option == 5 then
			self.state = (self.state + 1) % 2
		end
	end
end

function MainMenu:character_select_keypress()
	self:esc_goes_to(Constants.EnumMainSubmenu.FILE_SELECT, GameController.save_slot)

	if MyLib.key_list.left or MyLib.key_list.right then
		self.option = (self.option % 2) + 1
	end
	
	if MyLib.key_list.confirm then
		GameController.player = Player.create(GameController.menu.template_chars[self.option])
		self:fade_to_submenu(Constants.EnumMainSubmenu.NAME_INPUT)
	end
end

function MainMenu:options_keypress(dt)
	self:esc_goes_to(Constants.EnumMainSubmenu.MAIN, Constants.EnumMainSubmenu.OPTIONS)
	self:menu_controls(4)
	
	if MyLib.key_list.confirm then
		-- TODO: Extras
		if self.option == 3 then
			self.FullScreen = not self.FullScreen
			ToggleFullScreen(self.FullScreen)
		elseif self.option == 4 then
			self:fade_to_submenu(Constants.EnumMainSubmenu.MAIN, Constants.EnumMainSubmenu.OPTIONS)
		end
	end
end

function MainMenu:credits_keypress()
	if MyLib.key_list.btn ~= '' then self:fade_to_submenu(Constants.EnumMainSubmenu.MAIN, Constants.EnumMainSubmenu.CREDITS) end
end

function MainMenu:name_input_keypress()
	self:esc_goes_to(Constants.EnumMainSubmenu.FILE_SELECT, GameController.save_slot)
	if MyLib.key_list.btn == 'return' then
		GameController.player.creating = nil
		DataManager.save(GameController.player)
		World.begin_game()
	elseif MyLib.key_list.btn == "backspace" then
		GameController.player.name = string.sub(GameController.player.name, 1, string.len(GameController.player.name) - 1)
	end
end
