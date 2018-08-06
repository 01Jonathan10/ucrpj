function MainMenu:update_submenu(dt)
	local update_functions = {
		[Constants.EnumMainSubmenu.OPTIONS] = function(dt) self:options_update(dt) end,
	}
	
	if update_functions[self.submenu] then update_functions[self.submenu](dt) end
end

function MainMenu:options_update(dt)
	love.audio.setVolume(self.MasterV/100)
	
	if MyLib.isKeyDown('right','d') and self.option == 1 then
		if self.MasterV < 100 then
			self.MasterV = self.MasterV + 60*dt
		end
	elseif MyLib.isKeyDown('left','a') and self.option == 1 then
		if self.MasterV > 0 then
			self.MasterV = self.MasterV - 60*dt
		end
	end
end
