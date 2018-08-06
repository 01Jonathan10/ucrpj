function GMenu:submenu_draw()
	local draw_functions = {
		[Constants.EnumInGameSubmenu.INVENTORY] = function() self:inventory_draw() end,
		[Constants.EnumInGameSubmenu.EQUIPMENT] = function() self:equip_draw() end,
		[Constants.EnumInGameSubmenu.FRIENDS] = function() self:friends_draw() end,
		[Constants.EnumInGameSubmenu.TODO] = function() self:todo_draw() end,
		[Constants.EnumInGameSubmenu.OPTIONS] = function() self:options_draw() end,
	}
	
	if draw_functions[self.submenu] then draw_functions[self.submenu]() end
end

function GMenu:inventory_draw()
	ViewClass.draw(self.images[1], -800, 0)
	local i = 1
	for id, ammount in pairs(GameController.player.Inventory.contents) do
		local item = ItemData[id]
		local x = 50 + math.floor((i-1)/3)*800
		local y = 270 + math.floor((i-1)%3)*300
		ViewClass.draw(item.Img, x, y)
		ViewClass.print(item.Name, x + 250, y)
		ViewClass.printf(item.Description, x + 250, y + 50, 450)
		ViewClass.printf(ammount, x, y + 170, 200, "right")
		i = i+1
	end
end

function GMenu:equip_draw()

end

function GMenu:friends_draw()

end

function GMenu:todo_draw()

end

function GMenu:options_draw()
	ViewClass.draw(self.images[2], -800, 0)
	if not (self.option == 1) then
		ViewClass.draw(self.images.select_img, 300, self.option*150+300)
		love.graphics.setColor(126,126,126)		
	end
	ViewClass.draw(self.images.select_img, 370+630*(self.MasterV/100), 380)
	love.graphics.setColor(255,255,255)
end
