return {
	[1] = {
		method = "Check",
		single = false,
		queue = { 
			function() 
				local content = {{value="Essa é uma máquina de doces", isPlayer=true}, 
								 {value="Já que ainda não tem mecânicas de dinheiro, eu vou pegar um...", isPlayer=true},
								}
				Player:StartDialog(content)
			end,
			function() 
				Player:GainItem(2,1)
				triggerEvent()
			end,
			function() 
				local content = {{value="Hmm, nem sei o sabor, vou guardar pra depois.", isPlayer=true}}
				Player:StartDialog(content)
			end,
		}
	},
	[2] = {
		method = "Walk",
		single = true,
		queue = { 
			function() 
				local content = {{value="Ah, vou embora daqui...", isPlayer=true}}
				Player:StartDialog(content)
			end,
			function() 
				Player:MoveToSpot(12,9)
			end,
			function() 
				local content = {{value="Aquele lugar ficou muito chato...", isPlayer=true}}
				Player:StartDialog(content)
			end,
		}
	},
}
