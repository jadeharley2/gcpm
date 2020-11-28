if(SERVER) then  
	util.AddNetworkString( "player_equip_item" )
	util.AddNetworkString( "player_pony_cm_send" )
	//util.AddNetworkString( "player_pony_set_charpars" )
	util.AddNetworkString( "ppm_request_fix" )
	
	net.Receive( "player_equip_item", function(len, ply)    
		local id =net.ReadFloat()
		local item =PONYPM:pi_GetItemById(id)
		if(item!=nil)then
			PPM.setupPony(ply,false)
			PONYPM:pi_SetupItem(item,ply)  
		end
	end)   
	function PlayerSetModel( ply )
	
		local newmodel =ply:GetInfo( "cl_playermodel" )
		
		if(table.HasValue(ponyarray_temp ,newmodel))then
			//ply:DrawWorldModel(false)
			//MsgN("HIDE!")
		end
		
		if newmodel!=ply.pi_prevplmodel then
			//MsgN("MODELCHANGED")
			PONYPM:pi_UnequipAll(ply)
			
			
			if(newmodel=="pony") or (newmodel=="ponynj")then
				if ply.ponydata==nil then
				PPM.setupPony(ply) end
				PPM.setPonyValues(ply) 
				PPM.setBodygroups(ply)
				
				if PPM.camoffcetenabled!=nil and PPM.camoffcetenabled:GetBool( ) then 
					ply:SetViewOffset(Vector(0,0,42))
					ply:SetViewOffsetDucked(Vector(0,0,32))
				end
			elseif(newmodel=="luna")or (newmodel=="lunanj")then
				if PPM.camoffcetenabled!=nil and PPM.camoffcetenabled:GetBool( ) then 
					ply:SetViewOffset(Vector(0,0,58)) 
					ply:SetViewOffsetDucked(Vector(0,0,49)) 
				end
			elseif(newmodel=="celestia" or newmodel=="molestia")or (newmodel=="celestianj")then
				if PPM.camoffcetenabled!=nil and PPM.camoffcetenabled:GetBool( ) then 
					ply:SetViewOffset(Vector(0,0,68)) 
					ply:SetViewOffsetDucked(Vector(0,0,59)) 
				end
			else
				if(table.HasValue(ponyarray_temp ,ply.pi_prevplmodel))then
					//if PPM.camoffcetenabled!=nil and PPM.camoffcetenabled:GetBool( ) then 
						ply:SetViewOffset(Vector(0,0,64)) 
						ply:SetViewOffsetDucked(Vector(0,0,28)) 
					//end
				end
			end
			
			ply.pi_prevplmodel=newmodel
		end
	end 
	net.Receive("ppm_request_fix",function(len,ply)
		for k=1,net.ReadInt(16) do
			local e = net.ReadEntity()
			if PPM.isValidPony(e) and e.ponydata then
				net.Start("ppm_data")
				net.WriteEntity(e)
				net.WriteTable(e.ponydata)
				net.Send(ply)
			else
				MsgN("invalid pony fix requested ",e, " by ",ply)
			end
		end
	end)
	function SendPonies(ply)
		for name, ent in pairs(ents.GetAll()) do
			if PPM.isValidPony(ent) and ent.ponydata then
				PPM.setupMaterials(ent)
				MsgN("pony sent ",ent)
				net.Start("ppm_data")
				net.WriteEntity(ent)
				net.WriteTable(ent.ponydata)
				if ply=="all" then
					if ent:IsPlayer() then 
						net.SendOmit(ent)
					else
						net.Broadcast()
					end
				else
					net.Send(ply)
				end
			end
		end 
	end
	function HOOK_PlayerSwitchWeapon(ply,oldwep,newwep)
		if(table.HasValue(ponyarray_temp ,ply:GetInfo( "cl_playermodel" ))) then 
			newwep:SetMaterial("Models/effects/vol_light001") 
		end
	end
	function HOOK_PlayerLeaveVehicle(  ply,  ent )
		if(table.HasValue(ponyarray_temp,ply:GetInfo( "cl_playermodel" ))) then
			if ply.ponydata!=nil and IsValid(ply.ponydata.clothes1) then
				local bdata = {}  
				for i=0, 14 do
					bdata[i] = ply.ponydata.clothes1:GetBodygroup(i)
					ply.ponydata.clothes1:SetBodygroup(i,0) 
				end    
				timer.Simple(0.2,function()
				for i=0, 14 do 
					ply.ponydata.clothes1:SetBodygroup(i,bdata[i]) 
				end end) 
			end 
		end 
	end
	ponyarray_temp = {"pony","ponynj","luna","lunanj","celestia","celestianj","molestia"}
	PPM.camoffcetenabled =CreateConVar( "ppm_enable_camerashift", "1" ,{ FCVAR_REPLICATED, FCVAR_ARCHIVE } , "Enables ViewOffset Setup"  )
	hook.Add("PlayerSetModel","items_Flush",PlayerSetModel)
	hook.Add("PlayerSwitchWeapon", "pony_weapons_autohide", HOOK_PlayerSwitchWeapon)
	hook.Add("PlayerLeaveVehicle", "pony_fixclothes", HOOK_PlayerLeaveVehicle) 
	
    hook.Add( "PlayerInitialSpawn", "ppm_FullLoadSetup", function( ply )
        hook.Add( "SetupMove", ply, function( self, ply, _, cmd )
            if self == ply and not cmd:IsForced() then
                hook.Run( "PlayerFullLoad", self )
                hook.Remove( "SetupMove", self )
            end
        end )
    end )
	hook.Add("PlayerFullLoad", "ppm_sendall", function(ply) 
		MsgN("SEND PONIES TO ",ply)
        SendPonies(ply)
	end)
	concommand.Add("ppm_resend", function() SendPonies("all") end)
	
	function PPMSWAP(p1,p2)
		if IsValid(p1) and IsValid(p2) and p1.ponydata and p2.ponydata then
			local pda = p1.ponydata
			local pdb = p2.ponydata
			p1.ponydata = pdb
			p2.ponydata = pda
			PPM.setPonyValues(p1)
			PPM.setPonyValues(p2)
			PPM.setBodygroups(p1)
			PPM.setBodygroups(p2)
		end
	end
	concommand.Add("ppm_swap", function(ply,cmd,args)
		local p1 = Player(tonumber(args[1]))
		local p2 = Player(tonumber(args[2]))
		PPMSWAP(p1,p2)
	
	end)
 end