if ( SERVER ) then

	AddCSLuaFile()

end

SWEP.AdminSpawnable = true                  
SWEP.ViewModel = "models/weapons/ssk/spenser/v_ssk_knife.mdl"    
SWEP.WorldModel = "models/weapons/ssk/spenser/w_ssk_knife.mdl" 
SWEP.AutoSwitchTo = false                     
SWEP.Slot = 1                                
SWEP.HoldType = "normal"   
SWEP.Type = "melee"                     
SWEP.PrintName = "Нож"               
SWEP.Author = "Spenser"                  
SWEP.Spawnable = true                          
SWEP.AutoSwitchFrom = false                     
SWEP.FiresUnderwater = false                   
SWEP.Weight = 1                                   
SWEP.SlotPos = 0                              
SWEP.ReloadSound = ""       
SWEP.Instructions = ""  
SWEP.Contact = ""         
SWEP.Purpose = ""      
SWEP.TracerType = ""
SWEP.Base = "weapon_base"
if ( CLIENT ) then
SWEP.ViewModelFlip = true
SWEP.DrawAmmo = true 
SWEP.BobScale = 2 
SWEP.DrawCrosshair = true 
SWEP.ViewModelFOV		= 35
end
SWEP.Primary.Sound = ""    
SWEP.Primary.Damage = 15                 
SWEP.Primary.TakeAmmo = 0                 
SWEP.Primary.ClipSize = -1           
SWEP.Primary.Ammo = ""               
SWEP.Primary.DefaultClip = -1          
SWEP.Primary.Spread = 0.1                      
SWEP.Primary.NumberofShots = 1                  
SWEP.Primary.Automatic = false           
SWEP.Primary.Recoil = 0
SWEP.Primary.AngVelocity = Angle(0,0,0)             
SWEP.Primary.Delay = 0.75               
SWEP.Primary.Force = 0                      

SWEP.Secondary.NumberofShots = 1             
SWEP.Secondary.Force = 0               
SWEP.Secondary.Spread = 0              
SWEP.Secondary.Sound = ""  
SWEP.Secondary.DefaultClip = -1               
SWEP.Secondary.Automatic = false                 
SWEP.Secondary.AngVelocity = Angle(0,0,0)         
SWEP.Secondary.Ammo = ""            
SWEP.Secondary.Recoil = -1                       
SWEP.Secondary.Delay = 1.25                      
SWEP.Secondary.TakeAmmo = 0                      
SWEP.Secondary.ClipSize = -1                    
SWEP.Secondary.Damage = 0                      



function SWEP:Initialize()
	util.PrecacheSound("ssk/weapons/knife_1.wav")
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard1.wav")	
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard2.wav")	
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard3.wav")	
	util.PrecacheSound("physics/plastic/plastic_box_impact_hard4.wav")	
	self:SetNWFloat("NextIdle", 0)
	self:SetNWFloat("Zoom", 0)
	self:SetNWFloat("Reload", 0)
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
end
//SWEP:Initialize()\\
	function SWEP:Deploy()
		 self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		 self:PlayAnimation("idle", 1)
	end
//SWEP:PrimaryFire()\\
function SWEP:PrimaryAttack()
	if (!IsFirstTimePredicted()) then
		return
	end
	if (!self.Owner:getChar()) then
		return
	end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	--[[if (!self.Owner:wepAlwaysRaised()) then
		return
	end]]
	self:EmitSound("ssk/weapons/knife_1.wav")
	local damage = self.Primary.Damage
	self.Owner:ViewPunch(Angle(-1, 0, 0.125))
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "shot" ) )
	timer.Simple(0.055, function()
		if (IsValid(self) and IsValid(self.Owner)) then
			local damage = self.Primary.Damage
			--local result = hook.Run("PlayerGetFistDamage", self.Owner, damage)
			--if (result != nil) then
			--	damage = result
			--end
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
//SWEP:PrimaryFire()\\

function SWEP:PreDrawViewModel(viewModel, weapon, client)
	local hands = client:GetModel()
end

function SWEP:Reload()
	return false
end

function SWEP:SecondaryAttack()
	if (!IsFirstTimePredicted()) then
		return
	end
	if (!self.Owner:getChar()) then
		return
	end
	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
	--[[if (!self.Owner:wepAlwaysRaised()) then
		return
	end]]
	self:EmitSound("ssk/weapons/knife_1.wav")
	local damage = self.Primary.Damage*1.5
	self.Owner:ViewPunch(Angle(-1.1, 0, 0.125))
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "shot2" ) )
	--[[timer.Simple(1, function()
	self:PlayAnimation("idle", 1)
	end]]
	timer.Simple(0.055, function()
		if (IsValid(self) and IsValid(self.Owner)) then
			local damage = self.Primary.Damage*1.5
			--local result = hook.Run("PlayerGetFistDamage", self.Owner, damage)
			--if (result != nil) then
			--	damage = result
			--end
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
SWEP.VmPos, SWEP.VmAng = Vector(4.75,0,-6.25), Angle(0,0,0)
function SWEP:GetViewModelPosition( pos, ang )
		Right = ang:Right()
		Up = ang:Up()
		Forward = ang:Forward()
		pos = pos + self.VmPos.x * Right
		pos = pos + self.VmPos.y * Forward
		pos = pos + self.VmPos.z * Up
	return pos, ang
end

function SWEP:Think()	
	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNWFloat("NextIdle", 0)
	if (idletime > 0 and CurTime() > idletime) then
		self:PlayAnimation("idle", 1)
		self:UpdateNextIdle()
	end	
end

function SWEP:UpdateNextIdle()
	local vm = self.Owner:GetViewModel()
	local time = CurTime() + vm:SequenceDuration()
	self:SetNWFloat("NextIdle", self:GetNWFloat("NextIdle",0) + time)
end

function SWEP:OnDrop()
	self:Remove()
end
function SWEP:SetIronsights( b ) self:SetNWBool( "ZOOM", b ) end
function SWEP:CanNextAction() return self:GetNWFloat("NextAct") <= CurTime() end
function SWEP:GetNextAction() return self:GetNWFloat("NextAct") end
function SWEP:SetNextAction(time) return self:SetNWFloat("NextAct", CurTime() + time) end

local NextAim = CurTime()
function SWEP:IronThink()
end
	function SWEP:DrawWorldModel()
		self:DrawModel() 
	end

function SWEP:PlayAnimation(seq, speed)
	local speed = speed or 1
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence(vm:LookupSequence("idle"))

	timer.Simple(0,function()
	vm:ResetSequence(vm:LookupSequence(seq))
	vm:SetPlaybackRate(speed)
	vm:SetCycle(0) 
	end)
end