if ( SERVER ) then

	AddCSLuaFile()

end

SWEP.AdminSpawnable = true                  
SWEP.ViewModel = "models/weapons/ssk/spenser/v_ssk_f1.mdl"    
SWEP.WorldModel = "models/weapons/ssk/spenser/w_ssk_f1.mdl"  
SWEP.AutoSwitchTo = false                     
SWEP.Slot = 1                                
SWEP.HoldType = "melee"   
SWEP.Type = "melee"                     
SWEP.PrintName = "Ф1"               
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
SWEP.Primary.Damage = 0                 
SWEP.Primary.TakeAmmo = 0                 
SWEP.Primary.ClipSize = -1           
SWEP.Primary.Ammo = ""               
SWEP.Primary.DefaultClip = -1          
SWEP.Primary.Spread = 0.1                      
SWEP.Primary.NumberofShots = 1                  
SWEP.Primary.Automatic = false           
SWEP.Primary.Recoil = 1.2
SWEP.Primary.AngVelocity = Angle(0,0,0)             
SWEP.Primary.Delay = 2.5               
SWEP.Primary.Force = 0                      
SWEP.Pistol	= true

SWEP.Secondary.NumberofShots = -1             
SWEP.Secondary.Force = -1               
SWEP.Secondary.Spread = -1               
SWEP.Secondary.Sound = ""  
SWEP.Secondary.DefaultClip = -1               
SWEP.Secondary.Automatic = false                 
SWEP.Secondary.AngVelocity = Angle(0,0,0)         
SWEP.Secondary.Ammo = ""            
SWEP.Secondary.Model = "" 
SWEP.Secondary.Recoil = -1                       
SWEP.Secondary.Delay = 999                        
SWEP.Secondary.TakeAmmo = -1                       
SWEP.Secondary.ClipSize = -1                    
SWEP.Secondary.Damage = 0                      



function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound(self.Secondary.Sound)
	util.PrecacheSound(self.Primary.Sound)
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
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	local vm = self.Owner:GetViewModel()
	local s, d = vm:LookupSequence("shot")
	self:PlayAnimation("shot", 1)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	timer.Simple(d,function ()
		self:FireRocket()
	end)
	self:UpdateNextIdle()
end
//SWEP:PrimaryFire()\\

function SWEP:FireRocket()
	if SERVER then
	  local client = self.Owner
	aim = self.Owner:GetAimVector()
	pos = self.Owner:GetShootPos()
	local gren = ents.Create("ssk_ef1")
	if !gren:IsValid() then return false end
		gren:SetAngles(aim:Angle())
		gren:SetPos(pos)
		gren:SetOwner(self.Owner)
		gren:Spawn()
		gren.Owner = self.Owner
		gren:Activate()
	      local phys = gren:GetPhysicsObject()
	      phys:SetVelocity( client:GetAimVector() * 1000 * math.Rand( .8, 1 ) )
	      phys:AddAngleVelocity( client:GetAimVector() * 1000  )
		  self.Owner:getChar():getInv():remove(client:getChar():getInv():hasItem("wep_sskf1"):getID()) 
		  self.Owner:StripWeapon("ssk_f1")
	end
end

function SWEP:PreDrawViewModel(viewModel, weapon, client)
end

function SWEP:Reload()
	return false
end

function SWEP:SecondaryAttack()
	return false
end
SWEP.VmPos, SWEP.VmAng = Vector(7,7,-6), Angle(0,0,0)
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
	if (self.Owner:GetMoveType() != MOVETYPE_WALK) then
		if (idletime > 0 and CurTime() > idletime) then
			self:PlayAnimation("idle", 1)
			self:UpdateNextIdle()
		end
	else
		if (idletime > 0 and CurTime() > idletime) then
			self:PlayAnimation("move", 1)
			self:UpdateNextIdle()
		end		
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