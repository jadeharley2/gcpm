AddCSLuaFile()
module( "gcpme", package.seeall )

backgrounds = {
    default = {
        {
            model = "models/mlp/decoration/skydome.mdl",
            scale = 25,
            angles = Angle(0,30,0),
            group = RENDERGROUP_OPAQUE,
        },
        {
            model = "models/mlp/decoration/ground.mdl",
            scale = 25, 
            pos = Vector(0,0,-15),
            group = RENDERGROUP_OPAQUE,
        },
        {
            model = "models/mlp/decoration/building.mdl",
            scale = 25,
            pos = Vector(0,0,-15),
            group = RENDERGROUP_OPAQUE,
        }
    }
}

function LoadBackground(id)
    local data = backgrounds[id]
    if data then
        local renderdata = {}
        for k,v in pairs(data) do
            local m = ClientsideModel(v.model,v.group or RENDERGROUP_OPAQUE)
            if v.scale then m:SetModelScale(v.scale) end
            if v.angles then m:SetAngles(v.angles) end
            if v.pos then m:SetPos(v.pos) end
            renderdata[k] = m
        end
        return renderdata
    end
end
function RemoveBackground(data)
    if data then
        for k,v in pairs(data) do
            v:Remove() 
        end
    end
end
function DrawBackground(data)
    if data then
        for k,v in pairs(data) do
            if IsValid(v) then v:DrawModel() end
        end
    end
end