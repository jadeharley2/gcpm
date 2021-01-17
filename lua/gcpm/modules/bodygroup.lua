


module( "gcpm", package.seeall )

function RescaleRIGPART(ent,part,scale)
    for k , v in pairs(part) do 
        local id = v
        if isstring(id) then
            id = ent:LookupBone(id)
        end
        if id then
            ent:ManipulateBoneScale( id,scale ) 
        end  
	end
end
function RescaleMRIGPART(ent,part,scale)
	for k , v in pairs(part) do 
		--ent:ManipulateBoneScale( v,scale ) 
		ent:ManipulateBonePosition( v, scale )
	end
end
function RescaleOFFCETRIGPART(ent,part,scale)
	for k , v in pairs(part) do 
		--ent:ManipulateBoneScale( v,scale ) 
		local thispos = PPM.skeletons.pony_default[v+1].localpos 
		ent:ManipulateBonePosition( v, thispos *(scale-Vector(1,1,1)) )
	end
end





local leg_BL = {8,9,10,11,12}
local leg_BR = {13,14,15,16,17}
local leg_FL = {18,19,20,21,22,23}
local leg_FR = {24,25,26,27,28,29}

hook.Add("GCPMUpdate", "body", function(ent,data,species) 
    
    local model = species.Models[1]
    ent:SetModel(species.Directory.."/"..model.File)  
    if model.Bodygroups then
        for k,v in pairs(model.Bodygroups) do
            local bg = ent:FindBodygroupByName(k)
            ent:SetBodygroup(bg, v)
            print("bgroup set",ent,k,bg,"=",v)
        end
    end

    local Body = species.Body
    if Body then
        if Body.skin then
            local val = GetDataValue(species,data,Body.skin)
            ent:SetSkin(val)
        end
        if Body.flexes then
            for k,v in pairs(Body.flexes) do
                local fi = ent:GetFlexIDByName(k)
                local val = GetDataValue(species,data,v)
                ent:SetFlexWeight( fi, val )
            end
        end
    end
    if model.Flexes then
        for k,v in pairs(model.Flexes) do
            local fi = ent:GetFlexIDByName(k) 
            ent:SetFlexWeight( fi, v )
        end
    end
        
    if Body and CLIENT then 
        local b = Body.bones
        if b then
            if b.modifiers.rescale then
                for k,v in pairs(b.modifiers.rescale) do
                    local val = GetProcDataValue(species,data,v)
                    
                    local left,right = unpack(string.Split(k, ':'))
                    if right then
                        local part = ent:GetCPPart(left) 
                        if IsValid(part) then
                            RescaleRIGPART(part, b.groups[right] ,Vector( 1,1,1 )*val)
                        end
                    else 
                        RescaleRIGPART(ent, b.groups[k] ,Vector( 1,1,1 )*val)
                    end
                end
            end  
        end
    else
        ent:SetMaterial(nil)
    end

    if Body and CLIENT then 
        local pp = Body.poseparams
        if pp then
            for k,v in pairs(pp) do
                local val = GetProcDataValue(species,data,v) 
                ent:SetPoseParameter( k, val)
                print("POSEPARAM ",ent,k,val)
            end
        end 
    end
    
    if SERVER then  
        if ent:IsPlayer() then
            local mod = 0
            local set = nil
            local att = nil
            local eyes = species.Eyes
            if eyes then
                mod = eyes.offset or 0 
                att = eyes.attachment
                set = eyes.set
            end

            gcpm.UpdateView(ent,att,mod,set)  
        end
    end

end)
hook.Add("GCPMClear", "body", function(ent)

    if CLIENT then  
        --remove bone manipulator
        for k,v in pairs(ent:GetChildren()) do  
            local c = v:GetClass()
            if c == "manipulate_bone"then
                v:Remove()
            end
        end 
    else
        --remove flex manipulator
        for k,v in pairs(ent:GetChildren()) do  
            local c = v:GetClass()
            if c == "manipulate_flex" then
                v:Remove()
            end
        end 
    end 
end)