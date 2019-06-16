if ( SERVER ) then

	AddCSLuaFile()

end

SWEP.AdminSpawnable = true          
SWEP.ViewModel = "models/weapons/ssk/spenser/v_ssk_bm.mdl"    
SWEP.WorldModel = "models/weapons/ssk/spenser/w_ssk_bm.mdl"  
SWEP.AutoSwitchTo = false                     
SWEP.Slot = 4                                
SWEP.HoldType = "shotgun"   
SWEP.Type = "shotgun"                     
SWEP.PrintName = "Обрез"               
SWEP.Author = "Spenser"                  
SWEP.Spawnable = true                          
SWEP.AutoSwitchFrom = false                     
SWEP.FiresUnderwater = false                   
SWEP.Weight = 4                                         
SWEP.SlotPos = 0                                 
SWEP.Instructions = ""  
SWEP.Contact = ""         
SWEP.Purpose = ""      
SWEP.TracerType = "Tracer"
SWEP.Base = "weapon_base"
if ( CLIENT ) then
SWEP.ViewModelFlip = true
SWEP.DrawAmmo = true 
SWEP.DrawCrosshair = true 
SWEP.ViewModelFOV		= 42
end
	  game.AddAmmoType({
	    name = "12x70",
	    dmgtype = DMG_BULLET,
	    tracer = TRACER_LINE_AND_WHIZ,
	    plydmg = 0,
	    npcdmg = 0,
	    force = 2000,
	    minsplash = 10,
	    maxsplash = 5
	  })
SWEP.Primary.Sound = "ssk/weapons/n_bm16_shot.wav"    
SWEP.Primary.Damage = math.random(20, 30)                     
SWEP.Primary.TakeAmmo = 1                 
SWEP.Primary.ClipSize = 2             
SWEP.Primary.Ammo = "12x70"               
SWEP.Primary.DefaultClip = 2            
SWEP.Primary.Spread = 1                    
SWEP.Primary.NumberofShots = math.random(4, 6)                    
SWEP.Primary.Automatic = false           
SWEP.Primary.Recoil = 4 
SWEP.Primary.AngVelocity = Angle(0,0,0)             
SWEP.Primary.Delay = 0.15                   
SWEP.Primary.Force = 0                      

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
SWEP.ReloadSound = "ssk/weapons/bm16_reload_lr.wav"
SWEP.ReloadLeftSound = "ssk/weapons/bm16_reload_l.wav"
SWEP.Anim = {}
SWEP.Anim.Reload = "ACT_VM_RELOAD"
SWEP.Anim.ReloadLeft = "ACT_VM_RELOAD_SINGLE"

function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound(self.Secondary.Sound)
	util.PrecacheSound(self.ReloadSound)
	util.PrecacheSound(self.ReloadLeftSound)
	self:SetNWFloat("NextIdle", 0)
	self:SetNWFloat("Zoom", 0)
	self.Weapon:SetNetworkedBool("Reloading",false)
	if ( SERVER ) then
		self:SetHoldType( self.HoldType )
	end
end
//SWEP:Initialize()\\
	function SWEP:Deploy()
		self.Weapon:SendWeaponAnim(ACT_RANGE_ATTACK_SHOTGUN)
	end
//SWEP:PrimaryFire()\\
function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	if (self.Owner:GetActiveWeapon():Clip1() == 2) then
		self:PlayAnimation("shot_l", 1)
	elseif (self.Owner:GetActiveWeapon():Clip1() == 1) then
		self:PlayAnimation("shot_r", 1)
	end
		self.Owner:MuzzleFlash()
		local bullet = {}
			bullet.Num = self.Primary.NumberofShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( self.Primary.Spread * 0.25 , self.Primary.Spread * 0.25, 0)
			bullet.Tracer = 1
			bullet.Distance = 1111
			bullet.Damage = self.Primary.Damage
			bullet.AmmoType = self.Primary.Ammo
		local rnda = self.Primary.Recoil * -1
		local rndb = self.Primary.Recoil * math.random(-1, 1)
		self:ShootEffects()
		self.Owner:FireBullets( bullet )
		self.Weapon:EmitSound(Sound(self.Primary.Sound))
		self.Owner:ViewPunch( Angle( -8.5,0,0 ) )
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:UpdateNextIdle()
end
//SWEP:PrimaryFire()\\

function SWEP:PreDrawViewModel(viewModel, weapon, client)
end
function SWEP:Reload() 
	if self.Owner:GetAmmoCount( self.Primary.Ammo ) == 0 then return end if (self.Owner:GetActiveWeapon():Clip1() == self.Primary.ClipSize) then return end
	if (self.Weapon:Clip1() > self.Primary.ClipSize) then
		self.Weapon:SetClip1(self.Primary.ClipSize)
	end
	if (self.Weapon:Clip1() < 2 and self.Weapon:GetNetworkedBool("Reloading") == false) then
		local vm = self.Owner:GetViewModel()
		self.Weapon:SetNetworkedBool("Reloading",true)
		if (self.Weapon:Clip1() == 0) then
			self:DoReload("reload")
			self.Weapon:EmitSound(Sound(self.ReloadSound))
		elseif (self.Weapon:Clip1() == 1) then
			self:DoReload("reload_one")
			self.Weapon:EmitSound(Sound(self.ReloadLeftSound))
		end
	    self:UpdateNextIdle()
	    self:SetIronsights(false)
	    self:SetNWBool( "ZOOM", false )
	    self.Owner:SetFOV( 0, 0.35 ) 
	end
	return
end
function SWEP:DoReload(anim)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	self:PlayAnimation( anim, 1 )
	local vm = self.Owner:GetViewModel()
	local seq,dur = vm:LookupSequence(anim)
	self.Weapon:SetNextPrimaryFire( CurTime() + dur )
  	timer.Simple(dur, function()
		if (self.Owner:GetActiveWeapon():Clip1() == 0) then
			local ammo = self.Owner:GetActiveWeapon():Clip2()
			self.Owner:RemoveAmmo(2, "ssk12x70ssk")
			self:SetClip1(2)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 1) then
			local ammo = self.Owner:GetActiveWeapon():Clip2()
			self.Owner:RemoveAmmo(1, "ssk12x70ssk")
			self:SetClip1(2)
		end
		self:UpdateNextIdle()
		self.Weapon:SetNetworkedBool("Reloading",false)
  	end)
end


function SWEP:CustomReload()

end

function SWEP:SecondaryAttack()
	return false
end
SWEP.VmPos, SWEP.VmAng = Vector(3,0,-4), Angle(0,0,0)
SWEP.VmPos2, SWEP.VmAng2 = Vector(7.5,0,-2.5), Angle(0,0,0)
function SWEP:GetViewModelPosition( pos, ang )
	if (self:GetNWBool( "ZOOM" ) == false) then
		Right = ang:Right()
		Up = ang:Up()
		Forward = ang:Forward()
		pos = pos + self.VmPos.x * Right
		pos = pos + self.VmPos.y * Forward
		pos = pos + self.VmPos.z * Up
	else
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
		if (self.Owner:GetActiveWeapon():Clip1() == 2) then
			self:PlayAnimation("idle", 0)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 1) then
			self:PlayAnimation("idle_l", 0)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 0) then
			self:PlayAnimation("idle_lr", 0)
		end
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
	if self.Weapon:GetNetworkedBool("Reloading") == true then return end
	if ((self.Owner:KeyDown( IN_ATTACK2 ) and !ZOOM)) and self:CanNextAction() and self.Owner:OnGround() and !self.Owner:KeyDown( IN_SPEED ) then
		self:SetIronsights( true )
		NextAim = CurTime() + 0.15
		self.Owner:SetFOV( 75, 0.35 ) 
		if (self.Owner:GetActiveWeapon():Clip1() == 2) then
			self:PlayAnimation("idle", 0)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 1) then
			self:PlayAnimation("idle_l", 0)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 0) then
			self:PlayAnimation("idle_lr", 0)
		end
	end
	if (!self.Owner:KeyDown( IN_ATTACK2 ) and ZOOM) or (!self.Owner:OnGround() and ZOOM) or (ZOOM and self.Owner:KeyDown( IN_SPEED )) then
		self:SetIronsights( false )
		NextAim = CurTime() + 0.15
		self.Owner:SetFOV( 0, 0.35 ) 
		if (self.Owner:GetActiveWeapon():Clip1() == 2) then
			self:PlayAnimation("idle", 1)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 1) then
			self:PlayAnimation("idle_l", 1)
		elseif (self.Owner:GetActiveWeapon():Clip1() == 0) then
			self:PlayAnimation("idle_lr", 1)
		end
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