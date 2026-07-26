CreateThread(function()
	plsr.Callbacks:RegisterClientCallback("Commands:SS", function(d, cb)
		exports["screenshot-basic"]:requestScreenshotUpload(
			string.format("https://discord.com/api/webhooks/%s", d),
			"files[]",
			function(data)
				local image = json.decode(data)
				cb(json.encode({ url = image.attachments[1].proxy_url }))
			end
		)
	end)
end)

AddEventHandler("Proxy:Shared:RegisterReady", function()
	exports["pulsar_core"]:RegisterComponent("Commands", CMDS)
end)

CMDS = {}

RegisterNetEvent("Commands:Client:TeleportToMarker", function()
	local WaypointHandle = GetFirstBlipInfoId(8)
	if DoesBlipExist(WaypointHandle) then
		local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
				break
			end

			Wait(5)
		end
		plsr.Notification:Success("Teleported")
	else
		plsr.Notification:Error("Please place your waypoint.")
	end
end)
