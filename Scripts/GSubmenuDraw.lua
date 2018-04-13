function GSubmenuDraw()
	local GSubMenuSwitch = {InventoryDraw, EquipDraw, FriendsDraw, TodoDraw, SubOptionsDraw}
	GSubMenuSwitch[GMenu.Submenu]()
end

function InventoryDraw()
	love.graphics.draw(GMenuImg[1], 0, 0)
	local i = 1
	for id, ammount in pairs(Player.Inventory.contents) do
		local item = ItemData[id]
		local x = 50 + math.floor((i-1)/3)*800
		local y = 270 + math.floor((i-1)%3)*300
		love.graphics.draw(item.Img, x, y)
		love.graphics.print(item.Name, x + 250, y)
		love.graphics.printf(item.Description, x + 250, y + 50, 450)
		love.graphics.printf(ammount, x, y + 170, 200, "right")
		i = i+1
	end
end

function EquipDraw()

end

function FriendsDraw()

end

function TodoDraw()

end

function SubOptionsDraw()
	love.graphics.draw(MenuImg[3], 0, 0)
	if not GMenu.VControl then
		love.graphics.draw(Selecao, 300, GMenu.SelectMenu*150+450)
		love.graphics.setColor(126,126,126)		
	end
	love.graphics.draw(Selecao, 370+630*(GMenu.MasterV/100), 380)
	love.graphics.setColor(255,255,255)
end
