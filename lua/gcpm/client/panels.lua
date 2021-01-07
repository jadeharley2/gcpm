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
        
            local v2 =SELECTOR:GetColor()
            Data[variable.param] = v2
			gcpm.Update(Character)
            INDICATOR:SetColor(v2) 
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
		 
		SELECTOR:SetValue( Data[variable.param]==variable.onvalue)
		 
		SELECTOR.OnChange = function(  pSelf, fValue) 
			if(fValue) then 
				Data[variable.param] = variable.onvalue 
			else
				Data[variable.param] = variable.offvalue 
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