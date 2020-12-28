
include('shared.lua')
 
ENT.RenderGroup = RENDERGROUP_OPAQUE
 

function ENT:Draw()
   --self:SetupBones()
	self:DrawModel()
end
--ENT.Draw = nil
function ENT:Think()
  -- if SERVER then
  --     self:NextThink(CurTime()+1)
  -- else
  --     self:SetNextClientThink(CurTime()+1)
  -- end
	--self:NextThink( CurTime() ) -- Set the next think to run as soon as possible, i.e. the next frame.
	--return true -- Apply NextThink call
end

function ENT:DrawTranslucent()
  
	--self:Draw()
 
end
ENT.DrawTranslucent = nil
 

function ENT:BuildBonePositions( NumBones, NumPhysBones )
 
 
end
 
 
 
/*---------------------------------------------------------
   Name: SetRagdollBones
   Desc: 
---------------------------------------------------------*/
function ENT:SetRagdollBones( bIn )
 
 
	self.m_bRagdollSetup = bIn
 
end
 
 
/*---------------------------------------------------------
   Name: DoRagdollBone
   Desc: 
---------------------------------------------------------*/
function ENT:DoRagdollBone( PhysBoneNum, BoneNum )
 
	// self:SetBonePosition( BoneNum, Pos, Angle )
 
end