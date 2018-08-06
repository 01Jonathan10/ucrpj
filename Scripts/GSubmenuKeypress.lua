function GMenu:submenu_keypress()
	local keypress_functions = {
		[Constants.EnumInGameSubmenu.INVENTORY] = function() self:inventory_keypress() end,
		[Constants.EnumInGameSubmenu.EQUIPMENT] = function() self:equip_keypress() end,
		[Constants.EnumInGameSubmenu.FRIENDS] = function() self:friends_keypress() end,
		[Constants.EnumInGameSubmenu.TODO] = function() self:todo_keypress() end,
		[Constants.EnumInGameSubmenu.OPTIONS] = function() self:options_keypress() end,
	}
	
	if keypress_functions[self.submenu] then keypress_functions[self.submenu]() end
end

function GMenu:inventory_keypress()
	
end

function GMenu:equip_keypress()

end

function GMenu:friends_keypress()

end

function GMenu:todo_keypress()

end

function GMenu:options_keypress()	
	if MyLib.key_list.down then
		MyLib.KeyRefresh()
		self.option = self.option % 4 + 1
	elseif MyLib.key_list.up then
		MyLib.KeyRefresh()
		self.option = (self.option - 2) % 4 + 1
	elseif MyLib.key_list.confirm and not (self.option == 1) then
		if self.option == 3 then
			self.FullScreen = not self.FullScreen
			ToggleFullScreen(self.FullScreen)
		elseif self.option == 4 then
			self.option = Constants.EnumInGameSubmenu.OPTIONS
			self.submenu = Constants.EnumInGameSubmenu.MAIN
			MyLib.KeyRefresh()
		end
	end
end
