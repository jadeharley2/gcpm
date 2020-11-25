if CLIENT then

	PPM.pony_items = {}
	PPM.cid=1

	//SLOTIDS
	// 0 = HEAD = L1
	// 1 = NECK = L2
	// 2 = FBODY = L3
	// 3 = FLLEG = L4
	// 4 = FRLEG = L5
	// 5 = FLHOOF = L6
	// 6 = FRHOOF = L7 

	// 7 = EYES = R1
	// 8 = SUIT = R2
	// 9 = NONE = R3
	//10 = BLLEG = R4
	//11 = BRLEG = R5
	//12 = BLHOOF = R6
	//13 = BRHOOF = R7

	function PPM:AddItem( basemodel, name, img, bg, bgvF,bgvM, slots,colorcount )
		local pitem = {}
		pitem.id = PPM.cid
		pitem.model = basemodel
		pitem.name = name
		pitem.img = img
		pitem.bid = bg
		pitem.bvalf = bgF
		pitem.bvalm = bgM
		pitem.slots = slots
		pitem.colorcount = colorcount
		pitem.suit=false
		
		PPM.pony_items[PPM.cid] = pitem
		PPM.cid=PPM.cid+1 
	end

	function PPM:AddSuit( basemodel, name, img, textureF, textureM,bgvM,colorcount )
		local pitem = {}
		pitem.id = PPM.cid
		pitem.model = basemodel
		pitem.name = name
		pitem.img = img
		pitem.texf = textureF
		pitem.texm = textureM 
		pitem.slots = {8}
		pitem.colorcount = colorcount
		pitem.suit=true
		
		PPM.pony_items[PPM.cid] = pitem
		PPM.cid=PPM.cid+1 
	end
	function PPM:GetEquippedItems(ply,playermodel)
		local ait = {}
		for i,k in pairs(PPM.pony_items) do
			if(k.model==playermodel )then 
				for c=1,14 do 
					local bvalue = ply.ponydata.clothes1:GetBodygroup(c)
					if( k.bid == c and k.bval == bvalue) then
						ait[k.bid] = k
					end
				end
			end
		end
		return ait
	end
	function PPM:pi_GetItemByName(itemname) 
		for i,k in pairs(PPM.pony_items) do
			if(k.name==itemname) then 
				return k
			end
		end
		return nil
	end
	function PPM:pi_GetItemById(itemid)  
		return PPM.pony_items[itemid] 
	end
	function PPM:pi_SetupItem(item,ply) 
		ply.pi_wear = ply.pi_wear or {}
		for c,SLOT in pairs(item.slot) do
			ply.pi_wear[SLOT] = item
		end
		ply.ponydata.clothes1:SetBodygroup(item.bid,item.bval)
		//MsgN("BODYGROUP CHANGE "..item.bid.."-"..item.bval)
	end
	function PPM:pi_UnequipAll(ply)
		if(ply.pi_wear!=nil) then
			for I=0,14 do
				ply.pi_wear[I] = nil 
				ply.ponydata.clothes1:SetBodygroup(I,0) 
			end 
		end
	end

end