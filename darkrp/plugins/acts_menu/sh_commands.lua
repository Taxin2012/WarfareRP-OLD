nut.command.add("acts", {
	onRun = function(client, arguments)
		if (client:Alive()) then
			netstream.Start(client, "nutActsMenu")
		end
	end
})