AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Нож"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Spenser"
SWEP.Instructions = "Заточенный Ножик."
SWEP.Purpose = "Нож."
SWEP.Drop = false

SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.ViewTranslation = 4

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 15
SWEP.Primary.Delay = 0.75

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = "models/weapons/ssk/spenser/v_ssk_knife.mdl"    
SWEP.WorldModel = "models/weapons/ssk/spenser/w_ssk_knife.mdl" 

SWEP.UseHands = false
SWEP.LowerAngles = Angle(0, 5, -14)

SWEP.FireWhenLowered = true
SWEP.HoldType = "normal"

function SWEP:Deploy()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
	end

	return true
end

function SWEP:Holster()
	if (!IsValid(self.Owner)) then
		return
	end

	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
		viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
	end

	return true
end

function SWEP:Think()
	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(1)
	end
end
function SWEP:PreDrawViewModel(viewModel, weapon, client)

	local hands = client:GetModel()
		viewModel:SetSkin(0)
		viewModel:SetBodygroup(0,0)
	if (hands == "models/spenser/ssk/new_dolg_03_spen.mdl" or hands == "models/spenser/ssk/new_merc_04_spen.mdl" or hands == "models/spenser/ssk/new_mono_03_spen.mdl" or hands == "models/spenser/ssk/new_stalk_05_spen.mdl") then
		viewModel:SetSkin(6)
		viewModel:SetBodygroup(0,0)
	elseif (hands == "models/spenser/ssk/new_dolg_01_spen.mdl" or hands == "models/spenser/ssk/new_dolg_02_spen.mdl") then
		viewModel:SetSkin(1)
		viewModel:SetBodygroup(0,0)
	elseif (hands == "models/spenser/ssk/new_free_01_spen.mdl" or hands == "models/spenser/ssk/new_free_03_spen.mdl" or hands == "models/spenser/ssk/new_free_02_spen.mdl") then
		viewModel:SetSkin(2)
		viewModel:SetBodygroup(0,0)
	elseif (hands == "models/spenser/ssk/new_nebo_01_spen.mdl" or hands == "models/spenser/ssk/new_nebo_02_spen.mdl" or hands == "models/spenser/ssk/new_nebo_03_spen.mdl" or hands == "models/spenser/ssk/new_nebo_04_spen.mdl") then
		viewModel:SetSkin(3)
		viewModel:SetBodygroup(0,0)
	elseif (hands == "models/spenser/ssk/new_stalk_02_spen.mdl") then
		viewModel:SetSkin(4)
		viewModel:SetBodygroup(0,0)
	elseif (hands == "models/spenser/ssk/new_solder_01_spen.mdl" or hands == "models/spenser/ssk/new_solder_02_spen.mdl" or hands == "models/spenser/ssk/new_solder_03_spen.mdl" or hands == "models/spenser/ssk/new_solder_04_spen.mdl" or hands == "models/spenser/ssk/new_solder_05_spen.mdl") then
		viewModel:SetSkin(5)
		viewModel:SetBodygroup(0,0)
	elseif (hands == "models/spenser/ssk/new_dolg_04_spen.mdl" or hands == "models/spenser/ssk/new_free_04_spen.mdl" or hands == "models/spenser/ssk/new_mono_04_spen.mdl" or hands == "models/spenser/ssk/new_stalk_04_spen.mdl") then
		viewModel:SetBodygroup(0, 1)
		viewModel:SetSkin(0)
	end
end

function SWEP:Precache()
	util.PrecacheSound("ssk/weapons/knife_1.wav")
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard1.wav")	
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard2.wav")	
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard3.wav")	
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard4.wav")	
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.LastHand = 0
end

function SWEP:DoPunchAnimation()
	self.LastHand = math.abs(1 - self.LastHand)

	local sequence = 4 + self.LastHand
	local viewModel = self.Owner:GetViewModel()

	if (IsValid(viewModel)) then
		viewModel:SetPlaybackRate(0.5)
		viewModel:SetSequence(sequence)
	end
end

function SWEP:PrimaryAttack()
	if (!IsFirstTimePredicted()) then
		return
	end

	if (!self.Owner.character) then
		return
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	local stamina = math.Clamp(self.Owner.character:GetVar("stamina", 100) - 15, 0, 100)

	if (!self.Owner:WepRaised() or stamina <= 0) then
		return
	end
	self:EmitSound("ssk/weapons/knife_1.wav")
	local damage = self.Primary.Damage

	self:DoPunchAnimation()

	self.Owner.character:SetVar("stamina", stamina)
	self.Owner:ViewPunch(Angle(self.LastHand + 2, self.LastHand + 5, 0.125))

	timer.Simple(0.055, function()
		if (IsValid(self) and IsValid(self.Owner)) then
			local damage = self.Primary.Damage
			local result = hook.Run("PlayerGetFistDamage", self.Owner, damage)

			if (result != nil) then
				damage = result
			end

			local data = {}
				data.start = self.Owner:GetShootPos()
				data.endpos = data.start + self.Owner:GetAimVector()*96
				data.filter = self.Owner
			local trace = util.TraceLine(data)

			if (SERVER and trace.Hit) then
				local entity = trace.Entity

				if (IsValid(entity)) then
					local damageInfo = DamageInfo()
						damageInfo:SetAttacker(self.Owner)
						damageInfo:SetInflictor(self)
						damageInfo:SetDamage(damage)
						damageInfo:SetDamageType(DMG_SLASH)
						damageInfo:SetDamagePosition(trace.HitPos)
						damageInfo:SetDamageForce(self.Owner:GetAimVector()*10000)
					entity:DispatchTraceAttack(damageInfo, data.start, data.endpos)

					self.Owner:EmitSound("weapons/knife/knife_hit"..math.random(1,4)..".wav", 70, 100)
				end
			end

			hook.Run("PlayerThrowPunch", self.Owner, trace.Hit)
		end
	end)
end

function SWEP:SecondaryAttack()
	return
end
