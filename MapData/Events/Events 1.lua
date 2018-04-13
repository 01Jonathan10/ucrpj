return {
	[1] = {
		id = 1,
		method = "Check",
		single = true,
		queue = { 
			function() 
				local content = {{value="Essa é uma máquina de doces", isPlayer=true}, 
								 {value="Já que ainda não tem mecânicas de dinheiro, eu vou pegar um...", isPlayer=true},
								}
				Player:StartDialog(content)
			end,
			function() 
				Player:GainItem(2,1)
				EventClass.triggerEvent()
			end,
			function() 
				local content = {{value="Hmm, nem sei o sabor, vou guardar pra depois.", isPlayer=true}}
				Player:StartDialog(content)
			end,
		}
	},
	[2] = {
		id = 2,
		method = "Walk",
		single = true,
		queue = { 
			function() 
				local content = {{value="Urgh, que nojo.", isPlayer=true}}
				Player:StartDialog(content)
			end,
			function() 
				Player.Speed = 15
				Player:MoveToSpot(12,10)
			end,
			function() 
				local content = {{value="Aquele lugar é um chiqueiro...", isPlayer=true}}
				Player:StartDialog(content)
			end,
		}
	},
}
