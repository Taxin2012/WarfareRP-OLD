local PLUGIN = PLUGIN
PLUGIN.name = "Ambient Sounds"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "Ambient Sounds"

PLUGIN.config = {}
PLUGIN.config.activated = true

if CLIENT then

	PLUGIN.timeData = {
	}
	PLUGIN.sndWind = nil
	PLUGIN.sndInternal = nil
	
	function PLUGIN:Think()
		if (game.GetMap() == "rp_army_warehouses_v1a") then
		PLUGIN.sndWind = PLUGIN.sndWind or CreateSound( LocalPlayer(), "snd/armysclad/amb05.ogg" )
		end
		if (game.GetMap() == "rp_garbage_shoc") then
		PLUGIN.sndWind = PLUGIN.sndWind or CreateSound( LocalPlayer(), "snd/svalka/amb03.ogg" )
		end
		if (game.GetMap() == "rp_rostok_v1") then
		PLUGIN.sndWind = PLUGIN.sndWind or CreateSound( LocalPlayer(), "snd/bar/amb01.ogg" )
		end
		if (game.GetMap() == "rp_agroprom") then
		PLUGIN.sndWind = PLUGIN.sndWind or CreateSound( LocalPlayer(), "snd/agroprom/amb08.ogg" )
		end
		PLUGIN.sndInternal = PLUGIN.sndInternal or CreateSound( LocalPlayer(), "" )
		
		if !self.timeData.sndGunshot or self.timeData.sndGunshot < CurTime() then
			surface.PlaySound( Format( "", math.random( 1, 15 ) ) )
			self.timeData.sndGunshot = CurTime() + math.random( 10, 120 )
		end
		if !self.timeData.sndMarch or self.timeData.sndMarch < CurTime() then
			surface.PlaySound( Format( "", math.random( 1, 15 ) ) )
			self.timeData.sndMarch = CurTime() + math.random( 30, 440 )
		end
		
		local data = {}
			data.start = LocalPlayer():GetShootPos()
			data.endpos = data.start + Vector( 0, 0, 10000 )
			data.filter = LocalPlayer()
		local trace = util.TraceLine(data)
		if trace.HitSky then
			if !self.sndWind:IsPlaying() then
				self.sndWind:Play()
			end
			self.sndWind:ChangeVolume( .2, 0.2 )
			self.sndInternal:ChangeVolume( 0, 0.5 )
		else
			if !self.sndInternal:IsPlaying() then
				self.sndInternal:Play()
			end
			self.sndWind:ChangeVolume( 0, 0.5 )
			self.sndInternal:ChangeVolume( 1, 1 )
		end
	end
	
end