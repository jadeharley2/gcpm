
AddCSLuaFile()
module( "gcpm", package.seeall )

species = {} -- species or {}
species_models = {}

--[[ SPECIES ]]
function InitSpeciesParams(ent)
    --if IsValid(ent) then
        local data = ent.gcpmdata or {}
        if data.species then
            local species = GetSpecies(data.species)
            if species then 
                if species.Parameters then
                    for k,v in pairs(species.Parameters) do
                        if data[k] == nil then
                            data[k] = v.default 
                        end 
                    end
                end
                if species.Parts then
                    for k,v in pairs(species.Parts) do
                        if v.default and data[k] == nil then
                            data[k] = v.default
                        end
                    end
                end
            end 
            ent.gcpmdata = data
        end
    --else
    --    MsgN(ent," ??? ")
    --end
end
function HasSpeciesModel(ent)
    local model = ent:GetModel()
    local key = species_models[model]
    return key~=nil
end

function AddSpecies(id,data)
    species[id] = data 
    for k,v in pairs(data.Models) do
        local p = data.Directory .."/".. v.File
        species_models[p] = id
    end
end
function GetSpeciesByModel(model)
    if TypeID(model) == TYPE_ENTITY then
        model = model:GetModel()
    end
    local key = species_models[model]
    if key then
        return GetSpecies(key)
    end
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