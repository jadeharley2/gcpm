AddCSLuaFile()
module( "gcpme", package.seeall )

panels = panels or {}


panels.edit_color =
{
	spawn = function( parent,variable)
	
        local VALUE =PPM.editor_ponydata[variable.param] or Vector(1,1,1)
        
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
        SELECTOR:SetAlphaBar(false)
        
        SELECTOR:SetColor(Color(VALUE.x*255,VALUE.y*255,VALUE.z*255,255))
        INDICATOR:SetColor(Color(VALUE.x*255,VALUE.y*255,VALUE.z*255,255)) 
        
        SELECTOR:Dock( FILL )
        
        SELECTOR.ValueChanged	= function() 
        
            local v2 =SELECTOR:GetVector()
            Data[variable.param] = v2
            INDICATOR:SetColor(Color(v2.x*255,v2.y*255,v2.z*255,255)) 
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
		end
	end
}
panels.select_species =
{
    spawn = function( parent,variable)
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
					gcpme.SelectSpecies(k,kk)
				end 
				ITEM.OnCursorExited = function() 
					--PPM.editor_ponydata[variable.param] = VARIABLE
					gcpme.SelectSpecies(Data.species,Data.race)
				end 
				ITEM.DoClick = function()  
					gcpme.SelectSpecies(k,kk)
					Data.species = k
					Data.race = kk
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
