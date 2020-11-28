
/////////////////////////////////////////////////////////////////SHARED


 
local BODYGROUP_BODY = 1
local BODYGROUP_HORN = 2
local BODYGROUP_WING = 3
local BODYGROUP_MANE = 4
local BODYGROUP_MANE_LOW = 5
local BODYGROUP_TAIL = 6
local BODYGROUP_CMARK = 7
local BODYGROUP_EYELASH = 8

local EYES_COUNT = 10
local MARK_COUNT = 27

PPM.pony_models = { }
PPM.pony_models["models/mlp/player_default_base.mdl"] = {
	isPonyModel = true,
	BgroupCount = 8
}
PPM.pony_models["models/mlp/player_default_base_nj.mdl"] = {
	isPonyModel = true,
	BgroupCount = 8
}
PPM.pony_models["models/mlp/player_default_base_ragdoll.mdl"] = {
	isPonyModel = true,
	BgroupCount = 8
}
PPM.pony_models["models/mlp/player_mature_base.mdl"] = {
	isPonyModel = true,
	BgroupCount = 6
}
PPM.pony_models["models/mlp/player_default_clothes1.mdl"] = {
	isPonyModel = false,
	BgroupCount = 8
}

PPM.pony_models["models/mlp/player_luna.mdl"] = {
	isPonyModel = false,
	BgroupCount = 8
}
PPM.pony_models["models/mlp/player_luna_nj.mdl"] = {
	isPonyModel = false,
	BgroupCount = 8
}


PPM.pony_models["models/mlp/player_celestia.mdl"] = {
	isPonyModel = false,
	BgroupCount = 8
}
PPM.pony_models["models/mlp/player_celestia_nj.mdl"] = {
	isPonyModel = false,
	BgroupCount = 8   
}

function PPM.LOAD()
	if CLIENT then
		PPM.setupPony(LocalPlayer())
		PPM.loadResources() 
		PPM.Load_settings() 
		PPM.loadrt()
	end
	PPM.isLoaded =true
end


function PPM.Save_settings() 
	PPM.Save("_current.txt",LocalPlayer().ponydata) 
end
function PPM.Load_settings() 
	if(file.Exists("ppm/_current.txt", "DATA" )) then
		PPM.mergePonyData(LocalPlayer().ponydata,PPM.Load("_current.txt"))
		PPM.SendCharToServer(LocalPlayer(),true) 
	else 
		PPM.randomizePony(LocalPlayer())
		PPM.SendCharToServer(LocalPlayer(),true) 
		PPM.Save_settings() 
	end
end

function PPM.setupPony(ent,fake)
	 
	ent.ponydata_tex = ponydata_tex or {}
	ent.ponydata = ent.ponydata or {} 
	for k , v in SortedPairs(PPM.Pony_variables.default_pony) do 
		ent.ponydata[k] =ent.ponydata[k] or v.default
	end 


	if not fake then
		if SERVER then 
			if !IsValid(ent.ponydata.clothes1) then
				ent.ponydata.clothes1 = ents.Create("prop_dynamic")
				ent.ponydata.clothes1:SetModel("models/mlp/player_default_clothes1.mdl")
				ent.ponydata.clothes1:SetParent(ent)
				ent.ponydata.clothes1:AddEffects(EF_BONEMERGE)
				ent.ponydata.clothes1:SetRenderMode( RENDERMODE_TRANSALPHA )
				//ent.ponydata.clothes1:SetNoDraw(true)	
				ent:SetNWEntity("pny_clothing", ent.ponydata.clothes1 )
			end
			PPM.setPonyValues(ent)
		else //CLIENT
			 
		end
	end
end

function PPM.cleanup(ent)
	if SERVER then
		net.Start("ppm_cleanup")
		net.WriteEntity(ent)
		net.Broadcast()
	else
		local mcount = #ent:GetMaterials()
		for k=0,mcount do 
			ent:SetSubMaterial(k,nil)
		end
	end
end
function PPM.doRespawn(ply)
	if !IsValid(ply) then return end
	if !ply:IsPlayer() then return end
	
end
function PPM.getPonyEnts()
	
end
function PPM.reValidatePonies()
	
end

function PPM.cleanPony(ent) 
	PPM.setupPony(ent) 
	
	for k , v in SortedPairs(PPM.Pony_variables.default_pony) do 
		ent.ponydata[k] = v.default
	end 
	ent.ponydata._cmark = nil
	ent.ponydata._cmark_loaded = false 
end
function PPM.randomizePony(ent)
	PPM.setupPony(ent) 
	ent.ponydata.kind = math.Round(math.Rand(1,4))
	ent.ponydata.gender = math.Round(math.Rand(1,2))
	ent.ponydata.body_type = 1 
	ent.ponydata.mane = math.Round(math.Rand(1,15))
	ent.ponydata.manel = math.Round(math.Rand(1,12))
	ent.ponydata.tail = math.Round(math.Rand(1,14))
	ent.ponydata.tailsize =  math.Rand(0.8,1)
	ent.ponydata.eye = math.Round(math.Rand(1,EYES_COUNT)) 
	ent.ponydata.eyelash = math.Round(math.Rand(1,5)) 
	ent.ponydata.coatcolor = Vector(math.Rand(0,1),math.Rand(0,1),math.Rand(0,1))
	
	for I=1,6 do
		ent.ponydata["haircolor"..I] =Vector(math.Rand(0,1),math.Rand(0,1),math.Rand(0,1))
	end
	 
	for I=1,8 do 
		ent.ponydata["bodydetail"..I] = 1
		ent.ponydata["bodydetail"..I.."_c"] =Vector(0,0,0) 
	end
	
		
	
	ent.ponydata.cmark = math.Round(math.Rand(1,MARK_COUNT))
	ent.ponydata.bodyweight = math.Rand(0.8,1.2)
	ent.ponydata.bodyt0 = 1//math.Round(math.Rand(1,4)) 
	ent.ponydata.bodyt1_color = Vector(math.Rand(0,1),math.Rand(0,1),math.Rand(0,1))
	
	local iriscolor = Vector(math.Rand(0,1),math.Rand(0,1),math.Rand(0,1))*2
	ent.ponydata.eyecolor_bg = Vector(1,1,1) 
	ent.ponydata.eyeirissize = 0.7+math.Rand(-0.1,0.1)
	ent.ponydata.eyecolor_iris = iriscolor
	ent.ponydata.eyecolor_grad = iriscolor/3
	ent.ponydata.eyecolor_line1 = iriscolor*0.9 
	ent.ponydata.eyecolor_line2 = iriscolor*0.8
	ent.ponydata.eyeholesize = 0.7+math.Rand(-0.1,0.1)
	ent.ponydata.eyecolor_hole = Vector(0,0,0) 
end
function PPM.copyLocalPonyTo(from,to)
	to.ponydata = table.Copy(from.ponydata)
end 
function PPM.copyLocalTextureDataTo(from,to)
	to.ponydata_tex = from.ponydata_tex
end 
function PPM.copyLocalMaterialDataTo(from,to)
	to.ponydata_tex = from.ponydata_tex
	local mcount = #from:GetMaterials()
	for k=0,mcount do 
		to:SetSubMaterial(k,from:GetSubMaterial(k))
	end
end 
function PPM.copyPonyTo(from,to)
	to.ponydata = PPM.getPonyValues(from)
	PPM.setPonyValues(to)
end
function PPM.mergePonyData(destination,addition)
	for k,v in pairs(addition) do
		destination[k] = v
	end
end
function PPM.hasPonyModel(model)
	if PPM.pony_models[model] == nil then return false end
	return PPM.pony_models[model].isPonyModel 
end
function PPM.isValidPonyLight(ent) 
	if !IsValid(ent) then return false end
	if !PPM.hasPonyModel(ent:GetModel()) then return false end
	return true
end
function PPM.isValidPony(ent)
	if !IsValid(ent) then return false end
	if ent.ponydata==nil then return false end 
	if !PPM.hasPonyModel(ent:GetModel()) then return false end
	return true
end
PPM.rig = {}

PPM.rig.neck = {4,5,6}
PPM.rig.ribcage = {1,2,3}
PPM.rig.rear = {0}
PPM.rig.leg_BL = {8,9,10,11,12}
PPM.rig.leg_BR = {13,14,15,16,17}
PPM.rig.leg_FL = {18,19,20,21,22,23}
PPM.rig.leg_FR = {24,25,26,27,28,29}
PPM.rig_tail = {38,39,40}
function PPM.setBodygroups(ent)
	if !PPM.isValidPony(ent) then return end 
	
	//if true then return end   
	if(ent.ponydata.kind==1) then
		PPM.setBodygroupSafe(ent,BODYGROUP_HORN,1)//h
		PPM.setBodygroupSafe(ent,BODYGROUP_WING,1)//w
	elseif(ent.ponydata.kind==2)then
		PPM.setBodygroupSafe(ent,BODYGROUP_HORN,1) 
		PPM.setBodygroupSafe(ent,BODYGROUP_WING,0) 
	elseif(ent.ponydata.kind==3)then   
		PPM.setBodygroupSafe(ent,BODYGROUP_HORN,0) 
		PPM.setBodygroupSafe(ent,BODYGROUP_WING,1) 
	else
		PPM.setBodygroupSafe(ent,BODYGROUP_HORN,0) 
		PPM.setBodygroupSafe(ent,BODYGROUP_WING,0) 
	end
	PPM.setBodygroupSafe(ent,BODYGROUP_BODY,ent.ponydata.gender-1) 
	PPM.setBodygroupSafe(ent,BODYGROUP_MANE,ent.ponydata.mane-1) 
	PPM.setBodygroupSafe(ent,BODYGROUP_MANE_LOW,ent.ponydata.manel-1) 
	PPM.setBodygroupSafe(ent,BODYGROUP_TAIL,ent.ponydata.tail-1)  
	PPM.setBodygroupSafe(ent,BODYGROUP_CMARK,ent.ponydata.cmark_enabled-1)
	if ent.ponydata.gender==1 then
		PPM.setBodygroupSafe(ent,BODYGROUP_EYELASH,ent.ponydata.eyelash-1)
	else
		PPM.setBodygroupSafe(ent,BODYGROUP_EYELASH,5)
	end
end

function PPM.setBodygroupSafe(ent,bgid,bgval)
	if ent==nil or !IsEntity(ent) or ent == NULL then return end
	if bgid <1 or bgval<0 then return end
	local mdl = ent:GetModel()
	if PPM.pony_models[mdl] == nil then return end
	if bgid>PPM.pony_models[mdl].BgroupCount then return end
	ent:SetBodygroup(bgid,bgval)
end



if CLIENT then
	net.Receive("ppm_data", function()
		local ent = net.ReadEntity()
		ent.ponydata = net.ReadTable()

		MsgN("pony received ",ent)
		PPM.RequestUpdate(ent)
	end)
end
if SERVER then
	util.AddNetworkString("ppm_data")
	function PPM.setPonyValues(ent) 
		--MsgN("pny is valid ",ent,PPM.isValidPony(ent))
		if !PPM.isValidPony(ent) then return end 

		net.Start("ppm_data")
		net.WriteEntity(ent)
		net.WriteTable(ent.ponydata)
		net.Broadcast()
 
		PPM.setupMaterials(ent)
	end
	--set materials on server to prevent material reset on clients
	function PPM.setupMaterials(ent)
		local submaterials = {
			eyeltex = 0,
			eyertex = 1,
			bodytex = 2,
			hairtex1 = 5,
			hairtex2 = 6,
			tailtex = 7,
			tailtex2 = 8,
			ccmarktex = 9
		}
		for k,v in pairs(submaterials) do
			local matname = "ph2"..(ent:EntIndex()+10).."t"..k 
			ent:SetSubMaterial(v, "!"..matname) 
			
		--	MsgN("setupMaterials ",ent, "  !"..matname)
		end
		local tph_horn= "ph2"..(ent:EntIndex()+10).."thorn"
		local tph_wings= "ph2"..(ent:EntIndex()+10).."twings"
		local tph_tail2= "ph2"..(ent:EntIndex()+10).."ttail2"
		ent:SetSubMaterial(3, "!"..tph_horn)  
		ent:SetSubMaterial(4, "!"..tph_wings)  
		ent:SetSubMaterial(submaterials.tailtex2, "!"..tph_tail2)
		
	end
end 
function PPM.getPonyValues(ent, localvals) 
	if true then return ent.ponydata end
end   


if CLIENT then 
	PPM.jiggleboneids= {}
	function PPM.fixJigglebones(ent)
		local bonecount = ent:GetBoneCount() 
		print("PLAYER BONECOUNT:",bonecount)
		 bboneeez(ent, bonecount, bonecount )
		
		ent.BuildBonePositions(ent,bonecount);
		//Entity:GetBoneMatrix( number boneID )
	end
end
/////////////////////////////////////////////////////////////////CLIENT
if CLIENT then 
	function PPM.RELOAD()
		 
	end
	
	function getValues()
		local pony = PPM.getPonyValues(LocalPlayer(),false) 
		for k , v in SortedPairs(pony) do
			MsgN(k .." = ".. tostring(v));  
		end 
	end 
	function getValuesl()
		local pony = PPM.getPonyValues(LocalPlayer(),true) 
		for k , v in SortedPairs(pony) do
			MsgN(k .." = ".. tostring(v));  
		end 
	end 
	function reloadPPM()
		PPM.isLoaded=false
	end 
	function OnEntityCreated( ent )
	end
	function getLocalBoneAng(ent,boneid)
        local wangle = ent:GetBoneMatrix(boneid):GetAngles()
		local parentbone = ent:GetBoneParent(boneid)
		local wangle_parent = ent:GetBoneMatrix(parentbone):GetAngles()
		local lp ,la =WorldToLocal( Vector(0,0,0),  wangle, Vector(0,0,0), wangle_parent )
		return la
	end
	function getWorldAng(ent,boneid,ang)
        //local wangle = ent:GetBoneMatrix(boneid):GetAngles()
		local parentbone = ent:GetBoneParent(boneid)
		local wangle_parent = ent:GetBoneMatrix(parentbone):GetAngles()
		local lp ,la =LocalToWorld( Vector(0,0,0),  ang, Vector(0,0,0), wangle_parent )
		return la
	end
	function bboneeez(self, NumBones, NumPhysBones )
		for k=1,NumBones-1 do
			print("BONE:",k,self:GetBoneName(k))
			local bmatrix =self:GetBoneMatrix(k)
			//if( k>=30 && k<=40 )then
				// print("","",bmatrix:GetAngles())
				 //bmatrix:SetAngles( Angle(0,0,0) )
				// print("","",bmatrix:GetAngles()) 
				//ent:SetBoneMatrix(k,bmatrix) 
				//ent:ManipulateBoneAngles(k,Angle(0,10,0) )
				//self:SetBonePosition( k, Vector(0,0,0),Angle(0,10,0) )
				if(k==40)then
				local ba =getLocalBoneAng(self,k)
				local diff1 =Angle(0.133,0.000,0.021)-ba
				local diff2 =getWorldAng(self,k,diff1)
				print("PREV" , ba)
				print("DIFF" ,diff1)
				print("DIFF" ,diff2)
				self:ManipulateBoneAngles( k,-diff2)//diff1) 

				print("AFTE" ,getLocalBoneAng(self,k))
				end
				//self:ManipulateBoneAngles( k,getLocalBoneAng(self,k)- Angle(180,180,180))//self:GetManipulateBoneAngles( k)+ Angle(0,190,190))
				//print(self:GetManipulateBoneAngles( k))
				//ent:SetupBones()
				//ent:InvalidateBoneCache( )
			//end 
		end
    for i = 1, NumBones do --An entity cannot have more than 128 bones
       // self:SetBonePosition( i, VectorRand() * 32, VectorRand():Angle() )
    end
	end
	hook.Add("OnEntityCreated","pony_spawnent",OnEntityCreated)
	concommand.Add("ppm_getvalues",getValues)
	concommand.Add("ppm_getvaluesl",getValuesl)
	concommand.Add("ppm_reload",reloadPPM) 
	concommand.Add("ppm_getbones", function(ply)
	for i=0, ply:GetBoneCount() - 1 do
		MsgN(i, " - ",ply:GetBoneName(i))
	end

	end)

	hook.Add( "CreateClientsideRagdoll", "pony_inherit", function( entity, ragdoll )
		PPM.copyLocalPonyTo(entity,ragdoll)
		PPM.RequestUpdate(ragdoll)
		--PPM.copyLocalMaterialDataTo(entity,ragdoll)
	end )
	
end 
/////////////////////////////////////////////////////////////////SERVER
if SERVER then 

	hook.Add( "CreateEntityRagdoll", "pony_inherit", function( entity, ragdoll )
		PPM.copyPonyTo(entity,ragdoll)  
		MsgN("ccpp ",entity," -> ",ragdoll)
	end )
	function HOOK_OnEntityCreated( ent ) 
	end 
	local function HOOK_SpawnedRagdoll(ply, model, ent)
		 
		if PPM.isValidPonyLight(ent) then
			PPM.randomizePony(ent) 
			PPM.setPonyValues(ent)
			PPM.setBodygroups(ent)
		end
	end
	local function HOOK_PlayerSpawn( ply )
		local m = ply:GetInfo( "cl_playermodel" )
		if(m=="pony")or (m=="ponynj")then
			timer.Simple(1,function()
				if ply.ponydata==nil then 
					PPM.setupPony(ply)
				end
				
				PPM.setBodygroups(ply)
				PPM.setPonyValues(ply)
				PPM.ccmakr_onplyinitspawn(ply)
			end)
		elseif ply.ponydata~=nil then
			PPM.cleanup(ply)
		end
	end
	hook.Add("OnEntityCreated","pony_spawnent",HOOK_OnEntityCreated)
	
	hook.Add("PlayerSpawnedRagdoll", "pony_spawnragdoll", HOOK_SpawnedRagdoll)
	
	hook.Add("PlayerSpawn","pony_spawn",HOOK_PlayerSpawn)
	
end 