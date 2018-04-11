return {
	[1] = function() 
		local content = {{value="Essa é uma máquina de doces", isPlayer=true}, 
						 {value="Já que ainda não tem mecânicas de dinheiro, eu vou pegar um...", isPlayer=true},
						 {value="LuaCall>Player:GainItem(2,1)"},
						 {value="Hmm, nem sei o sabor, vou guardar pra depois.", isPlayer=true},
						}
		Player:StartDialog(content)
	end,
}
