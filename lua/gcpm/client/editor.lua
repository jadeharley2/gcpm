
AddCSLuaFile()
module( "gcpme", package.seeall )

list.Set(
	"DesktopWindows", 
	"GCPMEditor",
	{
		title           = "GCPM Editor",
		icon            = "gui/pped_icon.png",
		width           = 960,
		height          = 700,
		onewindow       = true,
		init            = function(icon, window)
		    window:Remove()
			gcpme.Open()
		end
	}
) 
concommand.Add("gcpm_editor",function( ply )
	gcpme.Open()
end)

Window = Window or false
Character = Character or false
Background = Background or false

local FOV = 90
local CameraPos = Vector(0,0,0)
local CameraAngles = Angle(0,70,0)
local CameraAnglesAdd = Angle(0,0,0)

function Open()
	if Window then
		Window:Remove()
		Window = nil
		BuildWindow()
		--Window:MakePopup()
	else
		BuildWindow()
	end
end
function Close()
	if Window then
		Window:Remove()  
		Window = nil
	end
	RemoveBackground(Background)
	Background = nil
end
parts = parts or {}
function SetupBodyPart(id,path) 
	local model2 = parts[id]
	if model2 then
		model2:SetModel(path)
	else 
		local model2 = ClientsideModel( path , RENDER_GROUP_OPAQUE_ENTITY )  
		parts[id] = model2
	end 
	model2:SetParent(Character)
	model2:AddEffects(EF_BONEMERGE)
end
function BuildWindow()
	Window = vgui.Create("DFrame") 
	Window:ShowCloseButton( true )
	Window:SetSize(ScrW(), ScrH()) 
	Window:SetBGColor(255,0,0)
	Window:SetVisible( true )
	Window:SetDraggable(false)
	Window:SetTitle("GCPM Editor")
	Window.Paint = function()  
		surface.SetDrawColor( 0, 0, 0, 255 ) 
		surface.DrawRect( 0, 0, Window:GetWide(), Window:GetTall() )
	end 
	Window.Close = function() 
		Close()
	end
	Window:MakePopup()

	
	local mdl = Window:Add( "DModelPanel")
	mdl:Dock( FILL )
	mdl:SetFOV(90)
	mdl:SetModel( "models/mlp/pony_default/player_default_base.mdl" )
	Character = mdl.Entity
	mdl.camang =Angle(0,70,0)
	mdl.camangadd=Angle(0,0,0)
	mdl.Think = Think
	mdl.Paint = Paint
	mdl.OnMouseReleased = OnMouseReleased
	mdl.OnMousePressed = OnMousePressed

	Background = Background or LoadBackground("default")


	local APPLY = vgui.Create( "DImageButton", Window ) 
	APPLY:SetPos( ScrW()/2-64, ScrH()-64 ) 
	APPLY:SetSize( 128, 64 ) 
	APPLY:SetImage( "gui/editor/gui_button_apply.png" ) 
	APPLY:SetColor(Color(255,255,255,255)) 
	APPLY.DoClick = Apply 

	SetupBodyPart("ears","models/mlp/pony_default/parts/chang_ears.mdl")

	Select(Window,gcpm.species.pony.Subspecies.default.Parts.body)
end
function Apply()  
	local cm = LocalPlayer():GetInfo( "cl_playermodel" )
	if(cm!= "pony" and cm!= "ponynj") then
		RunConsoleCommand( "cl_playermodel", "ponynj" )
	end

	LocalPlayer().ponydata = table.Copy(PPM.editor_ponydata)
	PPM.SendCharToServer(LocalPlayer()) 
	PPM.Save_settings()  
	colorFlash(APPLY, 0.1, Color(0,200,0),Color(255,255,255)) 
end
function Think(self)
	UpdateCamera(self)
end
function UpdateCamera(self)
	if self.ismousepressed then 
		local x, y =self:CursorPos(); 
		self.camangadd =Angle(math.Clamp(self.camang.p-y+self.mdy,-89,13)-self.camang.p, -x+self.mdx, 0)
	end
	local camvec =(Vector(1,0,0)*120)
	camvec:Rotate(self.camang+self.camangadd) 
	self:SetCamPos(self.vLookatPos+camvec) 
	self.camvec = camvec
end
function OnMousePressed(self,key)
	if key == MOUSE_RIGHT then
		self.ismousepressed=true
		self.mdx ,self.mdy = self:CursorPos()
		self:SetCursor("sizeall");
	end
end
function OnMouseReleased(self,key)
	if key == MOUSE_RIGHT then
		self.ismousepressed=false
		self.camang=self.camang+self.camangadd
		self.camangadd=Angle(0,0,0)
		self:SetCursor("none");
	end
end
local mat_group_circle = Material("gui/editor/group_circle.png")
function Paint(self)
	if not IsValid(Character) then return false end

	local x, y = self:LocalToScreen( 0, 0 )
	local w, h = self:GetSize()

	local ang = self.aLookAngle
	if ( !ang ) then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end
	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, 4096 )
	cam.IgnoreZ( false )
	 

	
	render.SuppressEngineLighting( true )
	render.SetLightingOrigin( Character:GetPos() )
	render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
	render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
	render.SetBlend( self.colColor.a/255 )
	render.FogMode( MATERIAL_FOG_LINEAR )
	render.FogStart( 0 )
	render.FogEnd( 3000 )
	render.FogMaxDensity( 0.5)
	render.FogColor(219,242,255 )

	for i=0, 6 do
		local col = self.DirectionalLight[ i ]
		if ( col ) then
			render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
		end
	end
 

	DrawBackground(Background)
	  
	Character:DrawModel()
	for k,v in pairs(parts) do 
		v:DrawModel()
	end


	render.SuppressEngineLighting( false )
	

	cam.End3D()
end

function Select(Window,node)
	MsgN("WHAT?")
	--cleanValueEditors()
	local sspanel = Window.sspanel 
	if not sspanel then 
		local smpanel = vgui.Create("DPanel",Window) 
		Window.smpanel = smpanel

		local sw, sh = ScrW(), ScrH()
	 
		smpanel:SetSize( 220, sh-120 )  
		smpanel:SetPos(sw-240,80) 


		sspanel = vgui.Create("DScrollPanel",smpanel) 
		sspanel:Dock(FILL)
		Window.sspanel = sspanel
	end
	sspanel:Clear()

  
	for k,v in pairs(node.params) do  
		local tp = panels[v.type] 
		if tp then 
			local header = vgui.Create( "DCollapsibleCategory", sspanel )	 
			header:SetLabel( v.name )					 
			header:SetPos( 25, 50 )		 
			header:SetSize( 250, 100 )	  
			header:Dock(TOP)
			local content = vgui.Create( "DPanelList", sspanel ) 
			content:SetSpacing( 5 )							 
			content:EnableHorizontal( false )				  
			header:SetContents( content )		 
			 
			tp.spawn(content,v)
		end
	end 
end 