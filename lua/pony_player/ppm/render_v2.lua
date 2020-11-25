

AddCSLuaFile()
if SERVER then return end 
 
function PPM.UpdateMaterials(ent)
   -- if true then return end
    if !PPM.isValidPonyLight(ent) then return end 
    
 --   local pony = PPM.getPonyValues(ent,localvals)  
 --   local bhash = PPM.GetBodyHash(pony)
    

    if(PPM.RequestUpdate(ent)) then

  --   local tempPlayerHash = "body_ptexid_"..ent:EntIndex()
  --   MsgN("tempPlayerHash ",tempPlayerHash) 

    end 

end
PPM.update_list = PPM.update_list or {}
function PPM.RequestUpdate(ent)
    PPM.update_list[ent] = true
    PPM.UpdateBones(ent) 
end


function PPM.Update(ent)
    PPM.UpdateBones(ent)
end

--update bone scales
function PPM.UpdateBones(ent)
    
    if !PPM.isValidPonyLight(ent) then return end 

    local pony = PPM.getPonyValues(ent) 
    if pony then
        local SCALEVAL0 =pony.bodyweight or 1--(1+math.sin(time)/4)  
        local SCALEVAL1 =pony.gender-1;
        --local SCALEVAL2 =PPM.test_buffness;
        PPM:RescaleRIGPART(ent,PPM.rig.leg_FL,Vector( 1,1,1 )*SCALEVAL0)
        PPM:RescaleRIGPART(ent,PPM.rig.leg_FR,Vector( 1,1,1 )*SCALEVAL0)
        PPM:RescaleRIGPART(ent,PPM.rig.leg_BL,Vector( 1,1,1 )*SCALEVAL0)
        PPM:RescaleRIGPART(ent,PPM.rig.leg_BR,Vector( 1,1,1 )*SCALEVAL0)
        PPM:RescaleRIGPART(ent,PPM.rig.rear,Vector( 1,1,1 )*(SCALEVAL0-(SCALEVAL1)*0.2))
        --PPM:RescaleRIGPART(self.Entity,{1},Vector( 0,1,1 )*(SCALEVAL0+SCALEVAL1*0.2)+Vector( 1,0,0 ))
        --PPM:RescaleRIGPART(self.Entity,{2},Vector( 0,1,1 )*(SCALEVAL0+SCALEVAL1*0.4)+Vector( 1,0,0 ))
        --PPM:RescaleRIGPART(self.Entity,{3},Vector( 0,1,1 )*(SCALEVAL0+SCALEVAL1*0.8)+Vector( 1,0,0 ))
        PPM:RescaleRIGPART(ent,PPM.rig.neck,Vector( 1,1,1 )*SCALEVAL0)
        PPM:RescaleRIGPART(ent,{3},Vector( 1,1,0 )*((SCALEVAL0-1)+SCALEVAL1*0.1+0.9)+Vector( 0,0,1 ))
            
        
        PPM:RescaleMRIGPART(ent,{18},Vector(0,0,SCALEVAL1/2))
        PPM:RescaleMRIGPART(ent,{24},Vector(0,0,-SCALEVAL1/2))
        --tailscale
        local SCALEVAL_tail =pony.tailsize or 1
        local svts = (SCALEVAL_tail-1)*2+1
        local svtc = (SCALEVAL_tail-1)/2+1
        PPM:RescaleOFFCETRIGPART(ent,{38},Vector(svtc,svtc,svtc))
        PPM:RescaleRIGPART(ent,{38},Vector(svts,svts,svts))
        
        PPM:RescaleOFFCETRIGPART(ent,{39,40},Vector(SCALEVAL_tail,SCALEVAL_tail,SCALEVAL_tail))
        PPM:RescaleRIGPART(ent,{39,40},Vector(svts,svts,svts))
    end
        
end

function PPM:RescaleRIGPART(ent,part,scale)
	for k , v in pairs(part) do 
		ent:ManipulateBoneScale( v,scale )  
	end
end
function PPM:RescaleMRIGPART(ent,part,scale)
	for k , v in pairs(part) do 
		--ent:ManipulateBoneScale( v,scale ) 
		ent:ManipulateBonePosition( v, scale )
	end
end
function PPM:RescaleOFFCETRIGPART(ent,part,scale)
	for k , v in pairs(part) do 
		--ent:ManipulateBoneScale( v,scale ) 
		local thispos = PPM.skeletons.pony_default[v+1].localpos 
		ent:ManipulateBonePosition( v, thispos *(scale-Vector(1,1,1)) )
	end
end

function HOOK_PostDrawOpaqueRenderables() 
    if(!PPM.isLoaded) then 
        PPM.LOAD()
    end  
end
hook.Add("PostDrawOpaqueRenderables","test_Redraw",HOOK_PostDrawOpaqueRenderables)