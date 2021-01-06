
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
        net.Start("gcpm_data")
        net.WriteEntity(ent)
        net.WriteTable(data)
        net.Broadcast()
    end
    net.Receive("gcpm_data", function(len,ply)
        local data = net.ReadTable()
        ApplyData(ply,data)
    end)
end





function Update(ent)
    local data = ent.gcpmdata
    if data then
        local species = GetSpecies(data.species)
        if species then
            hook.Run("GCPMUpdate",ent,data,species)
        end
    end
end


--[[ SPECIES ]]

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
function GetPart(data,ptype,pvalue)
    local parts = GetParts(data,ptype)
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
if CLIENT then
    include("gcpm/client/ximagebutton.lua")
    include("gcpm/client/panels.lua")
    include("gcpm/client/background.lua")
    include("gcpm/client/editor.lua")
    
    include("gcpm/processors/part.lua")
    include("gcpm/processors/texture.lua")
end


MsgN("gcpm init finished")
