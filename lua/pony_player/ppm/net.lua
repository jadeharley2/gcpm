
ppm_enable_autoload = CreateConVar( "ppm_enable_autoload","1", FCVAR_ARCHIVE , "use 0 to block preset autoload",0,1 )


if CLIENT then
	function PPM.SendCharToServer(ent,autoload) 
		net.Start("player_pony_set_charpars")
		net.WriteEntity(ent)
		net.WriteTable(ent.ponydata) 
		net.WriteBool(autoload or false)
		net.SendToServer()
	end  
	net.Receive( "ppm_cleanup", function() 
		local ent = net.ReadEntity()   
		PPM.cleanup(ent)  
	end) 
end
if SERVER then 
	util.AddNetworkString( "player_pony_set_charpars" ) 
	util.AddNetworkString( "ppm_cleanup" ) 
	
	net.Receive( "player_pony_set_charpars", function(len, ply)
		local ent = ply
		local ent = net.ReadEntity() -- ents.GetByIndex( math.floor(net.ReadFloat()) )
		local data = net.ReadTable()
		local isautoload = net.ReadBool()
		if not isautoload or ppm_enable_autoload:GetBool() then
			if hook.Run("PlayerSetupPony",ent,data,isautoload)~=false then 
				ent.ponydata = data
				PPM.setupPony(ent) 
				PPM.setPonyValues(ent) 
				PPM.setBodygroups(ent)
			end
		end
	end) 
end
