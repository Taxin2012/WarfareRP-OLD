if ( SERVER ) then
	AddCSLuaFile()
end

if ( CLIENT ) then
	SWEP.PrintName			= "Отмычка"			
	SWEP.Author				= "PopeXIII"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.BobScale = 0
	SWEP.SwayScale = 0
end

SWEP.HoldType			= "normal"
SWEP.Category			= "NutScript 1.1 Weapons"

SWEP.Spawnable			= true
SWEP.AdminOnly		= true

SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "physics/wood/wood_box_impact_hard3.wav" )
SWEP.Primary.ClipSize = -1      
SWEP.Primary.DefaultClip = 0       
SWEP.Primary.Automatic = false      
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1      
SWEP.Secondary.DefaultClip = -1     
SWEP.Secondary.Automatic = false        
SWEP.Secondary.Ammo = ""
SWEP.isLP = false

function SWEP:Initialize()
	self:SetHoldType("normal")
	self.isLP = false
end

function SWEP:toggleUnlock(door) 
	if (IsValid(self.Owner) and self.Owner:GetPos():Distance(door:GetPos()) > 96) then
		return
	end

	if (door:isDoor()) then
		local partner = door:getDoorPartner()
		if (IsValid(partner)) then
			partner:Fire("unlock")
		end

		door:Fire("unlock")
		self.Owner:EmitSound("doors/door_latch"..math.random(1,3)..".wav")
	elseif (door:IsVehicle()) then
		door:Fire("unlock")
		self.Owner:EmitSound("doors/door_latch"..math.random(1,3)..".wav")
	end
end

function SWEP:PrimaryAttack()
	if self.isLP then return end
	local time = math.random(1,10)
	local time2 = math.max(time, 1)
	local ply = self.Owner:getChar()
	self.isLP = true

	self:SetNextPrimaryFire(CurTime() + time2)
	self:SetNextSecondaryFire(CurTime() + time2)

	if (!IsFirstTimePredicted()) then
		return
	end

	if (CLIENT) then
		return
	end
	
	if !IsValid(self.Owner) then return end

	local data = {}
		data.start = self.Owner:GetShootPos()
		data.endpos = data.start + self.Owner:GetAimVector()*96
		data.filter = self.Owner
	local entity = util.TraceLine(data).Entity
	local skill = ply:getAttrib("vzlom", 0)
	local odds = math.random(1, 100) + skill/2.5
	local skilltime = 30 - skill*0.2
	
		if (IsValid(entity) and ((entity:isDoor()) or (entity:IsVehicle()))) then
			--self.Owner:emote("startlockpick")
			self.Owner:setAction("Взламываем...", skilltime, function()
				if self.isLP then
					self:toggleUnlock(entity)
					self.Owner:StripWeapon("nut_lockpick")
					if odds >= 95 then
						--self.Owner:emote("unlockcritsucc")
						ply:updateAttrib("vzlom", 0.35)
					else
						--self.Owner:emote("unlocksucc")
						ply:updateAttrib("vzlom", 0.15)
					end
					self.isLP = false
				else 
					return
				end
			end)			

		return
	end
end

function SWEP:Think() 
	self:EmitSound("weapons/357/357_reload")

	local trace = self:GetOwner():GetEyeTrace()

	if self.isLP then
		if not IsValid(trace.Entity) or !IsValid(self.Owner) or not trace.Entity:isDoor() or trace.HitPos:Distance(self:GetOwner():GetShootPos()) > 100 then
			if (SERVER) then
				self.Owner:setAction()
				self.Owner:StripWeapon("nut_lockpick")
				--self.isLP = false
			end
		end
	else
		return 
	end 
end