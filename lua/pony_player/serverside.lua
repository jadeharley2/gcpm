if(SERVER) then  
	util.AddNetworkString( "player_equip_item" )
	util.AddNetworkString( "player_pony_cm_send" )
	//util.AddNetworkString( "player_pony_set_charpars" )
	
	net.Receive( "player_equip_item", function(len, ply)    
		local id =net.ReadFloat()
		local item =PONYPM:pi_GetItemById(id)
		if(item!=nil)then
			PPM.setupPony(ply,false)
			PONYPM:pi_SetupItem(item,ply)  
		end
	end)  
	/*
	BODYGROUP_BODY = 1
	BODYGROUP_HORN = 2
	BODYGROUP_WING = 3
	BODYGROUP_MANE = 4
	BODYGROUP_TAIL = 5
	BODYGROUP_CMARK = 6


	net.Receive( "player_pony_set_charpars", function(len, ply)    
		ply.pny_kind = net.ReadFloat()
		ply.pny_gender = net.ReadFloat()
		ply.pny_body_type = net.ReadFloat()
		
		ply.pny_mane = net.ReadFloat()
		ply.pny_tail = net.ReadFloat()
		ply.pny_eye = net.ReadFloat()
		
		ply.pny_haircolor1 = net.ReadVector()
		ply.pny_haircolor2 = net.ReadVector()
		ply.pny_coatcolor = net.ReadVector()
		
		ply.pny_cmark = net.ReadFloat()
		
		PlayerSetValues( ply )
	end)  
	function PlayerSetValues( ply )
		ply:SetNetworkedFloat("pny_kind",ply.pny_kind)
		ply:SetNetworkedFloat("pny_gender",ply.pny_gender)
		ply:SetNetworkedFloat("pny_body_type",ply.pny_body_type)
		
		ply:SetNetworkedFloat("pny_mane",ply.pny_mane)
		ply:SetNetworkedFloat("pny_tail",ply.pny_tail)
		ply:SetNetworkedFloat("pny_eye",ply.pny_eye)
		
		ply:SetNetworkedVector("pny_haircolor1",ply.pny_haircolor1)
		ply:SetNetworkedVector("pny_haircolor2",ply.pny_haircolor2)
		ply:SetNetworkedVector("pny_coatcolor",ply.pny_coatcolor)
		
		ply:SetNetworkedFloat("pny_cmark",ply.pny_cmark)
		
		if(ply.pny_kind==1) then
			ply:SetBodygroup(BODYGROUP_HORN,1)//h
			ply:SetBodygroup(BODYGROUP_WING,1)//w
		elseif(ply.pny_kind==2)then
			ply:SetBodygroup(BODYGROUP_HORN,1) 
			ply:SetBodygroup(BODYGROUP_WING,0) 
		elseif(ply.pny_kind==3)then   
			ply:SetBodygroup(BODYGROUP_HORN,0) 
			ply:SetBodygroup(BODYGROUP_WING,1) 
		else
			ply:SetBodygroup(BODYGROUP_HORN,0) 
			ply:SetBodygroup(BODYGROUP_WING,0) 
		end
		
		if(ply.pny_mane!=nil)then
			ply:SetBodygroup(BODYGROUP_MANE,ply.pny_mane-1) 
			ply:SetBodygroup(BODYGROUP_TAIL,ply.pny_tail-1) 
		end
	
		/*
		MsgN(ply.pny_kind)
		MsgN(ply.pny_gender)
		MsgN(ply.pny_body_type)
		MsgN(ply.pny_mane)
		MsgN(ply.pny_tail)
		MsgN(ply.pny_haircolor1)
		MsgN(ply.pny_haircolor2)
		MsgN(ply.pny_coatcolor)
	end
		*/
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
	MsgN("Loaded pony_player\\serverside.lua");
 end