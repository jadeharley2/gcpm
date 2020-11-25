 
AddCSLuaFile("init.lua")
AddCSLuaFile("variables.lua")
AddCSLuaFile("resources.lua")
AddCSLuaFile("pony_player.lua")
AddCSLuaFile("net.lua")
AddCSLuaFile("ccmark_sys.lua")
AddCSLuaFile("preset.lua")
AddCSLuaFile("presets_base.lua")
AddCSLuaFile("render_texture.lua")
AddCSLuaFile("render_v2.lua")
AddCSLuaFile("bonesystem.lua")
AddCSLuaFile("editor.lua")
AddCSLuaFile("editor3.lua")
AddCSLuaFile("editor3_body.lua")


PPM = {} 
PONYPM.PPM = PPM
PPM.isLoaded =false
 
include("variables.lua")
include("pony_player.lua")
include("resources.lua")
include("net.lua")
include("ccmark_sys.lua")
if CLIENT then  
 
    include("render_texture.lua")
    include("render_v2.lua")
    include("bonesystem.lua")
    include("preset.lua")
    include("editor.lua")
    include("editor3.lua")
    include("editor3_body.lua")
    include("editor3_presets.lua")
    include("presets_base.lua")
end    
if SERVER then  
end
