function MainMenu:draw_submenu()
	local draw_functions = {
		[Constants.EnumMainSubmenu.MAIN] = function() self:main_menu_draw() end,
		[Constants.EnumMainSubmenu.FILE_SELECT] = function() self:file_select_draw() end,
		[Constants.EnumMainSubmenu.OPTIONS] = function() self:options_draw() end,
		[Constants.EnumMainSubmenu.CHARACTER_CREATION] = function() self:char_select_draw() end,
		[Constants.EnumMainSubmenu.NAME_INPUT] = function() self:name_input_draw() end,
	}
	
	if draw_functions[self.submenu] then draw_functions[self.submenu]() end
end

function MainMenu:main_menu_draw()
	ViewClass.draw(self.images.select_img, 560, 234 + 126*self.option)
end

function MainMenu:file_select_draw()
	if self.option < 4 then
		ViewClass.draw(self.images.select_img, 120, 130 + 260*self.option)
	else
		ViewClass.draw(self.images.select_img, 1200*(self.option-4), 1090)
	end

	for i=1,3 do
		if self.loaded_chars[i] then
			ViewClass.print(self.loaded_chars[i].name, 600, 130 + 260*i)
			ViewClass.print("Level "..self.loaded_chars[i].level, 1000, 130 + 260*i)
			local dateTime = self.loaded_chars[i].Day.." - "..self.loaded_chars[i].Time[1]..":"..string.format("%02d", self.loaded_chars[i].Time[2])
			ViewClass.print("Day: "..dateTime, 600, 170 + 260*i)
			ViewClass.print("Gold: "..self.loaded_chars[i].gold, 600, 210 + 260*i)
		end
	end
end

function MainMenu:char_select_draw()
	ViewClass.draw(self.template_chars[1].picture,0,0)
	ViewClass.draw(self.template_chars[2].picture,800,0)
	love.graphics.setColor(0,0,0,75)
	ViewClass.rectangle('fill',800*(self.option%2),0,800,1200)
end

function MainMenu:name_input_draw()
	ViewClass.draw(GameController.player.picture,0,0)
	ViewClass.printf('Name', 800,50,800,'center')
	ViewClass.printf(GameController.player.name, 800,350,800,'center')
end

function MainMenu:options_draw()
	if not (self.option == 1) then
		ViewClass.draw(self.images.select_img, 300, self.option*150+300)
		love.graphics.setColor(126,126,126)		
	end
	ViewClass.draw(self.images.select_img, 370+630*(self.MasterV/100), 380)
	love.graphics.setColor(255,255,255)
end
