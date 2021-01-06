 
local function GetValue(species,data,key)
    local val = data[key]
    if val then
        return val
    end
    local def = species.Parameters[key]
    if def then
        return def.default
    end
end
local empty = {}

local function PrepareProceduralMat(species,data,matdata)
    local nt = {}
    for k,v in pairs(matdata) do
        if isstring(v)  then
            local first = string.sub(v, 1, 1)
            local key = string.sub(v, 2)
            if first == '$' then
                local value = GetValue(species,data,key)  
                assert(value, "NOVALUE "..key)
                nt[k] = value
            elseif first == '@' then
                local key = string.sub(v, 2)
                local code = "return "..key
                local func = CompileString(code, "procedural_material", false)
                debug.setfenv(func, data)
                local value = func() 
                nt[k] = value
            else
                nt[k] = v
            end
        elseif istable(v) then
            nt[k] = PrepareProceduralMat(species,data,v)
        else
            nt[k] = v
        end
    end
    return nt
end
local function GetMaterial(species,data,eid,k,m)
    local material = nil
    if istable(m) then
        
        if m.mode == "procedural" then
            local ttarget = m.target
            if ttarget then
                ttarget = '$'..ttarget
            end

            local name = "x5_"..eid..k
            local prepm = PrepareProceduralMat(species, data,m)
            local mat = gcpm.RequestMaterial(name,prepm, m.shader or "VertexLitGeneric",{
                ["$model"] = 1,
            },ttarget)
            material = '!'..name 
        elseif m.mode=="color" then
            if istable(m.params) then
                material = {}
                for id,v in pairs(m.params) do
                    local value = GetValue(species,data,v) or Color(0,0,0)
                    local name = "x4_"..eid..k.."_"..id
                    local cm = CreateMaterial(name, m.shader or "VertexLitGeneric", {
                        --["$basetexture"] = "",
                        ["$color2"] = value,
                        ["$model"] = 1,
                    })
                    cm:SetVector( "$color2", Vector(value.r/255 ,value.g/255 ,value.b/255))
                    cm:Recompute()
                    material[id] =  '!'..name
                    MsgN("heck ",id," - ",name," = ",Vector(value.r/255 ,value.g/255 ,value.b/255))
                end
            else
                local value = GetValue(species,data,m.params) or Color(0,0,0)
                local name = "x4_"..eid..k 
                local cm = CreateMaterial(name, m.shader or "VertexLitGeneric", {
                    --["$basetexture"] = "",
                    ["$color2"] = value,
                    ["$model"] = 1,
                })
                MsgN("WTF? ",value)
                cm:SetVector( "$color2", Vector(value.r/255 ,value.g/255 ,value.b/255))
                cm:Recompute()
                material =  '!'..name
            end
             
        end
    end
    return material
end
hook.Add("GCPMUpdate", "parts", function(ent,data,species) 
	local bpdata = ent.gcpm_bpdata or {}
	ent.gcpm_bpdata = bpdata

    local eid = ent:EntIndex()
    local Race = species.Races[data.race] or {}
    for k,v in pairs(species.Parts) do
        local pdata = (Race.Parts or empty)[k] 
        if not pdata then
            local pvalue = data[k]
            if pvalue then
                pdata = v.variants[pvalue]
            end
        end

        local bpent = bpdata[k]

         
        if pdata and pdata.model then
            if not IsValid(bpent) then
                bpent = ents.CreateClientside("cpm_bodypart")
            end
            local mpath = species.PartsDirectory .. '/' .. pdata.model
            if not string.EndsWith(mpath, ".mdl") then
                mpath = mpath .. '.mdl'
            end

            local color = nil
 
            if v.tint then 
                color = GetValue(species,data,v.tint)  
            end
            local m = pdata.material
            local material = nil
            if m then
                material = GetMaterial(species,data,eid,k,m)
            end
 
            bpent:Set(ent, mpath, color, material) 
        else
            if IsValid(bpent) then
                bpent:Remove()
                bpent = nil
            end
        end

        bpdata[k] = bpent
    end


    if species.Body then
        for k,v in pairs(species.Body.materials) do
            local bodymat = nil
            if v.mode=="procedural" then
                bodymat = GetMaterial(species,data,eid,'body'..k,v)
            end
            ent:SetSubMaterial(k-1,bodymat) 
        end
    else
        ent:SetMaterial(nil)
    end
end)