local PLUGIN = PLUGIN
PLUGIN.name = "Notes+"
PLUGIN.author = "AleXXX_007"
PLUGIN.desc = "Write text on notes and pick up them like items."
NOTELIMIT = 10000
WRITINGDATA = WRITINGDATA or {}

nut.util.include("cl_vgui.lua")
nut.util.include("cl_vgui1.lua")

if (CLIENT) then
	netstream.Hook("receiveNote", function(id, contents, write)
		local note = vgui.Create("noteRead")
		note:allowEdit(write)
		note:setText(contents)
		note.id = id
	end)
	--[[netstream.Hook("receiveNote1", function() --со свалки на агропром
		local note1 = vgui.Create("noteRead1")
	end)
	netstream.Hook("receiveNote2", function() --со свалки в бар
		local note2 = vgui.Create("noteRead2")
	end)
	netstream.Hook("receiveNote3", function() --с бара на армейские склады
		local note3 = vgui.Create("noteRead3")
	end)
	netstream.Hook("receiveNote4", function() --с бара на свалку
		local note4 = vgui.Create("noteRead4")
	end)
	netstream.Hook("receiveNote5", function() --с агропрома на свалку
		local note5 = vgui.Create("noteRead5")
	end)
	netstream.Hook("receiveNote6", function() --с армейских складов в бар
		local note6 = vgui.Create("noteRead6")
	end)]]
else	
	netstream.Hook("noteSendText", function(client, id, contents)
		if (string.len(contents) <= NOTELIMIT) then
			for k, v in pairs(nut.item.instances) do
				if v.uniqueID == "note" and v.id == id then
					v:setData("text", contents)
				end
			end
		end
	end)	
end
