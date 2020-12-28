AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
 
--[[
	local schdChase = ai_schedule.New( "AIFighter Chase" ) 
 
  
	schdChase:EngTask( "TASK_GET_PATH_TO_RANDOM_NODE", 	128 )
	schdChase:EngTask( "TASK_RUN_PATH", 				0 )
	schdChase:EngTask( "TASK_WAIT_FOR_MOVEMENT", 	0 ) 
   
	schdChase:AddTask( "FindEnemy", 		{ Class = "player", Radius = 2000 } )
	schdChase:EngTask( "TASK_GET_PATH_TO_RANGE_ENEMY_LKP_LOS", 	0 )
	schdChase:EngTask( "TASK_RUN_PATH", 				0 )
	schdChase:EngTask( "TASK_WAIT_FOR_MOVEMENT", 	0 )
  
	schdChase:EngTask( "TASK_STOP_MOVING", 			0 )
	schdChase:EngTask( "TASK_FACE_ENEMY", 			0 )
	schdChase:EngTask( "TASK_ANNOUNCE_ATTACK", 		0 )  
 
]]

function ENT:Initialize()
 
	self:SetModel("models/mlp/player_default_base.mdl" )
  -- --[[
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
 
	self:SetSolid( SOLID_BBOX ) 
	self:SetMoveType( MOVETYPE_STEP )
 
	--self:CapabilitiesAdd( CAP_MOVE_GROUND )
	--self:CapabilitiesAdd(CAP_OPEN_DOORS)
	self:CapabilitiesAdd(CAP_TURN_HEAD) 
	self:CapabilitiesAdd(CAP_ANIMATEDFACE) 
	self:CapabilitiesAdd(CAP_TURN_HEAD) 
	--self:CapabilitiesAdd(CAP_USE_SHOT_REGULATOR) 
	--self:CapabilitiesAdd(CAP_AIM_GUN)  
 
	self:SetMaxYawSpeed( 5000 )
  
	self:SetHealth(100) 
--	]]--
	MsgN('seq: ',self:SetSequence(0))

	PPM.setupPony(self)
 
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local ent = ents.Create("cpm_pony_npc" )
	ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
	ent:Spawn()
	ent:Activate()
	undo.Create( "npc" )
	undo.AddEntity( ent )
	undo.SetPlayer( ply )
	undo.Finish()
	return ent
end

function ENT:OnTakeDamage(dmg)
	--self:SetHealth(self:Health() - dmg:GetDamage())
	--if self:Health() <= 0 then  
	--	self:SetSchedule( SCHED_FALL_TO_GROUND )  
	--end
end 
 
 
/*---------------------------------------------------------
   Name: SelectSchedule
---------------------------------------------------------*/
function ENT:SelectSchedule()
 
	self:SetSchedule(SCHED_IDLE_STAND)
 
end


concommand.Add("ppm_spawn_pnpc",function(ply,tr)
	local ent = scripted_ents.GetStored("cpm_pony_npc")
	ent.t:SpawnFunction(ply, ply:GetEyeTrace())
end)
concommand.Add("ppm_spawn_pragdoll",function(ply,tr)
	tr =ply:GetEyeTrace()
	if ( !tr.Hit ) then return end
	local ent = ents.Create("prop_ragdoll" )
	ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
	ent:SetModel( "models/mlp/player_default_base_ragdoll.mdl" )
	ent:Spawn()
	PPM.setupPony(ent)
	ent:Activate()
	undo.Create( "ragdoll" )
	undo.AddEntity( ent )
	undo.SetPlayer( ply )
	undo.Finish() 
end)
