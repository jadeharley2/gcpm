
AddCSLuaFile()
module( "gcpm", package.seeall )

species = {} -- species or {}



function IsCPM(ent)

end

function Init(ent)
end

if SERVER then
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
        end
    end )
elseif CLIENT then

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

	hook.Add( "CreateClientsideRagdoll", "gcpm_inherit", function( entity, ragdoll )
        ragdoll.gcpmdata = entity.gcpmdata
        if ragdoll.gcpmdata then
            Update(ragdoll) 
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
    end
end


--[[ SPECIES ]]
function InitSpeciesParams(ent)
    --if IsValid(ent) then
        local data = ent.gcpmdata or {}
        if data.species then
            local species = GetSpecies(data.species)
            if species and species.Parameters then 
                for k,v in pairs(species.Parameters) do
                    if data[k] == nil then
                        data[k] = v.default 
                    end 
                end
            end

            ent.gcpmdata = data
        end
    --else
    --    MsgN(ent," ??? ")
    --end
end

function AddSpecies(id,data)
    species[id] = data 
end

function LoadSpecies()
    local function RecuInclude(dir) 
        local files, directories = file.Find( dir.."*.lua", "LUA" )
        for k,v in pairs(files) do  
            AddCSLuaFile(dir..v)
            include(dir..v)
        end
        for k,v in pairs(directories) do 
            RecuInclude(dir..v.."/")
        end
    end
    RecuInclude("gcpm/species/")
end

function GetSpecies(k)
    if k then
        return species[k] 
    end
end
function GetRace(data)
    local spc = GetSpecies(data.species)
    if spc then
        return spc.Races[data.race], spc
    end
end
function GetSpeciesList()
    return species
end
function GetParts(data,ptype)
    local species = GetSpecies(data.species)
    if species then
        local parts = species.Parts[ptype]
        if parts then
            return parts.variants or {}
        end
    end
    return {}
end
function GetTexParts(data,ptype)
    local species = GetSpecies(data.species)
    if species then
        local parts = species.TexParts[ptype]
        if parts then
            return parts.variants or {}
        end
    end
    return {}
end
function GetPart(data,ptype,pvalue)
    local parts = GetParts(data,ptype)
    if parts then
        return parts[pvalue] 
    end
    return nil
end
function GetTexPart(data,ptype,pvalue)
    local parts = GetTexParts(data,ptype) 
    if parts then
        return parts[pvalue] 
    end
    return nil
end
LoadSpecies()

--[[ INIT ]]
 
AddCSLuaFile("gcpm/client/ximagebutton.lua")
AddCSLuaFile("gcpm/client/editor.lua")
AddCSLuaFile("gcpm/client/background.lua")
AddCSLuaFile("gcpm/client/panels.lua")

AddCSLuaFile("gcpm/processors/part.lua")
AddCSLuaFile("gcpm/processors/texture.lua")
AddCSLuaFile("gcpm/processors/bodygroup.lua")
if CLIENT then
    include("gcpm/client/ximagebutton.lua")
    include("gcpm/client/panels.lua")
    include("gcpm/client/background.lua")
    include("gcpm/client/editor.lua")
    
    include("gcpm/processors/texture.lua")
end
include("gcpm/processors/part.lua")
include("gcpm/processors/bodygroup.lua")


MsgN("gcpm init finished")




--temp blink timer
if CLIENT then

    local function Blink(ent)
        if IsValid(ent) then
            ent.blinktarget = 1
            timer.Create("unblink", 0.1, 1, function()
                ent.blinktarget = 0 
            end)
        end
        timer.Create("gcpm_blink", math.Rand(4.6, 7), 1, function()  
            Blink(ent)
        end)
    end

    timer.Create("gcpm_blink", 2, 1, function() 
        local lp = LocalPlayer()
        Blink(lp)
    end)
    hook.Add("PrePlayerDraw", "gcpm_blink", function(ply, flags)
        local bt = ply.blinktarget
        if bt then 
            local bts = ply.blinktargetsmooth or 0
            bts = bts + (bt - bts) * 0.1
            ply.blinktargetsmooth = bts 

            local bl = ply:GetFlexIDByName("blink")
            ply:SetFlexWeight(bl, bts)
        end
    end)

end

--temp noclip flight anim
if SERVER then
    util.AddNetworkString("gcpm_event")
    hook.Add("PlayerNoClip", "gcpm_flight", function(ply,state)
        net.Start("gcpm_event")
        net.WriteUInt(1, 8)
        net.WriteEntity(ply)
        net.WriteBit(state)
        net.Broadcast()

        MsgN("NOCLIPPP ",ply," = ",state)
    end)
else
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
    end)
end