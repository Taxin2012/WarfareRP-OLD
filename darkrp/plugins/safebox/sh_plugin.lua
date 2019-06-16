PLUGIN.name = "Safebox"
PLUGIN.author = "La Corporativa, hikka"
PLUGIN.desc = "A plugin that allows players to have a safe place to store their items."

nut.config.add("BankInvW", 5, "How many slots in a row there is in a bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "characters"
})
nut.config.add("BankInvH", 5, "How many slots in a row there is in a bank inventory.", nil, {
	data = {min = 0, max = 20},
	category = "characters"
})

local CHAR = nut.meta.character

function CHAR:getReserve()
	return self:getData("bankmoney", 0)
end

function CHAR:addReserve(amt)
	self:setData("bankmoney", self:getReserve() + amt)
end

function CHAR:takeReserve(amt)
	self:addReserve(-amt)
end

function CHAR:hasReserve(amt)
	return (amt > 0 and self:getReserve() >= amt)
end

if (SERVER) then

	function PLUGIN:saveBox()
		local data = {}

		for k, v in ipairs(ents.FindByClass("nut_safebox")) do
			data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetModel()} -- money = v:getMoney()
		end

		self:setData(data)
	end
	
	function PLUGIN:SaveData()
		self:saveBox()
	end

	function PLUGIN:LoadData()
		local data = self:getData()

		--if (data) then
			for k, v in ipairs(data) do
				local storage = ents.Create("nut_safebox")
				storage:SetPos(v[1])
				storage:SetAngles(v[2])
				storage:Spawn()
				storage:SetModel(v[3])
				storage:SetSolid(SOLID_VPHYSICS)
				storage:PhysicsInit(SOLID_VPHYSICS)
				
				local physObject = storage:GetPhysicsObject()

				if (physObject) then
					physObject:EnableMotion()
				end
				--storage.money = v.money
			end
		--end
	end
end