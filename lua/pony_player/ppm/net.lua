


if CLIENT then
	function PPM.SendCharToServer(ent) 
		net.Start("player_pony_set_charpars")
		net.WriteEntity(ent)
		net.WriteTable(ent.ponydata) 
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
		ent.ponydata = net.ReadTable()
		PPM.setupPony(ent) 
		PPM.setPonyValues(ent) 
		PPM.setBodygroups(ent)
	end) 
end