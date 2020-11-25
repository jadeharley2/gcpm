TOOL.Category		= "CPPM"
TOOL.Name			= "Ragdoll/NPC Setup"
TOOL.Command		= nil
TOOL.ConfigName		= ""
TOOL.Tab			= "Options"

if ( CLIENT ) then
	language.Add( "Tool.ppm_ponysetup.name", "Pony setup tool" )
	language.Add( "Tool.ppm_ponysetup.desc", "Setup Pony Ragdoll or NPC with your settings." )
	language.Add( "Tool.ppm_ponysetup.0", "Left: Paste settings.   Right: Copy settings.   Reload: Paste player settings" )
 
end
function TOOL:LeftClick(trace)
	local ent = trace.Entity
	if (!ent) then return end 
	if (CLIENT) then return true end
	local ply = self:GetOwner()
	ply.tool_ponydatapaster= ply.tool_ponydatapaster or {}
	PPM.setupPony(ply.tool_ponydatapaster,true)
		if (ent:IsNPC()) or (ent:GetClass()=="prop_ragdoll") then 
			 
			if PPM.isValidPonyLight(ent) then 
				 
				PPM.copyLocalPonyTo(ply.tool_ponydatapaster,ent) 
				PPM.setupPony(ent)
				PPM.setBodygroups(ent)
				PPM.setPonyValues(ent)
				return true 
				 
			end
		elseif(ent:IsPlayer()) then 
			if(ply:IsAdmin()and PPM.isValidPonyLight(ent)) then
				PPM.copyLocalPonyTo(ply.tool_ponydatapaster,ent) 
				PPM.setupPony(ent)
				PPM.setBodygroups(ent)
				PPM.setPonyValues(ent)
				return true 
			end
		end  
	return false 
end
function TOOL:RightClick(trace)
	local ent = trace.Entity
	if (!ent) then return end 
	if (CLIENT) then return true end
	local ply = self:GetOwner()
	ply.tool_ponydatapaster= ply.tool_ponydatapaster or {}
	PPM.setupPony(ply.tool_ponydatapaster,true)
		
	if (ent:IsNPC()) or (ent:GetClass()=="prop_ragdoll") then 
		 
		if PPM.isValidPonyLight(ent) then 
			PPM.copyPonyTo(ent,ply.tool_ponydatapaster) 
			 
			return true 
		end
	elseif(ent:IsPlayer()) then 
		if(ply:IsAdmin()and PPM.isValidPonyLight(ent)) then
			PPM.copyPonyTo(ent,ply.tool_ponydatapaster)  
			return true 
		end
	end
	return false 
end
function TOOL:Reload(trace)
	local ent = trace.Entity
	if (!ent) then return end 
	if (CLIENT) then return true end
	local ply = self:GetOwner()
	if (ent:IsNPC()) or (ent:GetClass()=="prop_ragdoll") then 
		 
		if PPM.isValidPonyLight(ent) then 
				PPM.copyPonyTo(ply,ent) 
				PPM.setupPony(ent)
				PPM.setBodygroups(ent)
				PPM.setPonyValues(ent)
				
			 
			return true 
		end
	elseif(ent:IsPlayer()) then 
		if(ply:IsAdmin()and PPM.isValidPonyLight(ent)) then
			PPM.copyLocalPonyTo(ply.tool_ponydatapaster,ent) 
			PPM.setupPony(ent)
			PPM.setBodygroups(ent)
			PPM.setPonyValues(ent)
			return true 
		end
	end
	return false 
end

function TOOL.BuildCPanel(panel) 
	panel:AddControl("Header", { Text = "#Tool.ppm_ponysetup.name", Description = "#Tool.ppm_ponysetup.desc" })
	panel:Button(
		"Spawn Pony Base Ragdoll",
		"ppm_spawn_pragdoll"
	)
	panel:Button(
		"Spawn Pony Base NPC",
		"ppm_spawn_pnpc"
	)
	 
end