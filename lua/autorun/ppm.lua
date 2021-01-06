 
player_manager.AddValidModel( "luna", "models/mlp/player_luna.mdl" ) 
player_manager.AddValidModel( "lunanj", "models/mlp/player_luna_nj.mdl" ) 
player_manager.AddValidModel( "celestia", "models/mlp/player_celestia.mdl" ) 
player_manager.AddValidModel( "celestianj", "models/mlp/player_celestia_nj.mdl" ) 
player_manager.AddValidModel( "molestia", "models/mlp/player_molestia.mdl" )
player_manager.AddValidModel( "pony", "models/mlp/player_default_base.mdl" ) 
player_manager.AddValidModel( "ponynj", "models/mlp/player_default_base_nj.mdl" )   
 
player_manager.AddValidHands("luna","models/mlp/v_hoofs.mdl", 2, "00000000")
player_manager.AddValidHands("lunanj","models/mlp/v_hoofs.mdl", 2, "00000000")
player_manager.AddValidHands("celestia","models/mlp/v_hoofs.mdl", 1, "00000000")
player_manager.AddValidHands("celestianj","models/mlp/v_hoofs.mdl", 1, "00000000")
player_manager.AddValidHands("molestia","models/mlp/v_hoofs.mdl", 1, "00000000") 

player_manager.AddValidHands("pony","models/mlp/v_hoofs.mdl", 0, "00000000")
player_manager.AddValidHands("ponynj","models/mlp/v_hoofs.mdl", 0, "00000000")

if SERVER then		

	AddCSLuaFile("ppm.lua")
	local function add_files(dir)
		local files, folders = file.Find(dir .. "*", "LUA")
		
		for key, file_name in pairs(files) do
			AddCSLuaFile(dir .. file_name)
		end
		
		for key, folder_name in pairs(folders) do
			add_files(dir .. folder_name .. "/")
		end
	end
	
	add_files("pony_player/") 
end
if CLIENT then
	list.Set( "PlayerOptionsModel", "luna", "models/mlp/player_luna.mdl_nj" )
	list.Set( "PlayerOptionsModel", "lunanj", "models/mlp/player_luna.mdl" )
	list.Set( "PlayerOptionsModel", "celestia", "models/mlp/player_celestia.mdl" )
	list.Set( "PlayerOptionsModel", "celestianj", "models/mlp/player_celestia_nj.mdl" )
	list.Set( "PlayerOptionsModel", "molestia", "models/mlp/player_molestia.mdl" )
	list.Set( "PlayerOptionsModel", "pony", "models/mlp/player_default_base.mdl" ) 
	list.Set( "PlayerOptionsModel", "ponynj", "models/mlp/player_default_base_nj.mdl" ) 
 
end

include("pony_player/init.lua")   
include("pony_player/ppm/render_v2.lua")



include("gcpm/init.lua")  


for k,v in pairs(player.GetAll()) do
	for kk=0,20 do
		v:SetSubMaterial(kk,nil)
	end
end