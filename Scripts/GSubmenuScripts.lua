function GSubmenuUpdate(dt)
	local GSubMenuSwitch = {InventoryUpdate, EquipUpdate, FriendsUpdate, TodoUpdate, SubOptionsUpdate}
	GSubMenuSwitch[GMenu.Submenu](dt)
end

function InventoryUpdate()
	
end

function EquipUpdate()

end

function FriendsUpdate()

end

function TodoUpdate()

end

function SubOptionsUpdate(dt)
	love.audio.setVolume(GMenu.MasterV/100)
	
	GMenu.SelectMenu = GMenu.SelectMenu % 4
	GMenu.VControl = (GMenu.SelectMenu == 0)

	if MyLib.isKeyDown('right','d') and GMenu.VControl then
		if GMenu.MasterV < 100 then
			GMenu.MasterV = GMenu.MasterV + 60*dt
		end
	elseif MyLib.isKeyDown('left','a') and GMenu.VControl then
		if GMenu.MasterV > 0 then
			GMenu.MasterV = GMenu.MasterV - 60*dt
		end
	elseif KeyList[5] then
		MyLib.KeyRefresh()
		GMenu.SelectMenu = GMenu.SelectMenu + 1
	elseif KeyList[4] then
		MyLib.KeyRefresh()
		GMenu.SelectMenu = GMenu.SelectMenu - 1
	elseif KeyList[2] and not GMenu.VControl then
		if GMenu.SelectMenu == 2 then

		elseif GMenu.SelectMenu == 3 then
			GMenu.SelectMenu = 5
			GMenu.Submenu = nil
			MyLib.KeyRefresh()
		end
	end
end
