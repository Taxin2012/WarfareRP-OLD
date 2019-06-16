if ( SERVER ) then

	AddCSLuaFile()

end

SWEP.AdminSpawnable = true                
SWEP.ViewModel = "models/weapons/ssk/spenser/v_ssk_win.mdl"    
SWEP.WorldModel = "models/weapons/ssk/spenser/w_ssk_win.mdl"  
SWEP.AutoSwitchTo = false                     
SWEP.Slot = 4                                
SWEP.HoldType = "ar2"   
SWEP.Type = "ar2"                     
SWEP.PrintName = "Чейзер-13"               
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
SWEP.ViewModelFOV		= 45
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
SWEP.Primary.Sound = "ssk/weapons/n_spas12_shot.wav"    
SWEP.Primary.Damage = math.random(25, 35)                   
SWEP.Primary.TakeAmmo = 1                 
SWEP.Primary.ClipSize = 7             
SWEP.Primary.Ammo = "12x70"               
SWEP.Primary.DefaultClip = 7            
SWEP.Primary.Spread = 0.75                      
SWEP.Primary.NumberofShots = math.random(4, 6)                  
SWEP.Primary.Automatic = false           
SWEP.Primary.Recoil = 2 
SWEP.Primary.AngVelocity = Angle(0,0,0)             
SWEP.Primary.Delay = 0.75               
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
SWEP.ReloadSound = "ssk/weapons/spas12_reload.wav"
SWEP.ReloadEnd = "ssk/weapons/spas12_reload_end.wav"
SWEP.Anim = {}
SWEP.Anim.Reload = "ACT_VM_RELOAD"
SWEP.Anim.ReloadStart = "ACT_SHOTGUN_RELOAD_START"
SWEP.Anim.ReloadEnd = "ACT_SHOTGUN_RELOAD_FINISH"
SWEP.Anim.PrimaryAttack = "ACT_RANGE_ATTACK_SHOTGUN"

function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound(self.Secondary.Sound)
	util.PrecacheSound(self.ReloadSound)
	util.PrecacheSound(self.ReloadEnd)
	self:SetNWFloat("NextIdle", 0)
	self:SetNWFloat("Zoom", 0)
	self:SetNWFloat("Reload", 0)
	self.Weapon:SetNetworkedBool("Reloading", false)
	self.Weapon:GetNetworkedInt("ReloadTime", CurTime())
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
		timer.Simple(0.3, function()
			if !IsValid(self.Owner) or !IsFirstTimePredicted() then return end
			local effectdata = EffectData()
				effectdata:SetEntity(self.Weapon)
				effectdata:SetNormal(self.Owner:GetAimVector())
			util.Effect("ShotgunShellEject", effectdata)
		end)
		self.ShotgunReloading = false
		self.Weapon:SetNetworkedBool("Reloading", false)
		self.Owner:MuzzleFlash()
		self.Weapon:SendWeaponAnim(ACT_RANGE_ATTACK_SHOTGUN)
		local bullet = {}
			bullet.Num = self.Primary.NumberofShots
			bullet.Spread = Vector( self.Primary.Spread * 0.25 , self.Primary.Spread * 0.25, 0)
			bullet.Distance = 1111
			bullet.Damage = self.Primary.Damage
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Tracer = 1
			bullet.AmmoType = self.Primary.Ammo
		local rnda = self.Primary.Recoil * -1
		local rndb = self.Primary.Recoil * math.random(-1, 1)
		self:ShootEffects()
		self.Owner:FireBullets( bullet )
		self.Weapon:EmitSound(Sound(self.Primary.Sound))
		self.Owner:ViewPunch( Angle( -10,0,0 ) )
		self:TakePrimaryAmmo(self.Primary.TakeAmmo)
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:UpdateNextIdle()
end
//SWEP:PrimaryFire()\\

function SWEP:PreDrawViewModel(viewModel, weapon, client)
end
SWEP.ShotgunReloading = false
SWEP.NextReload = CurTime()
function SWEP:Reload() 
	if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
			local vm = self.Owner:GetViewModel()
			local seq,dur = vm:LookupSequence("reload_s")
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
			self:UpdateNextIdle()
			--self.Weapon:SetNextPrimaryFire(CurTime() + dur)
			self.Weapon:SetNetworkedInt("ReloadTime", CurTime() + dur)
		timer.Simple(dur,function ()
			self.ShotgunReloading = true
			self.Weapon:SetNetworkedBool("Reloading", true)
			self:UpdateNextIdle()
		end)
	end
end

function SWEP:ShotThink()
	if (self.Weapon:Clip1() > self.Primary.ClipSize) then
		self.Weapon:SetClip1(self.Primary.ClipSize)
	end
	if (self.Weapon:GetNetworkedBool("Reloading") == true) then
		if (self.Weapon:GetNetworkedInt("ReloadTime") < CurTime()) then
			if (self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
				///
				local vm = self.Owner:GetViewModel()
				local seq,dur = vm:LookupSequence("reload_e")
				self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
				self.Weapon:EmitSound(Sound(self.ReloadEnd))
				self:UpdateNextIdle()
				--self.Weapon:SetNextPrimaryFire(CurTime() + dur)
				self.Weapon:SetNetworkedInt("ReloadTime", CurTime() + dur)
				self.Weapon:SetNetworkedBool("Reloading", false)
				///
			else
				local vm = self.Owner:GetViewModel()
				local seq,dur = vm:LookupSequence("reload")
				self:SendWeaponAnim(ACT_VM_RELOAD)
				self.Owner:SetAnimation(PLAYER_RELOAD)
				self.Weapon:EmitSound(Sound(self.ReloadSound))
				self:UpdateNextIdle()
				--self.Weapon:SetNextPrimaryFire(CurTime() + dur)
				self.Weapon:SetNetworkedInt("ReloadTime", CurTime() + dur)
				self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
				self.Weapon:SetClip1(self.Weapon:Clip1() + 1)
				///
			end
		end
	end
end



function SWEP:SecondaryAttack()
	return false
end

SWEP.VmPos, SWEP.VmAng = Vector(6,0,-4.3), Angle(0,0,0)
SWEP.VmPos2, SWEP.VmAng2 = Vector(3.1,0,1.5), Angle(0,0,0)
function SWEP:GetViewModelPosition( pos, ang )
		Right = ang:Right()
		Up = ang:Up()
		Forward = ang:Forward()
		pos = pos + self.VmPos.x * Right
		pos = pos + self.VmPos.y * Forward
		pos = pos + self.VmPos.z * Up
	if (self:GetNWBool( "ZOOM" ) == true) then
		ang:RotateAroundAxis( ang:Right(), 0.5 )
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
	self:ShotThink()
	////
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
	if self:GetNWFloat("Reload", 0) == 1 then return end
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