 
module( "gcpm", package.seeall )
CLIENTSIDE_ENTS = CLIENTSIDE_ENTS or {}

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

local switch = function(on,a,b)
    if on then 
        return a 
    end
    return b
end

GetDataValue = GetValue

function GetProcDataValue(species,data,v,def)
    local first = string.sub(v, 1, 1)
    local key = string.sub(v, 2)
    if first == '$' then
        local value = GetValue(species,data,key) or def
        assert(value~=nil, "NOVALUE "..key)
        return value
    elseif first == '@' then
        local key = string.sub(v, 2)
        local code = "return "..key
        local func = CompileString(code, "procedural_material", false)
        local env = {}
        for k,v in pairs(data) do env[k] = v end
        
        env.texture = function(pid,pval)
            local p = gcpm.GetTexPart(data,pid,pval) 
            if p then
                return p.material
            else
                return ""
            end
        end
        env.switch = switch

        debug.setfenv(func, env)
        local value = func() 
        return value
    else
        return v
    end 
end

local empty = {}

local function PrepareProceduralMat(species,data,matdata)
    local nt = {}
    for k,v in pairs(matdata) do
        if isstring(v)  then
            nt[k] = GetProcDataValue(species,data,v)
            --[[
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
                local env = {}
                for k,v in pairs(data) do env[k] = v end
                
                env.texture = function(pid,pval)
                    local p = gcpm.GetTexPart(data,pid,pval) 
                    if p then
                        return p.material
                    else
                        return ""
                    end
                end

                debug.setfenv(func, env)
                local value = func() 
                nt[k] = value
            else
                nt[k] = v
            end]]
        elseif istable(v) then
            nt[k] = PrepareProceduralMat(species,data,v)
        else
            nt[k] = v
        end
    end
    return nt
end
local procedural_prefix = "x3pc_"
local color_prefix = "x3cc_"

local function GetMaterial(species,data,eid,k,m,localmaterials)
    local material = nil
    --print("request mat ",species,data,eid,k,m,localmaterials)
    if isstring(m) then 
        local spmat = (localmaterials or {})[m] -- (species.Materials or {})[m]
        --MsgN("SPMAT ",m," = ",spmat)
        if spmat then
            return spmat
            --m = spmat
        end 
        
    end

    if istable(m) then 
        if m.mode == "procedural" then
            local ttarget = m.target
            if ttarget then
                ttarget = '$'..ttarget
            end 
            local name = procedural_prefix..eid..k
            if CLIENT then
                local prepm = PrepareProceduralMat(species, data,m)
                local matdata =  { 
                    ["$bumpmap"] = "models/mlp/base/render/body_n", 
                    ["$model"] = 1,
                }
                if species.MaterialBase then
                    for k,v in pairs(species.MaterialBase) do
                        if matdata[k] == nil then
                            matdata[k] = v 
                        end
                    end
                end
                if m.matdata then
                    for k,vv in pairs(m.matdata) do
                        matdata[k] = vv
                    end
                end

                local mat = gcpm.RequestMaterial(name,prepm, m.shader or "VertexLitGeneric",matdata,ttarget)
                --gcpm.SetupMaterial(mat,matdata)
                mat:Recompute()
            end
            material = '!'..name 
        elseif m.mode=="color" then
            if istable(m.params) then
                material = {}
                for id,v in pairs(m.params) do
                    local name = color_prefix..eid..k.."_"..id
                    if CLIENT then
                        local value = GetValue(species,data,v) or Color(0,0,0)
                        local prepm = PrepareProceduralMat(species, data,m)
                        local matdata =  {
                            --["$basetexture"] = "",
                            ["$bumpmap"] = "models/mlp/base/render/body_n",
                            ["$color2"] = value,
                            ["$model"] = 1,
                        }
                        if species.MaterialBase then
                            for k,v in pairs(species.MaterialBase) do
                                if matdata[k] == nil then
                                    matdata[k] = v
                                end
                            end
                        end
                        if m.matdata then
                            for k,vv in pairs(m.matdata) do
                                matdata[k] = vv
                            end
                        end
                        
                        local cm = CreateMaterial(name, m.shader or "VertexLitGeneric",matdata)
                        if prepm.texture then cm:SetTexture( "$basetexture", prepm.texture ) end
                        --gcpm.SetupMaterial(cm,matdata)
                        cm:SetVector( "$color2", Vector(value.r/255 ,value.g/255 ,value.b/255)) 
                        cm:Recompute()
                    end
                    material[id] =  '!'..name
                    --MsgN("heck ",id," - ",name," = ",Vector(value.r/255 ,value.g/255 ,value.b/255))
                end
            else
                local name = color_prefix..eid..k 
                if CLIENT then
                    local value = GetValue(species,data,m.params) or Color(0,0,0) 
                    local prepm = PrepareProceduralMat(species, data,m)
                    local matdata =  {
                        --["$basetexture"] = "",
                        ["$bumpmap"] = "models/mlp/base/render/body_n",
                        ["$color2"] = value,
                        ["$model"] = 1,
                    }
                    if species.MaterialBase then
                        for k,vv in pairs(species.MaterialBase) do
                            if matdata[k] == nil then
                                matdata[k] = vv
                            end
                        end
                    end
                    if m.matdata then
                        for k,vv in pairs(m.matdata) do
                            matdata[k] = vv
                        end
                    end

                    local cm = CreateMaterial(name, m.shader or "VertexLitGeneric", matdata)
                    if prepm.texture then cm:SetTexture( "$basetexture", prepm.texture ) end
                    --gcpm.SetupMaterial(cm,matdata)
                    cm:SetVector( "$color2", Vector(value.r/255 ,value.g/255 ,value.b/255))
                    cm:Recompute()
                end
                material =  '!'..name
            end
             
        end 
    end
    return material
end

if CLIENT then
    local ENTITY = FindMetaTable("Entity")

    function ENTITY:GetCPPart(key)
        local bpdata = self.gcpm_bpdata or {}
        return bpdata[key]
    end
    function ENTITY:SetHideCPPart(key,hide) 
        local part = self:GetCPPart(key)
        if IsValid(part) then
            part:SetNoDraw(hide)
        end
    end
    
end


hook.Add("GCPMUpdate", "parts", function(ent,data,species) 
     
    local bpdata = ent.gcpm_bpdata or {}
    ent.gcpm_bpdata = bpdata

    local eid = ent:EntIndex()
    local Race = species.Races[data.race] or {}

    
    local localmaterials = {}
    for k,v in pairs(species.Materials) do
        if v.mode then 
            localmaterials[k] = GetMaterial(species,data,eid,k,v)
            --MsgN("preload mat ",k," = ",localmaterials[k])
        end
    end

    if CLIENT then 

        for k,v in pairs(bpdata) do 
            if not species.Parts[k] then
                CLIENTSIDE_ENTS[v.ClientsideID] = nil
                v:Remove()
                bpdata[k] = nil
            end
        end
        for k,v in pairs(species.Parts) do

            local racedata = (Race.Parts or empty)[k] 
            local pdata = false 

            local pvalue = data[k]
            if pvalue then

                if racedata and racedata.whitelist then -- check access
                    local has_value = false
                    local value = false
                    for k,v in pairs(racedata.whitelist) do
                        value = v
                        if v==pvalue then
                            has_value = true
                            break
                        end
                    end 
                    if not has_value then
                        pvalue = value
                    end
                end

                if pvalue then
                    pdata = v.variants[pvalue]
                end
            else
                if racedata and racedata.whitelist then -- check access
                    pvalue = racedata.whitelist[1]
                    if pvalue then
                        pdata = v.variants[pvalue]
                    end
                end
            end


           

            local bpent = bpdata[k]

            
            if pdata and pdata.model then
                if not IsValid(bpent) then
                    bpent = ents.CreateClientside("cpm_bodypart")
                    local CID = #CLIENTSIDE_ENTS+1
                    CLIENTSIDE_ENTS[#CLIENTSIDE_ENTS+1] = bpent
                    bpent.ClientsideID = CID
                    bpent.Parent = ent
                end
                local mpath = species.PartsDirectory .. '/' .. pdata.model
                if not string.EndsWith(mpath, ".mdl") then
                    mpath = mpath .. '.mdl'
                end

                local color = Color(255,255,255)

                if v.tint then 
                    color = GetValue(species,data,v.tint)  
                end
                local m = pdata.material
                local material = nil
                if m then
                    material = GetMaterial(species,data,eid,k,m,localmaterials)
                end

                if CLIENT and pdata.states then
                    bpent:SetBasePath(species.PartsDirectory)
                    bpent:SetStates(pdata.states)
                    bpent:SetState(pdata.state)
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
    end
 
    if species.Body then
        for k,v in pairs(species.Body.materials) do
            local bodymat = nil
            bodymat = GetMaterial(species,data,eid,'body'..k,v,localmaterials)
            --if v.mode=="procedural" then
            --    bodymat = GetMaterial(species,data,eid,'body'..k,v)
            --elseif v.mode=="color" then
            --    bodymat = GetMaterial(species,data,eid,'body'..k,v)
            --end
            ent:SetSubMaterial(k-1,bodymat) 
            --MsgN("setsubmat ",ent," ",k-1," = ",bodymat)
            
        end
    else
        ent:SetMaterial(nil)
    end

    
    if CLIENT then 
        if ent==LocalPlayer() then 
            if species.Viewmodel then 
                local hands = ent:GetHands()
                if IsValid(hands) then 
                    local mat =  GetMaterial(species,data,eid,'hands',species.Viewmodel.material,localmaterials) 
                    hands:SetMaterial(mat) 
                end
            end
        end
    end

end)  


concommand.Add("client_ent_list", function()
    for k,v in SortedPairs(CLIENTSIDE_ENTS) do
        MsgN(k," - ",v)
    end
end)
concommand.Add("client_ent_clear", function()
    for k,v in SortedPairs(CLIENTSIDE_ENTS) do
        if IsValid(v) then v:Remove() end
        CLIENTSIDE_ENTS[k] = nil
    end
end)