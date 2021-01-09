AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" ) 

function ENT:Initialize()
 
    self.state = false
    if ( CLIENT ) then return end
     
end
function ENT:SetBasePath(basepath)
    self.basepath = basepath
end
function ENT:SetStates(states)
    self.states = states 
end
function ENT:SetState(stateid)
    if self.stateid == stateid then 
        return false
    end
    local nstate = self.states[stateid] 
 
    if nstate then
        self.state = nstate 
        self.stateid = stateid 

        MsgN("SETSTATE ",stateid)
        local nstate = self.state
        if nstate.model then
            self:SetModel(self.basepath  ..'/'.. nstate.model)  
        end
        if nstate.sequence then
            local sid = self:LookupSequence(nstate.sequence)
            self:ResetSequence(sid)
            if nstate.next then
                local delay = self:SequenceDuration(sid)
                --MsgN("DELAY ",delay," < ",nstate.sequence)
                timer.Simple(delay, function()
                    self:SetState(nstate.next)
                end)
            end
        else
            if nstate.next and nstate.next~=stateid then 
                self:SetState(nstate.next)
            end
        end

        return true
    end 
    return false
end
function ENT:GetState() 
    return self.stateid
end

function ENT:Set(ent,model,color,material,bodygroups)
    self:SetModel(model)  
    self:SetPos(ent:GetPos())
    self:SetAngles(ent:GetAngles())
    self:SetParent(ent)
    self:AddEffects(EF_BONEMERGE)
    self:AddEffects(EF_BONEMERGE_FASTCULL) 
    self:DrawShadow(true)
    --MsgN("huh? ",self,self:GetModel()," << ",model)
    if color then self:SetColor(color)  end
    if material then 
        if istable(material) then
            self:SetMaterial(nil) 
            for k,v in pairs(material) do 
                self:SetSubMaterial(k-1, v) 
            end
        else
            self:SetMaterial(material)  
            for k=1,8 do 
                self:SetSubMaterial(k-1, nil) 
            end
        end
    else
        self:SetMaterial(nil) 
    end
    if bodygroups then
        for k,v in pairs(bodygroups) do
            self:SetBodygroup(k, v)
        end
    end
end

function ENT:Draw()
    local parent = self:GetParent()
    if IsValid(parent) and (not parent:GetNoDraw() or parent.Editor) then
        self:SetRenderOrigin( parent:GetPos() )--light origin fix
        self:FrameAdvance()
        self:DrawModel()
    end
end

local function IsBodyPart(ent)
    if not IsValid(ent) then return false end
    local c = ent:GetClass()
    if c == "cpm_body_part" then
        return true
    end
    return false
end

hook.Add( "PlayerLeaveVehicle", "gcpm_bonemerge_fix", function( ply, veh )
    for k,v in pairs(ply:GetChildren()) do
        if IsBodyPart(v) then
            v:SetParent(ply)
            v:RemoveEffects(EF_BONEMERGE)
            v:AddEffects(EF_BONEMERGE)
        end
    end
end )
hook.Add("PostPlayerDeath","gcpm_body_part",function(ply)
    for k,v in pairs(ply:GetChildren()) do
        if IsBodyPart(v) then
            v:SetRenderMode(RENDERMODE_ENVIROMENTAL)
        end
    end
end)
hook.Add("PlayerSpawn","gcpm_body_part",function(ply)
    for k,v in pairs(ply:GetChildren()) do
        if IsBodyPart(v) then
            v:SetRenderMode(RENDERMODE_NORMAL)
        end
    end
end)