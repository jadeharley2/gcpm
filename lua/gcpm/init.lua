
AddCSLuaFile()
module( "gcpm", package.seeall )




function IsCPM(ent)
    return IsValid(ent) and HasSpeciesModel(ent) -- ent.gcpmdata ~= nil
end

function Init(ent)
end

if SERVER then
    
	function SendCPlayers(ply)
		for name, ent in pairs(ents.GetAll()) do
			if ent.gcpmdata then 
				MsgN("gcpm sent ",ent)
				net.Start("gcpm_data")
                net.WriteEntity(ent)
                net.WriteTable(data) 
				if ply=="all" then
                    net.Broadcast()
				else
					net.Send(ply) 
				end
			end
		end 
    end
    
	hook.Add("PlayerFullLoad", "ppm_sendall", function(ply) 
		MsgN("SEND GCPM TO ",ply)
		SendCPlayers(ply) 
    end)
    concommand.Add("gcpm_resend", function() SendCPlayers("all") end)
    
    util.AddNetworkString("gcpm_data")
    function ValidateData(data,old)
        return data
    end
    function ApplyData(ent,data)
        ent.gcpmdata = ValidateData(data,ent.gcpmdata)
        
        local species = GetSpecies(data.species)
        if species then
            hook.Run("GCPMUpdate",ent,data,species)
        end

        net.Start("gcpm_data")
        net.WriteEntity(ent)
        net.WriteTable(data)
        net.Broadcast()
    end
    net.Receive("gcpm_data", function(len,ply)
        local ent = net.ReadEntity()
        local data = net.ReadTable()
        if ply==ent or ply:IsSuperAdmin() then
            ApplyData(ent,data)
        end
    end) 
    hook.Add( "PlayerSpawn", "GCPMPlySpawn", function( ply )
        if ply.gcpmdata then
            ApplyData(ply,ply.gcpmdata)
            net.Start("gcpm_event")
            net.WriteInt(10, 8)
            net.WriteEntity(ply)
            net.Broadcast()
        end
    end )
elseif CLIENT then

    function HideParts(ent,hide)
        for k,v in pairs(CLIENTSIDE_ENTS) do
            if v.Parent == ent then 
                v:SetNoDraw(hide)
            end
        end
    end

    function SetData(ent,data)
        if istable(data) then
            net.Start("gcpm_data")
            net.WriteEntity(ent)
            net.WriteTable(data)
            net.SendToServer()
        end
    end
    net.Receive("gcpm_data", function(len,ply)
        local ent = net.ReadEntity()
        local data = net.ReadTable()
        ent.gcpmdata = data
        Update(ent)
    end)
    net.Receive("gcpm_event", function(len,ply)
        local eventid = net.ReadInt(8)
        local ent = net.ReadEntity() 
        MsgN("EVENT ",eventid," at ",ent)
        if eventid == 10 then
            HideParts(ent,false)
        end
    end)

	hook.Add( "CreateClientsideRagdoll", "gcpm_inherit", function( entity, ragdoll )
        ragdoll.gcpmdata = entity.gcpmdata
        if ragdoll.gcpmdata then
            Update(ragdoll) 
            HideParts(entity,true)
        end
	end )
	

    hook.Add( "InitPostEntity", "gcpm_loadsave", function() 
        local data = Load("_current")
        if data then 
            SetData(LocalPlayer(),data)
        end
    end )

end





function Update(ent)
    local data = ent.gcpmdata
    if data then
        local species = GetSpecies(data.species)
        if species then
            hook.Run("GCPMUpdate",ent,data,species)
        end
        ent:CallOnRemove("GCPMPartsRemove",function(ent) 
            timer.Simple(0.03, function() 
                for k,v in pairs(CLIENTSIDE_ENTS) do 
                    if IsValid(v) then
                        if not IsValid(v.Parent) then
                            v:Remove()
                            CLIENTSIDE_ENTS[k] = nil
                        end
                    else
                        CLIENTSIDE_ENTS[k] = nil
                    end
                end  
            end)
        end)
        if SERVER then
            net.Start("gcpm_data")
            net.WriteEntity(ent)
            net.WriteTable(data)
            net.Broadcast()
        end
    end
end


local directory = "gcpm/"
file.CreateDir(directory)
function Load(filename)
    MsgN("load from ",directory..filename..'.json')
    if file.Exists(directory..filename..'.json', "DATA") then
        local json = file.Read(directory..filename..'.json', "DATA")
        return util.JSONToTable(json)
    end
end
function Save(filename,data)
    local json = util.TableToJSON(data,true)
    file.Write(directory..filename..'.json', json)
    MsgN("save to ",directory..filename..'.json')
end
function ListPresets()
    local t = {}
    for k,v in ipairs(file.Find(directory.."*.json", "DATA","nameasc")) do
        if string.sub(v, 1, 1) ~= '_' then
            t[#t+1] = string.sub(v, 1, -6)
        end
    end
    return t
end



--[[ INIT ]]
 
AddCSLuaFile("gcpm/client/ximagebutton.lua")
AddCSLuaFile("gcpm/client/editor.lua")
AddCSLuaFile("gcpm/client/background.lua")
AddCSLuaFile("gcpm/client/panels.lua")

AddCSLuaFile("gcpm/modules/species.lua")
AddCSLuaFile("gcpm/modules/part.lua")
AddCSLuaFile("gcpm/modules/texture.lua")
AddCSLuaFile("gcpm/modules/bodygroup.lua")
if CLIENT then
    include("gcpm/client/ximagebutton.lua")
    include("gcpm/client/panels.lua")
    include("gcpm/client/background.lua")
    include("gcpm/client/editor.lua")
    
    include("gcpm/modules/texture.lua")
end
include("gcpm/modules/species.lua")
include("gcpm/modules/part.lua")
include("gcpm/modules/bodygroup.lua")


MsgN("gcpm init finished")




--temp blink timer
if CLIENT then
    local function Blink(ent)
        if IsValid(ent) then
            local id = ent:EntIndex()
            ent.blinktarget = 1
            timer.Create("unblink"..id, 0.1, 1, function()
                ent.blinktarget = 0 
            end)
            timer.Create("gcpm_blink"..id, math.Rand(4.6, 7)*0.8, 1, function()  
                Blink(ent)
            end)
        end
    end
    local function StartBlink()
        for k,v in pairs(player.GetAll()) do 
            if IsCPM(v) then
                Blink(v)
            end
        end 
    end
    hook.Add( "InitPostEntity", "gcpm_blink", function() 
        timer.Create("gcpm_blink", 2, 1, function() 
            StartBlink()
        end)
    end )
    hook.Add("GCPMUpdate", "blinkStart", function(ent,data,species)
        Blink(ent)
    end)
    hook.Add("PrePlayerDraw", "gcpm_blink", function(ply, flags)
        local bt = ply.blinktarget
        if bt and ply:GetModel() == "models/mlp/pony_default/player_default_base.mdl" then 
            local bts = ply.blinktargetsmooth or 0
            bts = bts + (bt - bts) * 0.1
            ply.blinktargetsmooth = bts 

            local bl = ply:GetFlexIDByName("blink")
            ply:SetFlexWeight(bl, bts)
        end
    end)
    timer.Destroy("gcpm_blink")
    StartBlink()
end 

--temp noclip flight anim
if SERVER then 
    util.AddNetworkString("gcpm_event")
    hook.Add("PlayerNoClip", "gcpm_flight", function(ply,state)
        --net.Start("gcpm_event")
        --net.WriteUInt(1, 8)
        --net.WriteEntity(ply) 
        --net.WriteBit(state)
        --net.Broadcast()
--
        --MsgN("NOCLIPPP ",ply," = ",state)
    end)
else
    hook.Add("HandlePlayerNoClipping","gcpm_flight", function(ply,velocity)
        --local part = ply:GetCPPart("wings")
        --if part then
        --    part:SetState("open")
        --end 
    end)
    hook.Add("PlayerNoClip", "gcpm_flight", function(ply,state)  
        local part = ply:GetCPPart("wings")
        if part then
            if state then
                if part:GetState() == "closed" then
                    part:SetState("open") 
                else
                    return false 
                end
            else  
                part:SetState("close")  
            end
        end 
    end)
    --[[
    net.Receive("gcpm_event", function() 
        local eid = net.ReadUInt(8)
        local ply= net.ReadEntity()
        local state = net.ReadBit()

        if state == 1 then
            ply:GetCPPart("wings"):SetState("open")
            --ply:SetLayerSequence(21,seq)
        else --if ply.flight_layer then
            MsgN("?????")
            ply:GetCPPart("wings"):SetState("close")
           -- ply:SetLayerSequence(ply.flight_layer,0)
            --ply.flight_layer
        end
    end)]]
end



--player view position
if SERVER then
    function UpdateView(ply,attachment,mod,set) 
        local att = ply:LookupAttachment( attachment or "eyes" ) 
        if att > 0 then
            mod = mod or 0
            local eyes = ply:GetAttachment( att ).Pos
            local pp = ply:GetPos() 
            local diff = (set or eyes.Z-pp.Z)+mod
            print("eyes diff",diff,"=",eyes.Z,pp.Z,mod,set)
            ply:SetViewOffset(Vector(0,0,diff))
        end
    end
    --hook.Add("PlayerSpawn", "gcpm_update_view", function(ply)
    --    --UpdateView(ply)
    --end)
    hook.Add("PlayerSetModel", "gcpm_setup", function(ply)
        if IsCPM(ply) then
            return true
        end
    end) 
end