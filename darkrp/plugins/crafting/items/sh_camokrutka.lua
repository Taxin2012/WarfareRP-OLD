ITEM.name = "Косяк конопли"
ITEM.category = nut.lang.Get( "icat_material" )
ITEM.model = Model( "models/hardbass/tobacco.mdl" )
ITEM.desc = "Косяк успокоит нервы и поможет расслабиться на некоторое время. Благорадя ярко выраженному седативному эффекту, ненадолго отключит и перезапустит мозг, позволив ему остаться в порядке и избежать необратимых негативных последствий. \n\nХАРАКТЕРИСТИКИ: \n-стимулятор \n-сильное облегчение последствий псио-облучения"
ITEM.price = 360
ITEM.exRender = true
ITEM.model = "models/misery/drugz/joint.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(52.07494354248, 43.76273727417, 31.697546005249),
	ang = Angle(25, 220, 0),
	fov = 3.4
}
ITEM.cigarettesAmount = 1

function ITEM:getDesc()
	local str
	str = self.desc.." Осталось %s."
	return Format(str, self:getData("cigarettesAmount"))
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		local cigarettesAmount = item:getData("cigarettesAmount", item.cigarettesAmount or 1)
	end
end

-- Вызывается когда игрок использует предмет
ITEM.functions.Smoke = {
	name = "Закурить",
	icon = "icon16/wand.png",
	onRun = function(item)
		if (IsValid(item.player) && item.player:Alive()) then
			if !item.player:getChar():getInv():hasItem("tinderbox") then
				item.player:notify("У вас нет зажигалки!")
				return false
			end
			
			local s = EffectData();
			s:SetOrigin(item.player:EyePos());
			util.Effect("cw_effect_smoke_cig", s);

			if (math.random(1,10) >= 5) then
				local cough = {
					"interface/inv_smoke.ogg",
					"interface/inv_smoke.ogg",
					"interface/inv_smoke.ogg",
					"interface/inv_smoke.ogg"
				}
				item.player:EmitSound(cough[math.random(1,#cough)], 50, 100)
				item.player:Freeze(true)
		timer.Create("frizitem"..item.player:UniqueID(),5,1,function()
			item.player:Freeze(false)
		end)
		item.player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 )
		timer.Simple(1,function()
		item.player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 )
		end)
			end;
			item:setData("cigarettesAmount", item:getData("cigarettesAmount") - 1)
			
			if item:getData("cigarettesAmount") < 1 then
				item.player:notify("")
				return true
			end
		end
		return false;
	end,
	
	-- Вызывается когда проп лежит на земле, чтобы не вылезал подпункт - закурить
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onInstanced()
	if !self:getData("cigarettesAmount") then
		self:setData("cigarettesAmount", self.cigarettesAmount)
	end
end

ITEM.iconCam = {
ang = Angle(25, 220, 0),
fov = 4.2,
pos = Vector(52, 43.7, 31.7)
}
ITEM.exRender = true

ITEM.duration = 100
ITEM.attribBoosts = {
	["end"] = 5,
	["stm"] = 3,
}

local effectText = {
	"As soon as you inhale the smoke from the weed, You feels something happened to your body.",
	"You realizes you are actually cool. Because you're smoking weed.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("items/battery_pickup.wav")
	item.player:ChatPrint(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 255), 3, 0)
end)

local weedestColor = Color(27, 150, 0)
local weedMat = Material("modernrp/dankweed.png")
function ITEM:drawEntity(entity, item)
	entity:SetColor(weedestColor)
	entity:DrawModel()
	entity.emitter = entity.emitter or ParticleEmitter(entity:GetPos())

	if (entity.emitter) then
		if (!entity.nextEmit or entity.nextEmit < CurTime()) then
			local smoke = entity.emitter:Add(weedMat, entity:GetPos() + entity:OBBCenter())
			smoke:SetVelocity(VectorRand()*20)
			smoke:SetDieTime(math.Rand(0.5,1.3))
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(2,4))
			smoke:SetEndSize(math.random(8,12))
			smoke:SetRoll(math.Rand(0, 420))
			smoke:SetRollDelta(math.Rand(-3,3))
			smoke:SetGravity(Vector( 0, 0, 15))
			smoke:SetAirResistance(120)

			entity.nextEmit = CurTime() + .4
		end
	end
end