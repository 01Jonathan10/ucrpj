function GMenu:submenu_update(dt)
	local update_functions = {
		[Constants.EnumInGameSubmenu.INVENTORY] = function(dt) self:inventory_update(dt) end,
		[Constants.EnumInGameSubmenu.EQUIPMENT] = function(dt) self:equip_update(dt) end,
		[Constants.EnumInGameSubmenu.FRIENDS] = function(dt) self:friends_update(dt) end,
		[Constants.EnumInGameSubmenu.TODO] = function(dt) self:todo_update(dt) end,
		[Constants.EnumInGameSubmenu.OPTIONS] = function(dt) self:options_update(dt) end,
	}
	
	if update_functions[self.submenu] then update_functions[self.submenu](dt) end
end

function GMenu:inventory_update()
	
end

function GMenu:equip_update()

end

function GMenu:friends_update()

end

function GMenu:todo_update()

end

function GMenu:options_update(dt)
	self.MasterV = 100*love.audio.getVolume()
	
	if MyLib.isKeyDown('right','d') and self.option == 1 then
		if self.MasterV < 100 then
			self.MasterV = self.MasterV + 60*dt
		end
	elseif MyLib.isKeyDown('left','a') and self.option == 1 then
		if self.MasterV > 0 then
			self.MasterV = self.MasterV - 60*dt
		end
	end
	
	love.audio.setVolume(self.MasterV/100)
end
