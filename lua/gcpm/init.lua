
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


LoadSpecies()


AddCSLuaFile("gcpm/client/editor.lua")
AddCSLuaFile("gcpm/client/background.lua")
AddCSLuaFile("gcpm/client/panels.lua")

if CLIENT then
    include("gcpm/client/panels.lua")
    include("gcpm/client/background.lua")
    include("gcpm/client/editor.lua")
end


MsgN("gcpm init finished")
