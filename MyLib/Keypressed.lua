KeyList = {}
for k, _ in pairs({1,2,3,4,5,6,7,8,9}) do
	if k==1 then
		KeyList[k] = ""
	else
		KeyList[k] = false
	end
end

function MyLib.KeyPress(btn)

	KeyList[1] = btn

	if (btn =="space" or btn == "return" or btn == "z") then
		KeyList[2] = true
	end

	if (btn == "escape") then
		KeyList[3] = true
	end

	if (btn == "up" or btn == "w") then
		KeyList[4] = true
	end

	if (btn == "down" or btn == "s") then
		KeyList[5] = true
	end

	if (btn == "left" or btn == "a") then
		KeyList[6] = true
	end

	if (btn == "right" or btn == "d") then
		KeyList[7] = true
	end
	
	return KeyList

end

function MyLib.KeyRefresh()

	for k, _ in pairs(KeyList) do
		if k==1 then
			KeyList[k] = ""
		else
			KeyList[k] = false
		end
	end

end

function MyLib.isKeyDown(...)
	if not MyLib.lockControls then
		return love.keyboard.isDown(...)
	end
	return false
end