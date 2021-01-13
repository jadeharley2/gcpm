AddCSLuaFile()
module( "gcpme", package.seeall )

panels = panels or {}


panels.edit_color =
{
	spawn = function( parent,variable)
	
        local VALUE = Data[variable.param] or Color(255,255,255)
        
        local CONTAINER = vgui.Create( "DPanel", parent ) 
        CONTAINER:SetSize( 200, 220 ) 
        CONTAINER:Dock( TOP )
         
        
        local INDICATOR = vgui.Create("DImageButton",CONTAINER)
        INDICATOR:Dock( LEFT )
        INDICATOR:SetSize( 20, 20 ) 
        INDICATOR:SetImage( "gui/editor/pictorect.png" )
        
        local SELECTOR = vgui.Create("DColorMixer",CONTAINER)
        SELECTOR:SetSize( 100, 100 ) 
        SELECTOR:SetPos( 20, 20 ) 
        SELECTOR:SetAlphaBar(true)
        
        SELECTOR:SetColor(VALUE)
        INDICATOR:SetColor(VALUE) 
        
        SELECTOR:Dock( FILL )
        
        SELECTOR.ValueChanged	= function() 
			timer.Simple(0.04, function()
				local v2 =SELECTOR:GetColor()
				Data[variable.param] = v2
				gcpm.Update(Character)
				INDICATOR:SetColor(v2) 
			end)
        end 
        
	end
}

panels.edit_number =
{
    spawn = function( parent,variable)
        
		local SELECTOR = vgui.Create("DNumSlider",parent)
		SELECTOR:SetMin( variable.min ) 
		SELECTOR:SetMax( variable.max )
		SELECTOR:SetPos( 20, 20 )  
		SELECTOR:SetSize( 20, 20 )  
		SELECTOR:Dock( TOP )
		
		SELECTOR:SetValue( Data[variable.param] )
		
		SELECTOR.OnValueChanged	= function() 
			Data[variable.param]=SELECTOR:GetValue()  
			gcpm.Update(Character)
		end 
		 
	end
}

panels.edit_bool =
{
	spawn = function( parent,variable)
		  
		local SELECTOR = vgui.Create("DCheckBoxLabel",parent) 
		SELECTOR:SetPos( 20, 20 )  
		SELECTOR:Dock( TOP )
		 
		SELECTOR:SetValue( Data[variable.param]==(variable.onvalue or true))
		 
		SELECTOR.OnChange = function(  pSelf, fValue) 
			if(fValue) then 
				Data[variable.param] = variable.onvalue or true
			else
				Data[variable.param] = variable.offvalue or false
			end
			gcpm.Update(Character)
		end
	end
}
panels.select_species =
{
    spawn = function( parent,variable)

		local cspecies = Data.species
		local crace = Data.race

		local available = gcpm.GetSpeciesList()
		
		local indicators = {}
		for k , v in pairs(available) do
			local header = vgui.Create( "DButton", parent ) 
			header:SetSize( 100, 20 )
			header:Dock( TOP )
			header:SetText(v.PrintName)
			for kk,vv in pairs(v.Races) do

				local ITEM_CONTAINER = vgui.Create( "DPanel", parent ) 
				ITEM_CONTAINER:SetSize( 100, 20 )
				ITEM_CONTAINER:Dock( TOP )
				
				local ITEM_INDICATOR = vgui.Create( "DImageButton", ITEM_CONTAINER )
				ITEM_INDICATOR:SetImage( "gui/editor/pictorect.png" )
				ITEM_INDICATOR:SetSize( 20, 20 )
				ITEM_INDICATOR:Dock( LEFT ) 
				ITEM_INDICATOR.s = k
				ITEM_INDICATOR.r = kk
				indicators[kk] = ITEM_INDICATOR
				
				if k==Data.species and kk==Data.race then 
					ITEM_INDICATOR:SetColor(Color(200,255,200)) 
				else
					ITEM_INDICATOR:SetColor(Color(100,100,100))
				end
				local ITEM = vgui.Create( "DButton", ITEM_CONTAINER ) 
				ITEM:SetSize( 200, 20 ) 
				--ITEM:SetBGColor(PPM.colorcircles(k)) 
				ITEM:Dock( FILL )
				ITEM:SetText(vv.name)
				ITEM.OnCursorEntered = function() 
					--PPM.editor_ponydata[variable.param] = k
					Data.species = k
					Data.race = kk
					gcpm.Update(Character)
					gcpme.SelectSpecies(k,kk)
				end 
				ITEM.OnCursorExited = function() 
					--PPM.editor_ponydata[variable.param] = VARIABLE
					--gcpme.SelectSpecies(Data.species,Data.race)
					Data.species = cspecies
					Data.race = crace
					gcpm.Update(Character) 
					gcpme.SelectSpecies(cspecies,crace)
				end 
				ITEM.DoClick = function()  
					Data.species = k
					Data.race = kk
					cspecies = k
					crace = kk 
					gcpm.Update(Character)
					gcpme.SelectSpecies(k,kk)

					for k,v in pairs(indicators) do
						if v.s==Data.species and v.r==Data.race then 
							v:SetColor(Color(200,255,200)) 
						else
							v:SetColor(Color(100,100,100))
						end
					end
				end 
			end
		end
		 
	end
}



local INDICATOR_ONE = nil
local INDICATOR_TWO = nil
function NewPresetMenu(parent,dPresetList)  
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	
	local smenupanel = vgui.Create("DPanel",parent:GetParent())
	local x,y =0,0 
	local px,py =0,0 
	local w,h =parent:GetSize()
	smenupanel:SetSize( w, h*3 )  
	smenupanel:SetPos(parent:GetPos())
	smenupanel:SetKeyboardInputEnabled(true)
	curmenupanel = smenupanel
	
	local nfNInput = vgui.Create("DTextEntry", smenupanel)
	nfNInput:SetText("NewFileName")
	nfNInput:SetSize( 20, h ) 
	nfNInput:Dock( TOP )
	nfNInput:SetKeyboardInputEnabled(true)
	local bPSave = vgui.Create( "DButton", smenupanel )
	bPSave:SetSize( 20, h ) 
	bPSave:Dock( BOTTOM )
	bPSave:SetPos(0,0)
	bPSave:SetText( "SAVE" )
	bPSave.DoClick = function( button ) 
		local selected_fname =nfNInput:GetValue( )
		if(selected_fname==nil or string.Trim(selected_fname)=="") then 
			return 
		end
		--if(table.HasValue( PPM.reservedPresetNames,selected_fname)) then 
		--	return 
		--end

		gcpm.Save(selected_fname,Data)  
		 
		LoadFileList(dPresetList)
		smenupanel:Remove( )  curmenupanel = nil
	end
	local bExit = vgui.Create( "DButton", smenupanel )
	bExit:SetSize( 20, h ) 
	bExit:Dock( BOTTOM )
	bExit:SetPos(0,0)
	bExit:SetText( "CANCEL" )
	bExit.DoClick = function( button ) 
		smenupanel:Remove( )  curmenupanel = nil
	end
end

function LoadFileList(CTL)
	CTL:Clear() 
	for k,v in pairs(gcpm.ListPresets()) do
		CTL:AddLine(v)   
	end
end

function colorFlash(controll, time, color,defcolor)
	if controll then   
		controll:SetColor(color)
		timer.Simple(time,function()
			controll:SetColor(defcolor)
		end)
	end
end


panels.presets = {
	
	
	spawn = function( parent,variable)
		  
		 
		
		local CONTAINER = vgui.Create( "DPanel", parent ) 
		CONTAINER:SetSize( 200, 900 ) 
		CONTAINER:Dock( TOP )
		    
		local INDICATOR = vgui.Create("DImageButton",CONTAINER)
		INDICATOR:Dock( LEFT )
		INDICATOR:SetSize( 20, 1000 ) 
		INDICATOR:SetImage( "gui/editor/pictorect.png" )
		local INDICATOR2 = vgui.Create("DImageButton",CONTAINER)
		INDICATOR2:Dock( RIGHT )
		INDICATOR2:SetSize( 20, 1000 ) 
		INDICATOR2:SetImage( "gui/editor/pictorect.png" )
		
		INDICATOR_ONE = INDICATOR
		INDICATOR_TWO = INDICATOR2
		
		local dPresetList = vgui.Create("DListView") 
		dPresetList:SetParent(CONTAINER) 
		dPresetList:SetPos(0,0)
		dPresetList:SetSize(ScrW()/8, ScrH()*1/2)
		dPresetList:SetMultiSelect(false)
		dPresetList:Dock( TOP )
		dPresetList:AddColumn("Preset list") 
		  
		
		local bAddPreset = vgui.Create( "DButton", CONTAINER ) 
		bAddPreset:SetSize( 180, 30 )
		bAddPreset:Dock( TOP )
		bAddPreset:SetText( "New Preset" )
		bAddPreset.DoClick = function( button )
			NewPresetMenu(bAddPreset,dPresetList) 
		end
		
		local bDelPreset = vgui.Create( "DButton", CONTAINER ) 
		local SPACE = vgui.Create("DImageButton",CONTAINER)
		local button_save = vgui.Create("DButton",CONTAINER)
		bDelPreset.goDef = function() 
			if bDelPreset.bdel!=nil then
				bDelPreset.bdel:Remove()
				bDelPreset.bdel=nil
			end
			bDelPreset:SetSize( 180, 30 )
			bDelPreset:Dock( TOP )
			bDelPreset:SetText( "Delete" )
			bDelPreset.sure =false
			button_save:SetSize( 180, 30 ) 
		end
		bDelPreset.goDef()
		bDelPreset.DoClick = function( button )
		 
			local selline =dPresetList:GetSelectedLine()
			if(selline==nil) then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(0,0,0))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(0,0,0))
				bDelPreset.goDef()
			return end
			local selected_fname =dPresetList:GetLine(selline):GetColumnText(1)
			if(selected_fname==nil) then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(0,0,0))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(0,0,0))
				bDelPreset.goDef()
			return end
			if(table.HasValue(PPM.reservedPresetNames,selected_fname))then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(255,255,255))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(255,255,255))
			return end
			 
		
		
			if !bDelPreset.sure then
				bDelPreset:SetText( "NO!" )
				bDelPreset:SetSize( 180, 15 )
				bDelPreset.sure=true
				button_save:SetSize( 180, 15 )
				bDelPreset.bdel = vgui.Create( "DButton", button_save )
				bDelPreset.bdel:SetSize( 180, 15 )
				bDelPreset.bdel:Dock( BOTTOM )
				bDelPreset.bdel:SetText( "YES, DELETE!" )
				bDelPreset.bdel.DoClick = function( button )
					gcpm.Delete(selected_filename) -- file.Delete("gcpm/"..selected_fname)
					LoadFileList(dPresetList) 
					bDelPreset.goDef()
				end
			else
				bDelPreset.goDef()
			end
		end
		
		
		SPACE:Dock( TOP )
		SPACE:SetSize(  180, 30  )  
		
		button_save:SetSize( 180, 30 )     
		button_save:SetText( "SAVE" )
		button_save:Dock( TOP )
		PPM.button_save=button_save 
		button_save.DoClick = function( button )   
		
			local selline =dPresetList:GetSelectedLine()
			if(selline==nil) then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(255,255,255))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(255,255,255))
			return end
			local selected_fname =dPresetList:GetLine(selline):GetColumnText(1)
			if(selected_fname==nil) then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(255,255,255))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(255,255,255))
			return end
			if(table.HasValue(PPM.reservedPresetNames,selected_fname))then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(255,255,255))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(255,255,255))
			return end
			gcpm.Save(selected_fname,Data) 
			colorFlash(INDICATOR_ONE, 0.1, Color(0,200,0),Color(255,255,255))
			colorFlash(INDICATOR_TWO, 0.1, Color(0,200,0),Color(255,255,255))
			 
			LoadFileList(dPresetList)  
		end
		 
		local button_load = vgui.Create("DButton",CONTAINER) 
		button_load:SetSize( 180, 30 )       
		button_load:Dock( TOP )
		button_load:SetText( "LOAD" )
		
		button_load.DoClick = function( button )   
		 
			local selline =dPresetList:GetSelectedLine()
			if(selline==nil) then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(255,255,255))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(255,255,255))
			return end
			local selected_fname =dPresetList:GetLine(selline):GetColumnText(1)
			if(selected_fname==nil) then
				colorFlash(INDICATOR_ONE, 0.1, Color(200,0,0),Color(255,255,255))
				colorFlash(INDICATOR_TWO, 0.1, Color(200,0,0),Color(255,255,255))
			return end
			
			local NewData = gcpm.Load(selected_fname)
			for k,v in pairs(Data) do
				Data[k] = nil
			end
			for k,v in pairs(NewData) do
				Data[k] = v
			end
			gcpm.InitSpeciesParams(Character)
			gcpm.Update(Character)
		---	PPM.cleanPony(PPM.editor3_pony)
		---	PPM.mergePonyData(PPM.editor_ponydata,PPM.Load(selected_fname))
			 
			colorFlash(INDICATOR_ONE, 0.1, Color(0,200,0),Color(255,255,255))
			colorFlash(INDICATOR_TWO, 0.1, Color(0,200,0),Color(255,255,255))
		end
		
		local SPACE2 = vgui.Create("DImageButton",CONTAINER)
		SPACE2:Dock( TOP )
		SPACE2:SetSize(  180, 30  ) 
		 
		
			
		--local button_reset = vgui.Create("DButton",CONTAINER) 
		--button_reset:SetSize( 180, 30  )  
		--button_reset:SetText( "Clear" )
		--button_reset:Dock( TOP )
		--   
		--button_reset.DoClick = function( button )   
		-----	PPM.cleanPony(LocalPlayer())  
		--	colorFlash(INDICATOR_ONE, 0.1, Color(0,200,0),Color(255,255,255))
		--	colorFlash(INDICATOR_TWO, 0.1, Color(0,200,0),Color(255,255,255)) 
		--end
		  
		--local button_rnd =  vgui.Create("DButton",CONTAINER) 
		--button_rnd:SetSize( 180, 30  )  
		--button_rnd:SetText( "Randomize" )
		--button_rnd:Dock( TOP )
		-- 
		--button_rnd.DoClick = function( button )    
		-----	PPM.randomizePony(LocalPlayer())  
		--	colorFlash(INDICATOR_ONE, 0.1, Color(0,200,0),Color(255,255,255))
		--	colorFlash(INDICATOR_TWO, 0.1, Color(0,200,0),Color(255,255,255)) 
		--end
		
		LoadFileList(dPresetList)
	end
}

panels.edit_part = {
	spawn = function( parent,variable)
		local param = variable.param 
		local cvalue = Data[param]

		local available = gcpm.GetParts(Data,param)
		
		local indicators = {}
		for k , v in SortedPairs(available) do 

			local ITEM_CONTAINER = vgui.Create( "DPanel", parent ) 
			ITEM_CONTAINER:SetSize( 100, 20 )
			ITEM_CONTAINER:Dock( TOP )
			
			local ITEM_INDICATOR = vgui.Create( "DImageButton", ITEM_CONTAINER )
			ITEM_INDICATOR:SetImage( "gui/editor/pictorect.png" )
			ITEM_INDICATOR:SetSize( 20, 20 )
			ITEM_INDICATOR:Dock( LEFT ) 
			ITEM_INDICATOR.s = k 
			indicators[k] = ITEM_INDICATOR
			
			local function UpdateIndicator(vv,val) 
				if vv.s==val then 
					vv:SetColor(Color(200,255,200)) 
				else
					vv:SetColor(Color(100,100,100))
				end
			end

			UpdateIndicator(ITEM_INDICATOR,cvalue) 


			local ITEM = vgui.Create( "DButton", ITEM_CONTAINER ) 
			ITEM:SetSize( 200, 20 )  
			ITEM:Dock( FILL )
			ITEM:SetText(v.name or k)
			ITEM.OnCursorEntered = function()  
				Data[param] = k 
				gcpm.Update(Character)
			end 
			ITEM.OnCursorExited = function()  
				Data[param] = cvalue
				gcpm.Update(Character)
			end 
			ITEM.DoClick = function()   
				Data[param] = k 
				cvalue = k
				gcpm.Update(Character)
				for _,vv in pairs(indicators) do
					UpdateIndicator(vv,k) 
				end
			end  
		end
	end
}

panels.edit_texpart = {
	spawn = function( parent,variable)
		local param = variable.param 
		local cvalue = Data[param]

		local available = gcpm.GetTexParts(Data,param)
		
		local indicators = {}
		for k , v in SortedPairs(available) do 

			local ITEM_CONTAINER = vgui.Create( "DPanel", parent ) 
			ITEM_CONTAINER:SetSize( 100, 20 )
			ITEM_CONTAINER:Dock( TOP )
			
			local ITEM_INDICATOR = vgui.Create( "DImageButton", ITEM_CONTAINER )
			ITEM_INDICATOR:SetImage( "gui/editor/pictorect.png" )
			ITEM_INDICATOR:SetSize( 20, 20 )
			ITEM_INDICATOR:Dock( LEFT ) 
			ITEM_INDICATOR.s = k 
			indicators[k] = ITEM_INDICATOR
			
			local function UpdateIndicator(vv,val) 
				if vv.s==val then 
					vv:SetColor(Color(200,255,200)) 
				else
					vv:SetColor(Color(100,100,100))
				end
			end

			UpdateIndicator(ITEM_INDICATOR,cvalue) 


			local ITEM = vgui.Create( "DButton", ITEM_CONTAINER ) 
			ITEM:SetSize( 200, 20 )  
			ITEM:Dock( FILL )
			ITEM:SetText(v.name or k)
			ITEM.OnCursorEntered = function()  
				Data[param] = k 
				gcpm.Update(Character)
			end 
			ITEM.OnCursorExited = function()  
				Data[param] = cvalue
				gcpm.Update(Character)
			end 
			ITEM.DoClick = function()   
				Data[param] = k 
				cvalue = k
				gcpm.Update(Character)
				for _,vv in pairs(indicators) do
					UpdateIndicator(vv,k) 
				end
			end  
		end
	end
}

panels.edit_texpart2 = {
	spawn = function( parent,variable)
		local param = variable.param 
		local cvalue = Data[param]

		local available = gcpm.GetTexParts(Data,param)
		local width = 70


		local indicators = {}
		local function UpdateIndicator(vv,val) 
			if vv.s==val then 
				vv:SetColor(Color(255,255,255)) 
			else
				vv:SetColor(Color(100,100,100))
			end
		end 

		local function addrow() 
			local ITEM = vgui.Create( "DPanel", parent ) 
			ITEM:SetSize( width, width )
			ITEM:Dock( TOP ) 
			function ITEM:Paint(w,h) 
				draw.RoundedBox(0, 0,0,w,h, Color(0,0,0,200)) 
			end
			return ITEM
		end
		local crow = addrow()
		local function additem(k,v,param)
			if #crow:GetChildren()>2 then
				crow = addrow()
			end

			local ITEM = vgui.Create( "DImageButton", crow ) 
			ITEM:SetSize( width, width )
			ITEM:Dock( LEFT )
			ITEM:SetImage(v.material)
			ITEM.s = k
			ITEM.OnCursorEntered = function()  
				Data[param] = k 
				gcpm.Update(Character)
			end 
			ITEM.OnCursorExited = function()  
				Data[param] = cvalue
				gcpm.Update(Character)
			end 
			ITEM.DoClick = function()   
				Data[param] = k 
				cvalue = k
				gcpm.Update(Character)
				for _,vv in pairs(indicators) do
					UpdateIndicator(vv,k) 
				end
			end   
			UpdateIndicator(ITEM,cvalue) 
			indicators[#indicators+1] = ITEM
		end

		local indicators = {}
		for k , v in SortedPairs(available) do 
			additem(k,v,param)
		end
	end
}


panels.edit_skin = {
	spawn = function( parent,variable) 
		local param = variable.param 
		local cvalue = Data[param]

		local available = variable.choices or {}
		MsgN("Vtable")
		PrintTable(variable)
		
		local cvalue = Data[param]
		
		local indicators = {} 
		for k , v in SortedPairs(available) do 
			local val = v.val

			local ITEM_CONTAINER = vgui.Create( "DPanel", parent ) 
			ITEM_CONTAINER:SetSize( 100, 20 )
			ITEM_CONTAINER:Dock( TOP )
			
			local ITEM_INDICATOR = vgui.Create( "DImageButton", ITEM_CONTAINER )
			ITEM_INDICATOR:SetImage( "gui/editor/pictorect.png" )
			ITEM_INDICATOR:SetSize( 20, 20 )
			ITEM_INDICATOR:Dock( LEFT ) 
			ITEM_INDICATOR.s = val
			indicators[k] = ITEM_INDICATOR
			
			local function UpdateIndicator(vv,val) 
				if vv.s==val then 
					vv:SetColor(Color(200,255,200)) 
				else
					vv:SetColor(Color(100,100,100))
				end
			end

			UpdateIndicator(ITEM_INDICATOR,cvalue) 


			local ITEM = vgui.Create( "DButton", ITEM_CONTAINER ) 
			ITEM:SetSize( 200, 20 )  
			ITEM:Dock( FILL )
			ITEM:SetText(v.name)
			ITEM.OnCursorEntered = function()
				Data[param] = val
				gcpm.Update(Character)   
			end 
			ITEM.OnCursorExited = function()  
				Data[param] = cvalue 
				gcpm.Update(Character)
			end 
			ITEM.DoClick = function()   
				Data[param] = val
				cvalue = val
				gcpm.Update(Character)
				for _,vv in pairs(indicators) do
					UpdateIndicator(vv,val) 
				end
			end  
		end
	end
}

local expand_layer = function(parent,cvalue,colvalue,variable,item,update)
	local param = item.type
	local colparam = item.color 

	local available = file.Find(variable.path.."*.png", "GAME") 
	  
	

	local SELECTOR = vgui.Create("DColorMixer",parent)
	SELECTOR:SetSize( 100, 200 ) 
	SELECTOR:SetPos( 20, 20 ) 
	SELECTOR:SetAlphaBar(true) 
	SELECTOR:SetColor(Data[colparam])  
	SELECTOR:Dock( TOP )

	SELECTOR.ValueChanged	= function()  
		timer.Simple(0.04, function()
			local v2 =SELECTOR:GetColor()
			Data[colparam] = v2
			gcpm.Update(Character) 
			update(Data[param],Data[colparam])
		end)
	end 
	MsgN("SEL ",SELECTOR)


	local indicators = {} 
	for k , v in SortedPairs(available) do  
		local val = string.sub(v, 1, -5)
		local ITEM_CONTAINER = vgui.Create( "DPanel", parent ) 
		ITEM_CONTAINER:SetSize( 100, 20 )
		ITEM_CONTAINER:Dock( TOP ) 

		local ITEM_INDICATOR = vgui.Create( "DImageButton", ITEM_CONTAINER )
		ITEM_INDICATOR:SetImage( "gui/editor/pictorect.png" )
		ITEM_INDICATOR:SetSize( 20, 20 )
		ITEM_INDICATOR:Dock( LEFT ) 
		ITEM_INDICATOR.s = val
		indicators[k] = ITEM_INDICATOR
		
		local function UpdateIndicator(vv,val) 
			if vv.s==val then 
				vv:SetColor(Color(200,255,200)) 
			else
				vv:SetColor(Color(100,100,100))
			end
		end

		UpdateIndicator(ITEM_INDICATOR,cvalue) 


		local ITEM = vgui.Create( "DButton", ITEM_CONTAINER ) 
		ITEM:SetSize( 200, 20 )  
		ITEM:Dock( FILL )
		ITEM:SetText(val)
		ITEM.OnCursorEntered = function()
			Data[param] = val
			gcpm.Update(Character)   
		end 
		ITEM.OnCursorExited = function()  
			Data[param] = cvalue 
			gcpm.Update(Character)
		end 
		ITEM.DoClick = function()   
			Data[param] = val
			cvalue = val
			gcpm.Update(Character)
			for _,vv in pairs(indicators) do
				UpdateIndicator(vv,val) 
			end
			update(Data[param],Data[colparam])
		end  
	end
	
end
panels.edit_layers = {
	spawn = function( parent,variable) 
		
		local indicators = {}
		local header = false
		local prmc = #variable.params

		local function build() 
			for k , v in ipairs(variable.params) do
			 
				local cvalue = Data[v.type]
				local colvalue = Data[v.color]
	
				local ITEM_CONTAINER = vgui.Create( "DPanel", parent ) 
				ITEM_CONTAINER:SetSize( 100, 20 )
				ITEM_CONTAINER:Dock( TOP )
				
				local ITEM_INDICATOR = vgui.Create( "DImageButton", ITEM_CONTAINER )
				ITEM_INDICATOR:SetImage( "gui/editor/pictorect.png" )
				ITEM_INDICATOR:SetSize( 20, 20 )
				ITEM_INDICATOR:Dock( RIGHT ) 
				ITEM_INDICATOR:SetColor(colvalue)
				ITEM_INDICATOR.s = val
	
				local ITEM_ID = vgui.Create( "DButton", ITEM_CONTAINER )  
				ITEM_ID:SetText(k)
				ITEM_ID:SetSize( 20, 20 )
				ITEM_ID:Dock( LEFT )  
	
	
				local ITEM_MOVEUP = vgui.Create( "DButton", ITEM_CONTAINER ) 
				if k~=1 then
					ITEM_MOVEUP:SetText("▲")
				else 
					ITEM_MOVEUP:SetText(" ")
				end
				ITEM_MOVEUP:SetSize( 20, 20 )
				ITEM_MOVEUP:Dock( LEFT )  
				ITEM_MOVEUP.DoClick = function()   
	
				end
				local ITEM_DOWN = vgui.Create( "DButton", ITEM_CONTAINER ) 
				if k~=prmc then
					ITEM_DOWN:SetText("▼")
				else 
					ITEM_DOWN:SetText(" ")
				end
				ITEM_DOWN:SetSize( 20, 20 )
				ITEM_DOWN:Dock( LEFT ) 
				ITEM_DOWN.DoClick = function()   
	
				end
	 
	
				local ITEM = vgui.Create( "DButton", ITEM_CONTAINER ) 
				ITEM:SetSize( 300, 20 )  
				ITEM:Dock( TOP )
				ITEM:SetText( cvalue) 
				ITEM.DoClick = function()   
					header:Clear() 
					expand_layer(header,cvalue,colvalue,variable,v,function(a,b)
						ITEM_INDICATOR:SetColor(b)
						ITEM:SetText(  a) 
					end)
					header:SizeToContentsY( )
					parent:GetParent():InvalidateLayout()
	
					
					for _,vv in pairs(indicators) do
						if vv == ITEM then
							vv:SetColor(Color(0,0,200))
						else
							vv:SetColor(Color(0,0,0))
						end
					end
				end  
				indicators[k] = ITEM
			end
		end


		build() 
		header = vgui.Create( "DPanel", parent )	 			 
		header:SetPos( 25, 50 )		 
		header:SetSize( 250, 1000 )	  
		header:Dock(TOP)
	end
}