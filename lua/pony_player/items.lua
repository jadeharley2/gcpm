
//SLOTIDS
// 0 = HEAD = L1
// 1 = NECK = L2
// 2 = FBODY = L3
// 3 = FLLEG = L4
// 4 = FRLEG = L5
// 5 = FLHOOF = L6
// 6 = FRHOOF = L7 

// 7 = EYES = R1
// 8 = NONE = R2
// 9 = BBODY = R3
//10 = BLLEG = R4
//11 = BRLEG = R5
//12 = BLHOOF = R6
//13 = BRHOOF = R7
 
PONYPM.pony_items = {}
PONYPM.cid=1
function PONYPM:AddItem( basemodel, itemname, itemimg, itemBodygroupId, itemBodygroupValue, slot )
	local pitem = {}
	pitem.id = PONYPM.cid
	pitem.model = basemodel
	pitem.name = itemname
	pitem.img = itemimg
	pitem.bid = itemBodygroupId 
	pitem.bval = itemBodygroupValue
	pitem.slot = slot
	 
	pitem.issuit = false
	
	PONYPM.pony_items[PONYPM.cid] = pitem
	PONYPM.cid=PONYPM.cid+1
	
	local pitem2 = {}
	pitem2.id = PONYPM.cid
	pitem2.model = basemodel.."nj"
	pitem2.name = itemname
	pitem2.img = itemimg
	pitem2.bid = itemBodygroupId 
	pitem2.bval = itemBodygroupValue
	pitem2.slot = slot
	 
	pitem2.issuit = false
	
	PONYPM.pony_items[PONYPM.cid] = pitem2
	PONYPM.cid=PONYPM.cid+1
	
	
	return pitem
	//table.Add(pony_items,pitem)
end
function PONYPM:AddFakeItem( basemodel, itemname, itemimg, itemBodygroupId, itemBodygroupValue, slot,varslot )
	local pitem = {}
	pitem.id = PONYPM.cid
	pitem.model = basemodel
	pitem.name = itemname
	pitem.img = itemimg
	pitem.bid = itemBodygroupId 
	pitem.bval = itemBodygroupValue
	pitem.slot = slot
	pitem.varslot = varslot
	 
	pitem.issuit = true
	
	PONYPM.pony_items[PONYPM.cid] = pitem
	PONYPM.cid=PONYPM.cid+1
	
	local pitem2 = {}
	pitem2.id = PONYPM.cid
	pitem2.model = basemodel.."nj"
	pitem2.name = itemname
	pitem2.img = itemimg
	pitem2.bid = itemBodygroupId 
	pitem2.bval = itemBodygroupValue
	pitem2.slot = slot
	pitem2.varslot = varslot
	pitem2.issuit = true
	
	PONYPM.pony_items[PONYPM.cid] = pitem2
	PONYPM.cid=PONYPM.cid+1
	
	
	return pitem
	
	//table.Add(pony_items,pitem)
end
function PONYPM:AddPPMEDItem( pitem ) 
	pitem.id = PONYPM.cid
	
	PONYPM.pony_items[PONYPM.cid] = pitem
	PONYPM.cid=PONYPM.cid+1
	return pitem
	
	//table.Add(pony_items,pitem)
end


concommand.Add("test_add_item",function( ply )

end)
 
concommand.Add("test_getall_items",function( ply )
	for i,k in pairs(PONYPM.pony_items) do
		MsgN(k.id .. " - " .. k.name .. " - " .. k.model .. " " .. k.bid .. " - " .. k.bval)
	end
end)

function PONYPM:GetAvailItems(playermodel,slotid)
	//MsgN(playermodel)
	local ait = {}
	for i,k in pairs(PONYPM.pony_items) do
		if(k.model==playermodel)and (table.HasValue( k.slot,slotid)) then 
			ait[i] = k
		end
	end
	return ait
end
function PONYPM:GetEquippedItems(ply,playermodel)
	local ait = {}
	for i,k in pairs(PONYPM.pony_items) do
		if(k.model==playermodel )then 
			for c=1,14 do
				//MsgN("FFFF "..c)
				if(k.model=="pony") or (k.model=="ponynj")then
					//local bvalue = ply.ponydata.clothes1:GetBodygroup(c)
					//if( k.bid == c and k.bval == bvalue) then
					//	ait[k.bid] = k
					//end
				else
					local bvalue = ply:GetBodygroup(c)
					if( k.bid == c and k.bval == bvalue) then
						ait[k.bid] = k
					end
				end
			end
		end
	end
	return ait
end
function PONYPM:pi_GetItemByName(itemname) 
	for i,k in pairs(PONYPM.pony_items) do
		if(k.name==itemname) then 
			return k
		end
	end
	return nil
end
function PONYPM:pi_GetItemById(itemid)  
	return PONYPM.pony_items[itemid] 
end
function PONYPM:pi_SetupItem(item,ply,fastignore) 
	if !fastignore then
		ply.pi_wear = ply.pi_wear or {}
		for c,SLOT in pairs(item.slot) do
			ply.pi_wear[SLOT] = item
		end
	end
	if(item.model=="pony") or (item.model=="ponynj") then
		if SERVER then
			if !item.issuit then
			PPM.setBodygroupSafe(ply.ponydata.clothes1,item.bid,item.bval)
			end
			for k,v in pairs(item.slot) do
				if item.issuit then
					ply.ponydata[item.varslot] = item.wearid
					ply:SetNetworkedFloat("pny_"..item.varslot,item.wearid)
					//print("setup item at ",item.varslot," to ",item.wearid)
				end
				ply:SetNetworkedFloat("pny_clothing_slot"..v,item.id)
			end
			//PPM.setPonyValues(ply)
		end
	else
		if !item.issuit then
			//MsgN("bluh")
			PPM.setBodygroupSafe(ply,item.bid,item.bval)
		end
	end
	//MsgN("BODYGROUP CHANGE "..item.bid.."-"..item.bval)
end
function PONYPM:pi_UnequipAll(ply)
	if(ply.pi_wear!=nil) then
		for I=0,14 do
			ply.pi_wear[I] = nil 
			PPM.setBodygroupSafe(ply,I,0) 
			if ply.ponydata.clothes1!=nil then
				PPM.setBodygroupSafe(ply.ponydata.clothes1,I,0)
			end
		end
		/*
		for I,K in pairs(ply.pi_wear) do
			if(K!=nil)then
				ply:SetBodygroup(K.bid,0) 
				MsgN("Unwear "..I.." - " ..K.name)
				K = nil 
			end
				MsgN("Unwear "..I.." NONE")
		end 
		*/
	end
end

PONYPM:AddItem("celestia","None","none",7,1,{5,6,12,13});
PONYPM:AddItem("celestia","None","none",5,2,{1});  
PONYPM:AddItem("celestia","None","none",6,1,{0}); 

PONYPM:AddItem("celestia","Celestia Shoes","tia_shoes",7,0,{5,6,12,13});
PONYPM:AddItem("celestia","Celestia Collar","tia_collar",5,0,{1});  
PONYPM:AddItem("celestia","Luna Collar","luna_collar",5,1,{1});  
PONYPM:AddItem("celestia","Celestia Crown","tia_crown",6,0,{0}); 

 
PONYPM:AddItem("luna","None","none",7,1,{5,6,12,13});
PONYPM:AddItem("luna","None","none",5,1,{1});  
PONYPM:AddItem("luna","None","none",6,1,{0}); 

PONYPM:AddItem("luna","Luna Shoes","luna_shoes",7,0,{5,6,12,13});
PONYPM:AddItem("luna","Luna Collar","luna_collar",5,0,{1});  
PONYPM:AddItem("luna","Luna Crown","luna_crown",6,0,{0}); 

///
//
/*
$bodygroup sHead//7
{
	blank
	studio "meshes\clothes\hat_aj.smd" 
	studio "meshes\clothes\hat_brae.smd" 
	studio "meshes\clothes\hat_trix.smd" 
}  
$bodygroup sNeck//8
{
	blank 
	studio "meshes\clothes\cape_trix.smd" 
}  
$bodygroup sBodyf//9
{
	blank
	studio "meshes\clothes\vest.smd" 
	studio "meshes\clothes\shirt.smd" 
	studio "meshes\clothes\hoodie.smd" 
} 
*/
PONYPM:AddItem("pony","None","none",1,0,{0}); 
PONYPM:AddItem("pony","None","none",2,0,{1}); 
PONYPM:AddItem("pony","None","none",3,0,{2}); 
PONYPM:AddItem("pony","None","none",8,0,{7}); 

PONYPM:AddItem("pony","Applejack hat","aj_hat",1,1,{0}); 
PONYPM:AddItem("pony","Braeburn hat","brae_hat",1,2,{0});
PONYPM:AddItem("pony","Trixie hat","trix_hat",1,3,{0});
PONYPM:AddItem("pony","Headphones","headphones",1,4,{0});

PONYPM:AddItem("pony","Scarf","scarf",2,1,{1}); 
PONYPM:AddItem("pony","Trixie cape","trix_cape",2,2,{1}); 
PONYPM:AddItem("pony","Tie","tie",2,3,{1}); 

PONYPM:AddItem("pony","Vest","vest",3,1,{2}); 
PONYPM:AddItem("pony","Shirt","shirt",3,2,{2}); 
PONYPM:AddItem("pony","Hoodie","hoodie",3,3,{2}); 
PONYPM:AddItem("pony","Wonderbolt badge","badge_gold",3,4,{2}); 

PONYPM:AddItem("pony","googles_f","googles",8,1,{7}); 
PONYPM:AddItem("pony","googles_m","googles",8,2,{7}); 
PONYPM:AddItem("pony","shades_f","shades",8,3,{7}); 
PONYPM:AddItem("pony","shades_m","shades",8,4,{7}); 
PONYPM:AddItem("pony","mono_l","monocle",8,5,{7}); 
PONYPM:AddItem("pony","mono_r","monocle",8,6,{7}); 
PONYPM:AddItem("pony","eyepatch_l","eyepatch",8,7,{7}); 
PONYPM:AddItem("pony","eyepatch_r","eyepatch",8,8,{7}); 

PONYPM:AddFakeItem("pony","None","none",99,99,{50},"bodyt0").wearid = 1 
PONYPM:AddFakeItem("pony","Wonderbolt light","unf_wnd",99,99,{50},"bodyt0").wearid = 2
PONYPM:AddFakeItem("pony","Wonderbolt","unf_wnd",99,99,{50},"bodyt0").wearid = 3
PONYPM:AddFakeItem("pony","Shadowbolt","unf_sbs",99,99,{50},"bodyt0").wearid = 4
PONYPM:AddFakeItem("pony","Shadowbolt light","unf_sbs",99,99,{50},"bodyt0").wearid = 5
PONYPM:AddFakeItem("pony","Royal guard captain","unf_rgc",99,99,{50},"bodyt0").wearid = 6
/*
PONYPM:AddPPMEDItem({
	model = basemodel,
	name = itemname,
	img = itemimg,
	bid = itemBodygroupId,
	bval = itemBodygroupValue,
	slot = slot,
	issuit = true
})
*/