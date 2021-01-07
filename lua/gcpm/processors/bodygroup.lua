


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
        end
    end

    if species.Body.skin then
        local val = GetDataValue(species,data,species.Body.skin)
        ent:SetSkin(val)
    end
    if species.Body.flexes then
        for k,v in pairs(species.Body.flexes) do
            local fi = ent:GetFlexIDByName(k)
            local val = GetDataValue(species,data,v)
            ent:SetFlexWeight( fi, val )
        end
    end
    
    if species.Body and CLIENT then 
        local b = species.Body.bones
        if b then
            local bodyweight = GetDataValue(species,data,'bodyweight')

            RescaleRIGPART(ent, b.groups.leg_bl ,Vector( 1,1,1 )*bodyweight)
            RescaleRIGPART(ent, b.groups.leg_br ,Vector( 1,1,1 )*bodyweight)
            RescaleRIGPART(ent, b.groups.leg_fl ,Vector( 1,1,1 )*bodyweight)
            RescaleRIGPART(ent, b.groups.leg_fr ,Vector( 1,1,1 )*bodyweight)
            RescaleRIGPART(ent, b.groups.neck ,Vector( 1,1,1 )*bodyweight)
            RescaleRIGPART(ent, b.groups.rear ,Vector( 1,1,1 )*bodyweight)

            local tail = ent:GetCPPart("tail") 
            if IsValid(tail) then
                local val = GetDataValue(species,data,'tailsize')
                RescaleRIGPART(tail, b.groups.tail ,Vector( 1,1,1 )*val) 
            end
            
            local lowermane = ent:GetCPPart("lowermane") 
            if IsValid(lowermane) then
                local val = GetDataValue(species,data,'lmanesize')
                RescaleRIGPART(lowermane, b.groups.lowermane ,Vector( 1,1,1 )*val) 
            end

            local uppermane = ent:GetCPPart("uppermane") 
            if IsValid(uppermane) then
                local val = GetDataValue(species,data,'umanesize')
                RescaleRIGPART(uppermane, b.groups.uppermane ,Vector( 1,1,1 )*val) 
            end
        end
    else
        ent:SetMaterial(nil)
    end
end)