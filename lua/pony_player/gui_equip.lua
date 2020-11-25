

if(CLIENT) then  

concommand.Remove("ppm_equipment")
concommand.Add("ppm_equipment",function( ply )
	ppmeq_Open()
end)

LocalPlayer().pi_wear =LocalPlayer().pi_wear or {}
PONYPM_CL.slots = {}
PONYPM_CL.slot_frames = {}

selection_box = nil

function ppmeq_Open()
	
	LocalPlayer().pi_wear =LocalPlayer().pi_wear or {}
	local window = vgui.Create("DFrame")
	window.Close = function() 
		window:Remove( )
	end 
	window:SetSize(512, 512+25)
	window:SetAlpha( 255)
	window:SetTitle( "Equipment" )
	window:SetVisible( true )
	window:MakePopup()
	
	iBack = vgui.Create("DImage", window)
	iBack:Dock( FILL )
	iBack:SetImage( "gui/equip_panel.png" )
	
	for I=0 , 6 do
	
		
		local eqSlotL = vgui.Create("DImageButton",window)
		local eqSlotLFrame = vgui.Create("DImageButton",window)
		PONYPM_CL.slots[I] = eqSlotL
		PONYPM_CL.slot_frames[I] = eqSlotLFrame
		
		eqSlotL:SetPos(10, 25+5+I*70)
		eqSlotL:SetSize(64, 64)
		eqSlotL:SetImage( "gui/item.png" )
		
		eqSlotL.witem = LocalPlayer().pi_wear[I]
		
		
		
			/*
		if(eqSlotL.witem !=nil) then
			eqSlotLFrame:SetTooltip( eqSlotL.witem.name )  
			eqSlotL:SetImage( "gui/items/"..eqSlotL.witem.img..".png" )
			LocalPlayer():SetBodygroup(eqSlotL.witem.bid,eqSlotL.witem.bval) 
		end
		*/
		  
		
		eqSlotLFrame:SetPos(7, 25+2+I*70)
		eqSlotLFrame:SetSize(69, 69)
		eqSlotLFrame:SetImage( "gui/item.png" )
		  
		eqSlotLFrame.OnMousePressed= 
		function()
			if(selection_box!=nil) then
				selection_box.Remove(selection_box)
			end
			ppmeq_OpenItemMenu(I,25+5+I*70,window,false)
		end
		
		eqSlotLFrame.OnCursorEntered=
		function() 
			eqSlotLFrame:SetImage( "gui/item_on.png" ) 
			
			iBack:SetImage( "gui/equip_panel_L"..(I+1)..".png" )
		end
		eqSlotLFrame.OnCursorExited=
		function()  
			eqSlotLFrame:SetImage( "gui/item.png" ) 
			
			if(eqSlotL.witem !=nil) then
				eqSlotL:SetImage( "gui/items/"..eqSlotL.witem.img..".png" )
			else
				eqSlotL:SetImage( "gui/item.png" )
			end
			iBack:SetImage( "gui/equip_panel.png" )
		end
		
		
		if(I>1) then
		
			local eqSlotR = vgui.Create("DImageButton",window)
			local eqSlotRFrame = vgui.Create("DImageButton",window)
			PONYPM_CL.slots[I+7] = eqSlotR
			PONYPM_CL.slot_frames[I+7] = eqSlotRFrame
		 
			eqSlotR:SetPos(512 - 10-66, 25+5+I*70)
			eqSlotR:SetSize(64, 64) 
			eqSlotR:SetImage( "gui/item.png" )
			
			eqSlotR.witem = LocalPlayer().pi_wear[I+7]
			
			    
			/*
			if(eqSlotR.witem !=nil) then
				eqSlotRFrame:SetTooltip( eqSlotR.witem.name )  
				eqSlotR:SetImage( "gui/items/"..eqSlotR.witem.img..".png" )
				LocalPlayer():SetBodygroup(eqSlotR.witem.bid,eqSlotR.witem.bval)
			end
			*/
			
			
			eqSlotRFrame:SetPos(512 - 13-66, 25+2+I*70)
			eqSlotRFrame:SetSize(69, 69)
			eqSlotRFrame:SetImage( "gui/item.png" )
			  
			eqSlotRFrame.OnMousePressed= 
			function()
				if(selection_box!=nil) then
					selection_box.Remove(selection_box)
				end
				ppmeq_OpenItemMenu(I+7,25+5+I*70,window,true)
			end
			
			eqSlotRFrame.OnCursorEntered=
			function() 
				eqSlotRFrame:SetImage( "gui/item_on.png" ) 
				
				iBack:SetImage( "gui/equip_panel_R"..(I+1)..".png" )
			end
			eqSlotRFrame.OnCursorExited=
			function()  
				eqSlotRFrame:SetImage( "gui/item.png" ) 
				
				if(eqSlotR.witem !=nil) then
					eqSlotR:SetImage( "gui/items/"..eqSlotR.witem.img..".png" )
				else
					eqSlotR:SetImage( "gui/item.png" )
				end
				iBack:SetImage( "gui/equip_panel.png" )
			end
		
		
		/*
			local eqSlotR = vgui.Create("DImageButton",window)
			eqSlotR:SetPos(512 - 10-66, 25+5+I*70)
			eqSlotR:SetSize(66, 66)
			eqSlotR:SetImage( "gui/item.png" )
			eqSlotR.OnCursorEntered=
			function() 
				eqSlotR:SetImage( "gui/item_on.png" )
				
				iBack:SetImage( "gui/equip_panel_R"..(I+1)..".png" )
			end
			eqSlotR.OnCursorExited=
			function() 
				eqSlotR:SetImage( "gui/item.png" )
				iBack:SetImage( "gui/equip_panel.png" )
				iBack:SetImage( "gui/equip_panel.png" )
			end
			*/
		end
	end
		//MsgN("FFFF ")
	local plymodel =LocalPlayer():GetInfo( "cl_playermodel" )
	local curitems =PONYPM:GetEquippedItems(LocalPlayer(),plymodel)
	for i,k in pairs(curitems) do 
		//MsgN("FFFF "..i..k.name)
		for c,v in pairs(k.slot) do 
			LocalPlayer().pi_wear[v] = k
		end
	end
	UpdateSlots()
end
function ppmeq_OpenItemMenu(slotid ,pos,window,r)
	local plymodel =LocalPlayer():GetInfo( "cl_playermodel" )
	local avitems = PONYPM:GetAvailItems(plymodel,slotid)
	
	//MsgN("LIstBegin" ..slotid.." - "..plymodel)
	if avitems != nil then
		for i,k in pairs(avitems) do
			//MsgN(k.name .. " - " .. k.model .. " " .. k.bid .. " - " .. k.bval)
			for c,v in pairs(k.slot) do
				//MsgN("   slot - "..v)
			end
		end
	end
	//MsgN("LIstEnd")
	 
	
	if avitems != nil then
	
		
		local PanelSelect = window:Add( "DPanelSelect" )
			local xw = math.Clamp(table.Count(avitems),1,5)*70
		if r then
			PanelSelect:SetPos(512 -66-xw,pos)
		else
			PanelSelect:SetPos(74,pos)
		end
		PanelSelect:SetSize(5*70,3*70)
		//PanelSelect:SetAlpha( 255)
		selection_box =PanelSelect
		for name, item in SortedPairs( avitems ) do

			local icon =  vgui.Create( "DImageButton" )
			icon:SetImage( "gui/items/"..item.img..".png" )
			icon:SetSize( 64, 64 ) 
			icon:SetTooltip( item.name )  
			icon.OnMousePressed= 
			function()
				for i,slot in pairs(item.slot) do
					LocalPlayer().pi_wear[slot] = item
					//MsgN("set slot["..slot.."] = "..item.name)
				end
				
				net.Start("player_equip_item")
				net.WriteFloat(item.id) 
				net.SendToServer()
				
				PanelSelect.Remove(PanelSelect)
				UpdateSlots()
			end
			PanelSelect:AddPanel( icon , { }) 

		end  
	end
end 
function UpdateSlots()
	for I=0 , 6 do
		local eqSlotL =PONYPM_CL.slots[I] 
		local eqSlotLFrame =PONYPM_CL.slot_frames[I] 
		if eqSlotL!=nil then 
			eqSlotL.witem = LocalPlayer().pi_wear[I]
			if(eqSlotL.witem !=nil) then
				 
				eqSlotLFrame:SetTooltip( eqSlotL.witem.name )  
				eqSlotL:SetImage( "gui/items/"..eqSlotL.witem.img..".png" )
					//MsgN("IMGGET slot["..I.."] = "..eqSlotL.witem.name)
				PONYPM:pi_SetupItem(eqSlotL.witem,LocalPlayer()) 
			end
		end
		//MsgN("SLOT "..I.." - CHECK")
		
		local eqSlotR =PONYPM_CL.slots[I+7] 
		local eqSlotRFrame =PONYPM_CL.slot_frames[I+7] 
		if eqSlotR!=nil then 
			eqSlotR.witem = LocalPlayer().pi_wear[I+7]
			if(eqSlotR.witem !=nil) then
				
				eqSlotRFrame:SetTooltip( eqSlotR.witem.name )  
				eqSlotR:SetImage( "gui/items/"..eqSlotR.witem.img..".png" )
				PONYPM:pi_SetupItem(eqSlotR.witem,LocalPlayer()) 
			end
		end
		//MsgN("SLOT ".. I+7 .." - CHECK")
	end
end
end