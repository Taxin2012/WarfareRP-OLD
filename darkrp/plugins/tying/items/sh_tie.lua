ITEM.name = "Веревка"
ITEM.desc = "Около 10 метров хорошей веревки, которая может послужить многим целям, особенно в таком месте, как Зона Отчуждения. \n-повсеместное применение \n-используется для обезоруживание стаолкера \n\nИнвентарь игрока можно осмотреть с помощью команды /charsearch \nЗапрещено отбираться именные вещи"
ITEM.price = 759
ITEM.model = "models/spenser/ssk/item_misery/rope.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.iconCam = {
pos = Vector(0, 3.5, 200),
ang = Angle(90, 0, 0),
fov = 5
}

ITEM.exRender = true
ITEM.functions.Use = {
	onRun = function(item)
		if (item.beingUsed) then
			return false
		end

		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:getChar() and !target:getNetVar("tying") and !target:getNetVar("restricted")) then
			item.beingUsed = true

			client:EmitSound("physics/plastic/plastic_barrel_strain"..math.random(1, 3)..".wav")
			client:setAction("@tying", 5)
			client:doStaredAction(target, function()
				item:remove()

				target:setRestricted(true)
				target:setNetVar("tying")

				client:EmitSound("npc/barnacle/neck_snap1.wav", 100, 140)
			end, 5, function()
				client:setAction()

				target:setAction()
				target:setNetVar("tying")

				item.beingUsed = false
			end)

			target:setNetVar("tying", true)
			target:setAction("@beingTied", 5)
		else
			item.player:notifyLocalized("plyNotValid")
		end

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}

function ITEM:onCanBeTransfered(inventory, newInventory)
	return !self.beingUsed
end