
PONYPM = PONYPM or {}

include("items.lua")
AddCSLuaFile("init.lua")
AddCSLuaFile("items.lua")
AddCSLuaFile("gui_toolpanel.lua")
//AddCSLuaFile("gui_ponyeditor.lua")
AddCSLuaFile("gui_equip.lua")
AddCSLuaFile("presets.lua")

include("ppm/init.lua")
if CLIENT then 

PONYPM_CL = PONYPM_CL or {}
include("gui_toolpanel.lua") 
include("gui_equip.lua") 
//include("gui_ponyeditor.lua") 
//include("presets.lua")
end 
if SERVER then 
PONYPM_SV = PONYPM_SV or {}
include("serverside.lua")
end
 
concommand.Add("print_hooks",function( ply )
	local tableC =hook.GetTable()  
		for name, hookoV in SortedPairs( tableC ) do	
			
			MsgN(name .. "  -  " )
			for ov_name, ccc in SortedPairs( hookoV ) do
			
			MsgN("     -  "..ov_name )
			end
		end 
end) 
 MsgN("Loaded pony_player\\init.lua");