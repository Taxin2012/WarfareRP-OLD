if ( SERVER ) then

	AddCSLuaFile()

end

SWEP.AdminSpawnable = true                  
SWEP.ViewModel = "models/weapons/ssk/spenser/v_ssk_usp45.mdl"    
SWEP.WorldModel = "models/weapons/ssk/spenser/w_ssk_usp45.mdl"  
SWEP.AutoSwitchTo = false                     
SWEP.Slot = 1                                
SWEP.HoldType = "pistol"   
SWEP.Type = "pistol"                     
SWEP.PrintName = "УДП «Компакт»"               
SWEP.Author = "Spenser"                  
SWEP.Spawnable = true                          
SWEP.AutoSwitchFrom = false                     
SWEP.FiresUnderwater = false                   
SWEP.Weight = 1                                   
SWEP.SlotPos = 0                              
SWEP.ReloadSound = "ssk/weapons/usp_reload.wav"       
SWEP.Instructions = ""  
SWEP.Contact = ""         
SWEP.Purpose = ""      
SWEP.TracerType = "Tracer"
SWEP.Base = "weapon_base"
if ( CLIENT ) then
SWEP.ViewModelFlip = true
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true 
SWEP.ViewModelFOV		= 30
end
	  game.AddAmmoType({
	    name = "45acp",
	    dmgtype = DMG_BULLET,
	    tracer = TRACER_LINE_AND_WHIZ,
	    plydmg = 0,
	    npcdmg = 0,
	    force = 1000,
	    minsplash = 10,
	    maxsplash = 5
	  })
SWEP.Primary.Sound = "ssk/weapons/n_usp_shot.wav"    
SWEP.Primary.Sound2 = "ssk/weapons/n_pb_shot.wav" 
SWEP.Primary.Damage = math.random(45, 55)               
SWEP.Primary.TakeAmmo = 1                 
SWEP.Primary.ClipSize = 12             
SWEP.Primary.Ammo = "45acp"               
SWEP.Primary.DefaultClip = 12            
SWEP.Primary.Spread = 0.15                      
SWEP.Primary.NumberofShots = 1                  
SWEP.Primary.Automatic = false           
SWEP.Primary.Recoil = 1.2
SWEP.Primary.AngVelocity = Angle(0,0,0)             
SWEP.Primary.Delay = 0.4                   
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
	self:SetNWFloat("NextIdle", 0)
	self:SetNWFloat("Zoom", 0)
	self:SetNWFloat("Reload", 0)
	if ( SERVER ) then
		self:SetHoldType( self.HoldType )
	end
end
//SWEP:Initialize()\\
	function SWEP:Deploy()
		 self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
	end
//SWEP:PrimaryFire()\\
function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self.Owner:MuzzleFlash()
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1
		bullet.Distance = 4000
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
	local rnda = self.Primary.Recoil * -1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch( Angle( -14,0,0 ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:UpdateNextIdle()
end
//SWEP:PrimaryFire()\\

function SWEP:PreDrawViewModel(viewModel, weapon, client)
end

function SWEP:Reload()
	if !self.Owner:Alive() then return end if !self.Owner:isWepRaised() then return end
	if self.Owner:GetAmmoCount( self.Primary.Ammo ) == 0 then return end if (self.Owner:GetActiveWeapon():Clip1() == self.Primary.ClipSize) then return end
    self.Weapon:DefaultReload(ACT_VM_RELOAD)
    self:UpdateNextIdle()
    self:SetIronsights(false)
    self:SetNWBool( "ZOOM", false )
    self.Owner:SetFOV( 0, 0.35 ) 
end

function SWEP:SecondaryAttack()
	return false
end
SWEP.VmPos, SWEP.VmAng = Vector(5.3,0,-6), Angle(0,0,0)
SWEP.VmPos2, SWEP.VmAng2 = Vector(4.38,0,1.3), Angle(0,0,0)
function SWEP:GetViewModelPosition( pos, ang )
		Right = ang:Right()
		Up = ang:Up()
		Forward = ang:Forward()
		pos = pos + self.VmPos.x * Right
		pos = pos + self.VmPos.y * Forward
		pos = pos + self.VmPos.z * Up
	if (self:GetNWBool( "ZOOM" ) == true) then
		ang:RotateAroundAxis( ang:Right(), 0 )
		ang:RotateAroundAxis( ang:Forward(), 0 )
		ang:RotateAroundAxis( ang:Up(), 0 )
		Right = ang:Right()
		Up = ang:Up()
		Forward = ang:Forward()
		pos = pos + self.VmPos2.x * Right
		pos = pos + self.VmPos2.y * Forward
		pos = pos + self.VmPos2.z * Up
	end
	return pos, ang
end

function SWEP:Think()	
	ZOOM = self:GetNWBool( "ZOOM" )
	local vm = self.Owner:GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNWFloat("NextIdle", 0)
	if (idletime > 0 and CurTime() > idletime) then
		self:PlayAnimation("idle", 1)
		self:UpdateNextIdle()
	end
	self:IronThink()
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
	if NextAim > CurTime() then return end
	if ((self.Owner:KeyDown( IN_ATTACK2 ) and !ZOOM)) and self:CanNextAction() and self.Owner:OnGround() and !self.Owner:KeyDown( IN_SPEED ) then
		self:SetIronsights( true )
		NextAim = CurTime() + 0.15
		self.Owner:SetFOV( 75, 0.35 ) 
		self:PlayAnimation("idle", 0)
	end
	if (!self.Owner:KeyDown( IN_ATTACK2 ) and ZOOM) or (!self.Owner:OnGround() and ZOOM) or (ZOOM and self.Owner:KeyDown( IN_SPEED )) then
		self:SetIronsights( false )
		NextAim = CurTime() + 0.15
		self.Owner:SetFOV( 0, 0.35 ) 
		self:PlayAnimation("idle", 1)
	end
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