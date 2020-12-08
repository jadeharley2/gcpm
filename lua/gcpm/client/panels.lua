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
            PPM.editor_ponydata[variable.param] = v2
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
		
		SELECTOR:SetValue( PPM.editor_ponydata[variable.param] )
		
		SELECTOR.OnValueChanged	= function() 
		--	PPM.editor_ponydata[variable.param]=SELECTOR:GetValue()  
		end 
		 
	end
}

panels.edit_bool =
{
	spawn = function( parent,variable)
		  
		local SELECTOR = vgui.Create("DCheckBoxLabel",parent) 
		SELECTOR:SetPos( 20, 20 )  
		SELECTOR:Dock( TOP )
		 
		SELECTOR:SetValue( PPM.editor_ponydata[variable.param]==variable.onvalue)
		 
		SELECTOR.OnChange = function(  pSelf, fValue) 
			if(fValue) then 
				PPM.editor_ponydata[variable.param]= variable.onvalue
			else
				PPM.editor_ponydata[variable.param]= variable.offvalue
			end
		end
	end
}