AddCSLuaFile() 
if SERVER then return end

local PANEL = {}
 


AccessorFunc(PANEL, "text", "Text",FORCE_STRING)
AccessorFunc(PANEL, "xAlign", "XAlign",FORCE_NUMBER)
AccessorFunc(PANEL, "yAlign", "YAlign",FORCE_NUMBER)
AccessorFunc(PANEL, "font", "Font",FORCE_STRING)
AccessorFunc(PANEL, "color", "Color")

function PANEL:Init()
    self.color = Color(255,255,255)
    self.imagecolor = Color(255,255,255) 
    self.xAlign = TEXT_ALIGN_CENTER
    self.yAlign = TEXT_ALIGN_CENTER
end 
function PANEL:SetColor(col) 
    self.color = col
end
function PANEL:SetImage(v) 
    self.image = Material(v)
end
function PANEL:SetImageColor(v) 
    self.imagecolor = v
end
function PANEL:SetBack(v) 
    self.back = v
end
  
function PANEL:Paint(w,h)  
    if self.back then
        render.PushFilterMag( TEXFILTER.ANISOTROPIC )
        render.PushFilterMin( TEXFILTER.ANISOTROPIC )
        surface.SetDrawColor( self.color ) 
        surface.SetMaterial( self.back )  
        surface.DrawTexturedRect( 0,0,w,h ) 
        render.PopFilterMag()
        render.PopFilterMin() 
    end
    if self.image then
        render.PushFilterMag( TEXFILTER.ANISOTROPIC )
        render.PushFilterMin( TEXFILTER.ANISOTROPIC )
        surface.SetDrawColor( self.imagecolor ) 
        surface.SetMaterial( self.image )  
        surface.DrawTexturedRect( 0,0,w,h ) 
        render.PopFilterMag()
        render.PopFilterMin() 
    end

    if self.text then
        local x = 0
        local xAligh = self.xAlign
        local yAligh = self.yAlign
        if xAligh == TEXT_ALIGN_LEFT then
            x = 0
        elseif xAlign == TEXT_ALIGN_RIGHT then
            x = w
        else--center
            x = w/2
        end
        if yAligh == TEXT_ALIGN_TOP then
            y = 0
        elseif yAligh == TEXT_ALIGN_BOTTOM then
            y = h
        else--center
            y = h/2
        end
        
        draw.SimpleText( self.text, 
        self.font, 
        x,
        y, 
        self.color, 
        self.xAlign, 
        self.yAlign)
    end
end 
 
derma.DefineControl( "X_ImageButton", "X_ImageButton", PANEL, "DImageButton" )