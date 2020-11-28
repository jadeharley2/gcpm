if CLIENT then
/*
list.Set(
	"DesktopWindows", 
	"PPMitor",
	{
		title           = "Pony Editor",
		icon            = "gui/pped_icon.png",
		width           = 960,
		height          = 700,
		onewindow       = true,
		init            = function(icon, window)
		window:Remove()
			PPM.Open()
		end
	}
) 
*/
   
PPM.disppony=nil
PPM.panel = NULL 
PPM.dispent = nil



local KINDS = {"EARTH","PEGASUS","UNICORN","ALICORN"}
local AGESF = {"FOAL","FILLY","MARE","HIGH"}
local AGESM = {"FOAL","COLT","STALLION","HIGH"}
local GENS = {"FEMALE","MALE"}

local MANES = {
"DERPY","BON BON","LYRA","TRIXIE","FLUTTERSHY",
"MANE6","MANE7","RAINBOW","VINYL","HOOVES",
"TWILIGHT","APPLEJACK","PINKIE","RARITY","SPITFIRE","NONE"}
local MANES_LOW = {
"DERPY","BON BON","LYRA","TRIXIE","FLUTTERSHY",
"MANE6","MANE7","RD SHORT","RAINBOW","TWILIGHT",
"APPLEJACK","RARITY","NONE"}
local TAILS = {
"DERPY","BON BON","LYRA","TRIXIE","FLUTTERSHY",
"TAIL6","TAIL7","RAINBOW","TAIL9","TAIL10",
"TWILIGHT","APPLEJACK","PINKIE","RARITY","NONE"}
local EYELASHES = {
"DEFAULT","DOUBLE","DOUBLESHY","FULL","MESS","NONE"}

local TEXTURES = {"NONE","GRADIENT1"}
local ITEMSLOTS = {
"HEAD","EYES","NECK","FRNTBODY","FRNTLEG","FRNTHOOF","UNKNOWN",
"UNIFORM","UNKNOWN","UNKNOWN","REARBODY","REARLEG","REARHOOF","UNKNOWN"}
local REALSLOTS = { 0,7,1,2,3,5,99,		50,99,99,9,10,12,99}

PPM.EDM_FONT ="TAHDS"
surface.CreateFont( PPM.EDM_FONT, {
 font = "Arial",
 size = 15,
 weight = 2500,
 blursize = 0,
 scanlines = 0,
 antialias = true,
 underline = false,
 italic = false,
 strikeout = false,
 symbol = false,
 rotary = false,
 shadow = false,
 additive = false,
 outline = false
} )
concommand.Add("ppm_chared",function( ply )
	PPM.Open()
end)

 
 left_open=false
 left_isOpening =false
 right_open=false
 right_isOpening =false
 lcur_id = 6
 rcur_id = 9
setup_delay = 0.8
 
function getEntityWidthLengthHeight(ent) 
    local offset=ent:OBBMaxs( )-ent:OBBMins( ) 
    return offset
end
local function getRotatedPos(CenterX,CenterY,Ang,rad)
	return CenterX+math.cos(math.rad(Ang))*rad, CenterY+math.sin(math.rad(Ang))*rad
end
CUR_LEFTPLATFORM_CONTROLLS = {}
CUR_RIGHTPLATFORM_CONTROLLS = {}
WEARSLOTSL = {}
WEARSLOTSR = {}

function PPM.Open()  
	CUR_LEFTPLATFORM_CONTROLLS = {}
	CUR_RIGHTPLATFORM_CONTROLLS = {}
	WEARSLOTSL = {}
	WEARSLOTSR = {}
	LocalPlayer().pi_wear =LocalPlayer().pi_wear or {}
	
	 left_open=false
	 left_isOpening =false
	 right_open=false
	 right_isOpening =false 
	 
	local window = vgui.Create("DFrame")
	PPM.panel =window
	window:ShowCloseButton( true )
	window:SetSize(ScrW(), ScrH()) 
	window:SetBGColor(255,0,0)
	window:SetVisible( true )
	window:SetDraggable(false)
	window:MakePopup()
	window:SetTitle("PPM Editor v2.0")
	window.Paint = function()  
		surface.SetDrawColor( 0, 0, 0, 255 ) 
		surface.DrawRect( 0, 0, window:GetWide(), window:GetTall() )
	end
	window:SetKeyboardInputEnabled(true)
	window.Close = function() 
		PPM.editor_clothing :Remove()
		PPM.editor_pony:Remove()
		window:Remove( )
		CUR_LEFTPLATFORM_CONTROLLS = {}
		CUR_RIGHTPLATFORM_CONTROLLS = {}
		WEARSLOTSL = {}
		WEARSLOTSR = {}
		 left_open=false
		 left_isOpening =false
		 right_open=false
		 right_isOpening =false 
	   
	end 
/*
	local top = vgui.Create("DPanel",window)
	top:SetSize( 20, 20 ) 
	top:Dock( TOP )
	top.Paint = function() -- Paint function 
		surface.SetDrawColor( 50, 50, 50, 255 ) 
		surface.DrawRect( 0, 0, top:GetWide(), top:GetTall() )
	end
	*/
	
	PPM.smenupanel = vgui.Create("DPanel",PPM.panel)
	local fx=0
	local fy=0
	
	local fw=ScrW()/4
	local fh=ScrH()
	PPM.smenupanel:SetSize( 0,0 )  
	PPM.smenupanel:SetPos(ScrW()/2,ScrH()/2)
	PPM.smenupanel:SetAlpha(200)  
	PPM.faceviewmode = false
	//smenupanel:SetSize( w, h )  
	//smenupanel:SetPos(x+w,y)
	//smenupanel:SizeTo( fw, fh, 0.4, 0, 1) 
	//smenupanel:MoveTo( fx,fy, 0.4, 0, 1) 
	 
	PPM.smenupanel.Paint = function() -- Paint function 
		//surface.SetDrawColor( 0, 0, 0, 255 ) 
		//surface.DrawRect( 0, 0, PPM.smenupanel:GetWide(), PPM.smenupanel:GetTall() )
	end
	 
	
	local smenupanelimg = vgui.Create("DImage",PPM.smenupanel)
	smenupanelimg:SetImage( "gui/editor/bound_menu.png" )
	smenupanelimg:Dock(FILL) 
	
	PPM.smenupanelimg2 = vgui.Create("DImage",window)
	PPM.smenupanelimg2:SetPos(ScrW()/2,ScrH()/2)
	PPM.smenupanelimg2:SetSize( 0,0)  
	PPM.smenupanelimg2:SetImage( "gui/editor/bound_menu_r.png" )
	 fx=ScrW()/4*3
	 
	//PPM.smenupanelimg2:SizeTo( fw, fh, 0.4, 0, 1) 
	//PPM.smenupanelimg2:MoveTo( fx,fy, 0.4, 0, 1) 
	
	PPM.ponyviewsel = vgui.Create("DImage",window)
	local floSiz = 1.8
	PPM.ponyviewsel:SetSize( 0,0)  
	PPM.ponyviewsel:SetPos(ScrW()/2,ScrH()/2)
	PPM.ponyviewsel:SetImage( "gui/editor/group_circle.png" )
	PPM.ponyviewsel:SetAlpha(255)
	PPM.ponyviewsel:SizeTo( ScrW()/floSiz, ScrW()/floSiz , 0.4, 0, 2) 
	PPM.ponyviewsel:MoveTo( ScrW()/2-ScrW()/floSiz/2,ScrH()/2-ScrW()/floSiz/2, 0.4, 0, 2) 
	/*
	local bExit = vgui.Create( "DButton", top )
	bExit:SetSize( 20, 20 ) 
	bExit:Dock( RIGHT )
	bExit:SetPos(ScrW()-20,0)
	bExit:SetText( "X" )
	bExit.DoClick = function( button ) 
		window:Remove( ) 
	end
	
	*/
	///////////////////////////////////////////////////////////
	local mdl = window:Add( "DModelPanel" )
	PPM.modelview = mdl
	mdl:Dock( FILL )
	mdl:SetFOV(70)
	mdl:SetModel( "models/mlp/player_default_base.mdl" )
	
	mdl.camang =Angle(0,70,0)
	mdl.camangadd=Angle(0,0,0)
	local time =0
	function mdl:LayoutEntity( )
		PPM.copyLocalPonyTo(LocalPlayer(),self.Entity) 
		
		
		PPM.editor_pony = self.Entity
		self.Entity.isEditorPony = true 
		if mdl.model2 ==nil then
		mdl.model2 =ClientsideModel( "models/mlp/player_default_clothes1.mdl" , RENDER_GROUP_OPAQUE_ENTITY ) 
		mdl.model2:SetNoDraw( true )
		mdl.model2:SetParent(self.Entity)
		mdl.model2:AddEffects(EF_BONEMERGE) 
		PPM.editor_clothing =mdl.model2
		end
		if LocalPlayer().pi_wear[50]!=nil then
			self.Entity.ponydata.bodyt0 = LocalPlayer().pi_wear[50].wearid or 1
		end
		PPM.editor_pony:SetPoseParameter("move_x",1)
		if(LocalPlayer().pi_wear!=nil) then 
			for i,item in pairs(LocalPlayer().pi_wear) do
				PPM.setBodygroupSafe(PPM.editor_pony,item.bid,item.bval) 
				PPM.setBodygroupSafe(mdl.model2,item.bid,item.bval) 
			end
		end 
		self.OnMousePressed = function()
			self.ismousepressed=true
			self.mdx ,self.mdy = self:CursorPos(); 
			self:SetCursor("sizeall");
		end
		self.OnMouseReleased = function()
			self.ismousepressed=false
			self.camang=self.camang+self.camangadd
			self.camangadd=Angle(0,0,0)
			self:SetCursor("none");
		end
		
		self:RunAnimation()
		self:SetAnimSpeed( 0.5 )
		self:SetAnimated( false )
		if(PPM.faceviewmode ) then 
			local attachmentID=self.Entity:LookupAttachment("eyes");
			local attachpos =  self.Entity:GetAttachment(attachmentID).Pos+Vector(-10,0,3)
			self.vLookatPos =self.vLookatPos + (attachpos-self.vLookatPos)/20
			mdl.fFOV =mdl.fFOV+( 30-mdl.fFOV)/50
		else
			self.vLookatPos =self.vLookatPos+ (Vector(0,0,25)-self.vLookatPos)/20
			mdl.fFOV =mdl.fFOV+( 70-mdl.fFOV)/50
		end
		if(self.ismousepressed) then 
		local x, y =self:CursorPos(); 
		self.camangadd =Angle(
		math.Clamp(self.camang.p-y+self.mdy,-89,89)-self.camang.p, -x+self.mdx, 0)
		end
		local camvec =(Vector(1,0,0)*120)
		camvec:Rotate(self.camang+self.camangadd) 
		self:SetCamPos(self.vLookatPos+camvec)//Vector(90,0,60))
		self.camvec = camvec
		
	time=time+0.02
	 
		PPM.setBodygroups(PPM.editor_pony)
		
	end  
	mdl.t =0
	mdl.Paint = function()////////////////////////////////////
	
		if ( !IsValid( mdl.Entity ) ) then return end

		local x, y = mdl:LocalToScreen( 0, 0 )
		
		mdl:LayoutEntity( mdl.Entity )
		
		PPM.PrePonyDraw(mdl.Entity,true)
		
		local ang = mdl.aLookAngle
		if ( !ang ) then
			ang = (mdl.vLookatPos-mdl.vCamPos):Angle()
		end
		
		local w, h = mdl:GetSize()
		cam.Start3D( mdl.vCamPos, ang, mdl.fFOV, x, y, w, h, 5, 4096 )
		cam.IgnoreZ( true )
		
		surface.SetMaterial(Material("gui/editor/group_circle.png") )
		surface.SetDrawColor( 0, 0, 0, 255 ) 
		surface.DrawRect( -30, -30, 30, 30 )
	
		render.SuppressEngineLighting( true )
		render.SetLightingOrigin( mdl.Entity:GetPos() )
		render.ResetModelLighting( mdl.colAmbientLight.r/255, mdl.colAmbientLight.g/255, mdl.colAmbientLight.b/255 )
		render.SetColorModulation( mdl.colColor.r/255, mdl.colColor.g/255, mdl.colColor.b/255 )
		render.SetBlend( mdl.colColor.a/255 )
		
		for i=0, 6 do
			local col = mdl.DirectionalLight[ i ]
			if ( col ) then
				render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
			end
		end
			
		mdl.Entity:DrawModel()
		mdl.model2:DrawModel()
		render.SuppressEngineLighting( false )
		cam.IgnoreZ( false )
		cam.End3D()
		if(PPM.selector_circle != nil) then
			if(PPM.selector_circle[1] != nil) then
			local attachmentID=mdl.Entity:LookupAttachment("eyes");
			local attachpos =  mdl.Entity:GetAttachment(attachmentID).Pos
			mdl.t=mdl.t+0.01
			 local x,y, viz =	VectorToLPCameraScreen(((mdl.Entity:GetPos()+ attachpos)- mdl.camvec-mdl.vLookatPos):GetNormal( ), w, h, ang,math.rad( mdl.fFOV))
			 local ww,hh =PPM.selector_circle[1]:GetSize( )
				if(viz) then
				 
					//PPM.selector_circle[1]:SetPos(x-ww/2,y-hh/2)
					//local tt =4
					//surface.SetDrawColor( 255, 0, 0, 255 ) 
					//surface.DrawRect( x,y, tt,tt )
				else
					//PPM.selector_circle[1]:SetPos(-ww,-hh)
				end
				//PPM.selector_circle[1]:Draw()
			end 
		end
		mdl.LastPaint = RealTime()
	end
	
	
	////////////////////////////////
	local selectors_size = 10
	PPM.selector_circle = {}
	for k=1,10 do
		if k!=2 then
			PPM.selector_circle[k] = vgui.Create("DImageButton",window)
			//selector_circle:SetSize( ScrW()/selectors_size, ScrW()/selectors_size ) 
			PPM.selector_circle[k]:SetSize(0,0)		
			local nx ,ny =getRotatedPos(ScrW()/2,ScrH()/2,k*36,ScrW()/4)
			PPM.selector_circle[k]:SetPos(ScrW()/2,ScrH()/2)
			if k==3 then  
			 nx ,ny =getRotatedPos(ScrW()/2,ScrH()/2,90,ScrW()/4)
			end
			//selector_circle:SetPos(nx-ScrW()/selectors_size/2,ny-ScrW()/selectors_size/2)
			PPM.selector_circle[k]:SetImage( "gui/editor/group_circle.png" )
			PPM.selector_circle[k]:SetAlpha(200) 
			if k==3 then 
			PPM.selector_circle[k]:SizeTo( ScrW()/selectors_size*1.5, ScrW()/selectors_size*1.5 , 0.4, 0, 2) 
			PPM.selector_circle[k]:MoveTo( nx-ScrW()/selectors_size*1.5/2,ny-ScrW()/selectors_size*1.5/2, 0.4, 0, 2) 
			else
			PPM.selector_circle[k]:SizeTo( ScrW()/selectors_size, ScrW()/selectors_size , 0.4, 0, 2) 
			PPM.selector_circle[k]:MoveTo( nx-ScrW()/selectors_size/2,ny-ScrW()/selectors_size/2, 0.4, 0, 2) 
			end
			if(k==1)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"EQUIPMENT",false) end)
			elseif(k==3)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"APPLY",false) end)
			elseif(k==4)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"EQUIPMENT",false) end)
			elseif(k==5)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"BODY DETAILS",false) end)
			elseif(k==6)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"APPEARANCE",false) end)
			elseif(k==7)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"EYES",false) end)
			elseif(k==9)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"PRESETS",false) end)
			elseif(k==10)then 
				timer.Simple(setup_delay,function()  SetupSelectIon(PPM.selector_circle[k],"OTHER",false) end)
			end
			PPM.selector_circle[k].DoClick = function( button ) 
				
				local lop =!left_open || !right_open || lcur_id!=4 || rcur_id!=1 
				if( k==1)then 
					set_panel_left_id(4,lop)
					set_panel_right_id(1,lop)
					
					colorFlash(PPM.selector_circle[1], 0.1, Color(0,200,0),Color(255,255,255))
					colorFlash(PPM.selector_circle[4], 0.1, Color(0,200,0),Color(255,255,255))
				elseif( k==3)then //APPLY
				
					local cm = LocalPlayer():GetInfo( "cl_playermodel" )
					if(cm!= "pony" and cm!= "ponynj") then
						RunConsoleCommand( "cl_playermodel", "ponynj" )
					end
					PPM.SendCharToServer(LocalPlayer()) 
					PPM.Save_settings()  
					colorFlash(PPM.selector_circle[k], 0.1, Color(0,200,0),Color(255,255,255))
					
				elseif( k==4)then 
					set_panel_left_id(4,lop)
					set_panel_right_id(1,lop)
					colorFlash(PPM.selector_circle[1], 0.1, Color(0,200,0),Color(255,255,255))
					colorFlash(PPM.selector_circle[4], 0.1, Color(0,200,0),Color(255,255,255))
				elseif( k==5)then
					toggle_panel_left(5)
					colorFlash(PPM.selector_circle[k], 0.1, Color(0,200,0),Color(255,255,255))
				elseif( k==6)then
					toggle_panel_left(6)
					colorFlash(PPM.selector_circle[k], 0.1, Color(0,200,0),Color(255,255,255))
				elseif( k==7)then
					toggle_panel_left(7)
					colorFlash(PPM.selector_circle[k], 0.1, Color(0,200,0),Color(255,255,255))
				elseif( k==9)then
					toggle_panel_right(9)
					colorFlash(PPM.selector_circle[k], 0.1, Color(0,200,0),Color(255,255,255))
				else
					colorFlash(PPM.selector_circle[k], 0.1, Color(200,0,0),Color(255,255,255))
				end
				//OpenFunctorMenu(selector_circle,0,0) 
			end
		end
	end
	toggle_panel_left(lcur_id)
	toggle_panel_right(rcur_id)
end
function set_panel_left_id(ID,open) 
	if ID<3 or ID>7 then return end
	
	if lcur_id!=ID then 
		close_panel_left(true)
		timer.Simple(0.3,function()
		open_panel_left(ID)end)
		lcur_id = ID
	else
	
		if left_open then
			if !open then
				close_panel_left()
			end
		else
			if open then
				open_panel_left(ID)
			end
		end
	end
end
function set_panel_right_id(ID,open) 
	if ID<2 or ID>8 then else return end
	
	if rcur_id!=ID then 
		close_panel_right(true)
		timer.Simple(0.3,function()
		open_panel_right(ID)end)
		rcur_id = ID
	else 
	
		if right_open then
	 
			if !open then
				close_panel_right()
			end
		else 
			if open then
				open_panel_right(ID)
			end
		end
	end
end
function toggle_panel_left(ID)
	if ID<3 or ID>7 then return end
	if lcur_id!=ID then 
		close_panel_left(true)
		timer.Simple(0.3,function()
		open_panel_left(ID)end)
		lcur_id = ID
	else
		if left_open then
			close_panel_left()
		else
			open_panel_left(ID)
		end
	end
	
end
function toggle_panel_right(ID)
	if ID<2 or ID>8 then else return end
	if rcur_id!=ID then 
		close_panel_right(true)
		timer.Simple(0.3,function()
		open_panel_right(ID)end)
		rcur_id = ID
	else
		if right_open then
			close_panel_right()
		else
			open_panel_right(ID)
		end
	end
	
end
function open_panel_left(ID)
	if left_open then return end
	if left_isOpening then return end
	left_open=true
	left_isOpening=true
	local fx=0
	local fy=0
	
	local fw=ScrW()/4
	local fh=ScrH()
	PPM.smenupanel:SizeTo( fw, fh, 0.4, 0, 1) 
	PPM.smenupanel:MoveTo( fx,fy, 0.4, 0, 1) 
	if(ID==4) then
		open_panel_clothing_L()
		PPM.faceviewmode=false
	elseif(ID==5) then
		open_panel_bdetails()
		PPM.faceviewmode=false
	elseif(ID==6) then
		open_panel_appearance()
		PPM.faceviewmode=false
	elseif(ID==7) then
		open_panel_eyes()
		PPM.faceviewmode=true
	end
	timer.Simple(0.8,function() left_isOpening=false end)
	
	PPM.ponyviewsel:MoveToFront( ) 
	for k ,v in pairs(PPM.selector_circle,true) do
		v:MoveToFront( )  
	end 
	PPM.selector_circle[6]:SetColor(Color(255,255,255))
	PPM.selector_circle[5]:SetColor(Color(255,255,255))
	PPM.selector_circle[4]:SetColor(Color(255,255,255))
	timer.Simple(0.2,function() 
	PPM.selector_circle[ID]:SetColor(Color(150,250,150))
	end)
end
function open_panel_right(ID)
	if right_open then return end
	if right_isOpening then return end
	right_open=true
	right_isOpening=true
	local fx=ScrW()*3/4
	local fy=0
	
	local fw=ScrW()/4
	local fh=ScrH()
	PPM.smenupanelimg2:SizeTo( fw, fh, 0.4, 0, 1) 
	PPM.smenupanelimg2:MoveTo( fx,fy, 0.4, 0, 1)
	if(ID==1)then
		open_panel_clothing_R()
		PPM.faceviewmode=false
	elseif(ID==9) then
		open_panel_presets()
	end
	timer.Simple(0.8,function() right_isOpening=false end)
	
	PPM.ponyviewsel:MoveToFront( ) 
	for k ,v in pairs(PPM.selector_circle,true) do
		v:MoveToFront( ) 
	end 
	PPM.selector_circle[9]:SetColor(Color(255,255,255))
	PPM.selector_circle[10]:SetColor(Color(255,255,255))
	PPM.selector_circle[1]:SetColor(Color(255,255,255))
	timer.Simple(0.2,function() 
	PPM.selector_circle[ID]:SetColor(Color(150,250,150))
	end)
end
function close_panel_left(fast)
	if !left_open then return end
	if left_isOpening then return end
	
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	
	local delay = 0.4
	if fast then delay = 0.1 end
	
	PPM.smenupanel:SizeTo( 0, 0, delay, 0, 1) 
	PPM.smenupanel:MoveTo( ScrW()/2,ScrH()/2, delay, 0, 1) 
	for k ,v in pairs(CUR_LEFTPLATFORM_CONTROLLS) do
		v:SizeTo( 0, 0, delay, 0, 1) 
		v:MoveTo( ScrW()/2,ScrH()/2, delay, 0, 1) 
	end 
	
	timer.Simple(delay+0.1,function()
		for k ,v in pairs(CUR_LEFTPLATFORM_CONTROLLS) do
			v:Remove( ) 
			CUR_LEFTPLATFORM_CONTROLLS[k] = nil
		end 
		CUR_LEFTPLATFORM_CONTROLLS = {}
		left_open=false
	end)
end
function close_panel_right(fast)
	if !right_open then return end
	if right_isOpening then return end
	
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	
	local delay = 0.4
	if fast then delay = 0.1 end
	
	PPM.smenupanelimg2:SizeTo( 0, 0, delay, 0, 1) 
	PPM.smenupanelimg2:MoveTo( ScrW()/2,ScrH()/2, delay, 0, 1) 
	for k ,v in pairs(CUR_RIGHTPLATFORM_CONTROLLS) do
		v:SizeTo( 0, 0, delay, 0, 1) 
		v:MoveTo( ScrW()/2,ScrH()/2, delay, 0, 1) 
	end 
	
	timer.Simple(delay+0.1,function()
		for k ,v in pairs(CUR_RIGHTPLATFORM_CONTROLLS) do
			v:Remove( ) 
			CUR_RIGHTPLATFORM_CONTROLLS[k] = nil
		end 
		CUR_RIGHTPLATFORM_CONTROLLS = {}
		right_open=false
	end)
end


function open_panel_eyes()
 
	local window =PPM.panel
	///////////////////////////////////////////////////////////BGCOLOR
	
	local kind_size = 6
	local age_size = 15
	local g_size = 15
	local cm_size = 10
	////////////////////////////////
	local selector_eyebgcol = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eyebgcol]=selector_eyebgcol
	selector_eyebgcol:SetSize( ScrW()/g_size, ScrW()/g_size )    
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,220-12.5,ScrW()*0.40)
	selector_eyebgcol:SetImage( "gui/editor/pictorect.png" )
	selector_eyebgcol:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_eyebgcol,"BGCOLOR",LocalPlayer().ponydata.eyecolor_bg or Vector(1,1,1)
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size)	
	selector_eyebgcol.DoClick = function( button )   
		OpenColorSelectorMenu(selector_eyebgcol,LocalPlayer().ponydata.eyecolor_bg or Vector(1,1,1)) 
	end
	selector_eyebgcol.onselect = function( k )   
		LocalPlayer().ponydata.eyecolor_bg = k
	end
	
	////////////////////////////////IRISCOLOR
	local selector_eyeiriscol = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eyeiriscol]=selector_eyeiriscol
	selector_eyeiriscol:SetSize( ScrW()/g_size, ScrW()/g_size )    
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,220-12.5*2,ScrW()*0.40)
	selector_eyeiriscol:SetImage( "gui/editor/pictorect.png" )
	selector_eyeiriscol:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_eyeiriscol,"IRISCOLOR",LocalPlayer().ponydata.eyecolor_iris or Vector(0.5,0.5,0.5)
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size)	
	selector_eyeiriscol.DoClick = function( button )   
		OpenColorSelectorMenu(selector_eyeiriscol,LocalPlayer().ponydata.eyecolor_iris or Vector(0.5,0.5,0.5)) 
	end
	selector_eyeiriscol.onselect = function( k )   
		LocalPlayer().ponydata.eyecolor_iris = k
	end
	
	////////////////////////////////GRADCOLOR
	local selector_eyegradcol = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eyegradcol]=selector_eyegradcol
	selector_eyegradcol:SetSize( ScrW()/g_size, ScrW()/g_size )    
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,220-12.5*2,ScrW()*0.40)
	selector_eyegradcol:SetImage( "gui/editor/pictorect.png" )
	selector_eyegradcol:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_eyegradcol,"GRADCOLOR",LocalPlayer().ponydata.eyecolor_grad or Vector(1,0.5,0.5)
	,npx-ScrW()/g_size+100,npy-ScrW()/g_size)	
	selector_eyegradcol.DoClick = function( button )   
		OpenColorSelectorMenu(selector_eyegradcol,LocalPlayer().ponydata.eyecolor_grad or Vector(1,0.5,0.5)) 
	end
	selector_eyegradcol.onselect = function( k )   
		LocalPlayer().ponydata.eyecolor_grad = k
	end
	////////////////////////////////LINE1COLOR
	
	local selector_eyeline1col = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eyeline1col]=selector_eyeline1col
	selector_eyeline1col:SetSize( ScrW()/g_size, ScrW()/g_size )    
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,220-12.5*3,ScrW()*0.40)
	selector_eyeline1col:SetImage( "gui/editor/pictorect.png" )
	selector_eyeline1col:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_eyeline1col,"LINE1COLOR",LocalPlayer().ponydata.eyecolor_line1 or Vector(0.6,0.6,0.6)
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size)	
	selector_eyeline1col.DoClick = function( button )   
		OpenColorSelectorMenu(selector_eyeline1col,LocalPlayer().ponydata.eyecolor_line1 or Vector(0.6,0.6,0.6)) 
	end
	selector_eyeline1col.onselect = function( k )   
		LocalPlayer().ponydata.eyecolor_line1 = k
	end
	
	////////////////////////////////LINE2COLOR
	
	local selector_eyeline2col = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eyeline2col]=selector_eyeline2col
	selector_eyeline2col:SetSize( ScrW()/g_size, ScrW()/g_size )    
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,220-12.5*4,ScrW()*0.40)
	selector_eyeline2col:SetImage( "gui/editor/pictorect.png" )
	selector_eyeline2col:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_eyeline2col,"LINE2COLOR",LocalPlayer().ponydata.eyecolor_line2 or Vector(0.7,0.7,0.7)
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size)	
	selector_eyeline2col.DoClick = function( button )   
		OpenColorSelectorMenu(selector_eyeline2col,LocalPlayer().ponydata.eyecolor_line2 or Vector(0.7,0.7,0.7)) 
	end
	selector_eyeline2col.onselect = function( k )   
		LocalPlayer().ponydata.eyecolor_line2 = k
	end
	
	////////////////////////////////HOLECOLOR
	local selector_eyeholecol = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eyeholecol]=selector_eyeholecol
	selector_eyeholecol:SetSize( ScrW()/g_size, ScrW()/g_size )    
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,220-12.5*5,ScrW()*0.40)
	selector_eyeholecol:SetImage( "gui/editor/pictorect.png" )
	selector_eyeholecol:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_eyeholecol,"HOLECOLOR",LocalPlayer().ponydata.eyecolor_hole or Vector(0,0,0)
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size)	
	selector_eyeholecol.DoClick = function( button )   
		OpenColorSelectorMenu(selector_eyeholecol,LocalPlayer().ponydata.eyecolor_hole or Vector(0,0,0)) 
	end
	selector_eyeholecol.onselect = function( k )   
		LocalPlayer().ponydata.eyecolor_hole = k
	end
	
	////////////////////////////////IRISSIZE
	local slider_irissize = vgui.Create( "DNumSlider",window  )  
	 CUR_LEFTPLATFORM_CONTROLLS[slider_irissize]=slider_irissize
	slider_irissize:SetMin( 0.2 ) 
	slider_irissize:SetMax( 2 )
	slider_irissize:SetDecimals( 2 ) 
	slider_irissize:SetSize( 120,20 ) 
	slider_irissize:SetValue(LocalPlayer().ponydata.eyeirissize or 0.6)
	slider_irissize.Label:SetFont(PPM.EDM_FONT)
	slider_irissize.Label:SetColor(Color(0,0,0,255)) 
	slider_irissize:SetText("IRISSIZE") 
	slider_irissize.OnValueChanged = function()
		LocalPlayer().ponydata.eyeirissize=slider_irissize:GetValue() 
	end
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,142,ScrW()*0.42)  
	SetupEl(slider_irissize,"",npx-ScrW()/g_size,npy- ScrW()/g_size)
	////////////////////////////////HOLESIZE
	local slider_holesize = vgui.Create( "DNumSlider",window  )  
	 CUR_LEFTPLATFORM_CONTROLLS[slider_holesize]=slider_irissize
	slider_holesize:SetMin( 0.3 ) 
	slider_holesize:SetMax( 1 )
	slider_holesize:SetDecimals( 2 ) 
	slider_holesize:SetSize( 120,20 ) 
	slider_holesize:SetValue(LocalPlayer().ponydata.eyeholesize or 0.8)
	slider_holesize.Label:SetFont(PPM.EDM_FONT)
	slider_holesize.Label:SetColor(Color(0,0,0,255)) 
	slider_holesize:SetText("HOLESIZE") 
	slider_holesize.OnValueChanged = function()
		LocalPlayer().ponydata.eyeholesize=slider_holesize:GetValue() 
	end
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,145,ScrW()*0.42)  
	SetupEl(slider_holesize,"",npx-ScrW()/g_size,npy- ScrW()/g_size)
	////////////////////////////////
	local hide_cmark = vgui.Create( "DCheckBoxLabel",window )
	 CUR_LEFTPLATFORM_CONTROLLS[hide_cmark]=hide_cmark
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,150-12.5,ScrW()*0.45)  
	hide_cmark:SetText( "Hide" ) 
	hide_cmark.Label:SetColor(Color(0,0,0,255)) 
	hide_cmark:SetValue( LocalPlayer().ponydata.cmark_enabled==2 )
	hide_cmark:SizeToContents()
	hide_cmark.OnChange = function(  pSelf, fValue) 
		if(fValue) then 
		LocalPlayer().ponydata.cmark_enabled = 2
		else
		LocalPlayer().ponydata.cmark_enabled = 1
		end
	end
	
	SetupEl(hide_cmark,"",npx-ScrW()/g_size,npy- ScrW()/g_size)
	////////////////////////////////
end
function open_panel_appearance()
	local window =PPM.panel
	///////////////////////////////////////////////////////////
	
	local kind_size = 6
	local age_size = 15
	local g_size = 15
	local cm_size = 10
	
	////////////////////////////////
	local selector_kind = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_kind]=selector_kind
	selector_kind:SetSize( ScrW()/kind_size, ScrW()/kind_size )   
	selector_kind:SetPos(20,20)
	selector_kind:SetImage( "gui/editor/group_circle.png" )
	selector_kind:SetAlpha(200)
	SetupSelector(selector_kind,"KIND",KINDS[LocalPlayer().ponydata.kind],LocalPlayer().ponydata.kind)	
	selector_kind.DoClick = function( button )  
		//colorFlash(selector_kind, 0.1, Color(200,0,0),Color(255,255,255))
		OpenSelectorMenu(selector_kind,0,KINDS,nil,LocalPlayer().ponydata.kind) 
	end
	selector_kind.onselect = function( k )   
		LocalPlayer().ponydata.kind = k
	end
	
	////////////////////////////////
	local selector_age = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_age]=selector_age
	selector_age:SetSize( ScrW()/g_size, ScrW()/g_size ) 
		local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,215,ScrW()*0.32) 
	//selector_age:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	selector_age:SetImage( "gui/editor/group_circle.png" )
	selector_age:SetAlpha(200) 
	
	LocalPlayer().ponydata.age = 2
	
	if(LocalPlayer().ponydata.gender==1) then 
		SetupSelector(selector_age,"AGE",AGESF[LocalPlayer().ponydata.age],LocalPlayer().ponydata.age,false
	,npx-ScrW()/g_size,npy-ScrW()/g_size)	
	else
		SetupSelector(selector_age,"AGE",AGESM[LocalPlayer().ponydata.age],LocalPlayer().ponydata.age,false
	,npx-ScrW()/g_size,npy-ScrW()/g_size)	
	end
	
	selector_age.DoClick = function( button )   
		if(LocalPlayer().ponydata.gender==1) then 
			//OpenSelectorMenu(selector_age,0,AGESF) 
		else
			//OpenSelectorMenu(selector_age,0,AGESM) 
		end
	end
	selector_age.onselect = function( k )   
		LocalPlayer().ponydata.age = 2
		if(k==2)then
			PPM.modelview:SetModel("models/mlp/player_default_base.mdl" )
		elseif(k==3)then 
			PPM.modelview:SetModel("models/mlp/player_mature_base.mdl" )
		end
	end
	 
	////////////////////////////////
	local selector_g = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_g]=selector_g
	selector_g:SetSize( ScrW()/g_size, ScrW()/g_size )  //215 202.5 190 mid = 12.5
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,202.5,ScrW()*0.32) 
	//selector_g:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)//ScrW()/kind_size+20-ScrW()/g_size,ScrW()/kind_size-ScrW()/g_size/2)
	selector_g:SetImage( "gui/editor/group_circle.png" )
	selector_g:SetAlpha(200) 
	SetupSelector(selector_g,"GENDER",GENS[LocalPlayer().ponydata.gender],LocalPlayer().ponydata.gender,false
	,npx-ScrW()/g_size,npy-ScrW()/g_size)	
	selector_g.DoClick = function( button ) 
		OpenSelectorMenu(selector_g,0,GENS,nil,LocalPlayer().ponydata.gender) 
	end
	
	selector_g.onselect = function( k )   
		LocalPlayer().ponydata.gender = k
		local nextext = ""
		if(LocalPlayer().ponydata.gender==1) then 
			nextext =AGESF[LocalPlayer().ponydata.age]	
		else
			nextext =AGESM[LocalPlayer().ponydata.age]
		end
		selector_age.vc:SetText( nextext ) 
		selector_age.vc:SizeToContents()  
		local x,y =selector_age:GetPos()
		local w,h =selector_age:GetSize()
		local sw,sh =selector_age.vc:GetSize()
		selector_age.vc:SetPos(w/2-sw/2,h/2+sh)
	end
	
	////////////////////////////////
	local selector_mane = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_mane]=selector_mane
	selector_mane:SetSize( ScrW()/g_size, ScrW()/g_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190,ScrW()*0.40) 
	//selector_mane:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	selector_mane:SetImage( "gui/editor/group_circle.png" )
	selector_mane:SetAlpha(200)
	SetupSelector(selector_mane,"MANE HEAD",MANES[LocalPlayer().ponydata.mane],LocalPlayer().ponydata.mane,false
	,npx-ScrW()/g_size,npy-ScrW()/g_size)	
	selector_mane.DoClick = function( button )   
		OpenSelectorMenu(selector_mane,0,MANES,nil,LocalPlayer().ponydata.mane) 
	end
	selector_mane.onselect = function( k )   
		LocalPlayer().ponydata.mane = k
	end
	
	
	////////////////////////////////
	local selector_tail = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_tail]=selector_tail
	selector_tail:SetSize( ScrW()/g_size, ScrW()/g_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190,ScrW()*0.325) 
	//selector_tail:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	selector_tail:SetImage( "gui/editor/group_circle.png" )
	selector_tail:SetAlpha(200)
	SetupSelector(selector_tail,"TAIL",TAILS[LocalPlayer().ponydata.tail],LocalPlayer().ponydata.tail,false
	,npx-ScrW()/g_size,npy-ScrW()/g_size)	
	selector_tail.DoClick = function( button )   
		OpenSelectorMenu(selector_tail,0,TAILS,nil,LocalPlayer().ponydata.tail) 
	end
	selector_tail.onselect = function( k )   
		LocalPlayer().ponydata.tail = k
	end
	 
	////////////////////////////////
	local selector_maneLOW = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_maneLOW]=selector_maneLOW
	selector_maneLOW:SetSize( ScrW()/g_size, ScrW()/g_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-12.5,ScrW()*0.40)   
	selector_maneLOW:SetImage( "gui/editor/group_circle.png" )
	selector_maneLOW:SetAlpha(200)
	 
	 
	SetupSelector(selector_maneLOW,"MANE NECK",MANES_LOW[LocalPlayer().ponydata.manel],LocalPlayer().ponydata.manel,false
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size-5)	
	selector_maneLOW.DoClick = function( button )   
		OpenSelectorMenu(selector_maneLOW,0,MANES_LOW,nil,LocalPlayer().ponydata.manel) 
	end
	selector_maneLOW.onselect = function( k )   
		LocalPlayer().ponydata.manel = k
	end
	
	////////////////////////////////
	local selector_coatCOLOR = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_coatCOLOR]=selector_coatCOLOR
	selector_coatCOLOR:SetSize( ScrW()/g_size, ScrW()/g_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-12.5,ScrW()*0.40)  
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-12.5,ScrW()*0.33)
	selector_coatCOLOR:SetImage( "gui/editor/pictorect.png" )
	selector_coatCOLOR:SetAlpha(200)
	 
	 
	
	SetupColorSelector(selector_coatCOLOR,"COAT COLOR",LocalPlayer().ponydata.coatcolor
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size)	
	selector_coatCOLOR.DoClick = function( button )   
		OpenColorSelectorMenu(selector_coatCOLOR,LocalPlayer().ponydata.coatcolor) 
	end
	selector_coatCOLOR.onselect = function( k )   
		LocalPlayer().ponydata.coatcolor = k
	end
	
	////////////////////////////////
	local selector_eye = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_eye]=selector_eye
	selector_eye:SetSize( ScrW()/g_size, ScrW()/g_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-25,ScrW()*0.41)   
	//selector_eye:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	selector_eye:SetImage( "gui/editor/group_circle.png" )
	selector_eye:SetAlpha(200)
	
	local EYECOLORS = {}
	local EYETEXTURES = {}
	for k , v in pairs(PPM.t_eyes) do 
		EYECOLORS[k] = v[2]  
		EYETEXTURES[k] = v[3]  
	end 
	 
	
	SetupSelector(selector_eye,"EYE COLOR",EYECOLORS[LocalPlayer().ponydata.eye],LocalPlayer().ponydata.eye,true
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size-15)	
	selector_eye.DoClick = function( button )   
		OpenSelectorMenu(selector_eye,0,EYECOLORS,EYETEXTURES,LocalPlayer().ponydata.eye) 
	end
	selector_eye.onselect = function( k )   
		LocalPlayer().ponydata.eye = k
	end
	
	////////////////////////////////
	local selector_eyelashes = vgui.Create("DImageButton",window) 
	CUR_LEFTPLATFORM_CONTROLLS[selector_eyelashes]=selector_eyelashes
	selector_eyelashes:SetSize( ScrW()/g_size, ScrW()/g_size )    
	npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-25-12.5,ScrW()*0.41)   
	selector_eyelashes:SetImage( "gui/editor/group_circle.png" )
	selector_eyelashes:SetAlpha(200)
	 
	 
	SetupSelector(selector_eyelashes,"EYELASHES",EYELASHES[LocalPlayer().ponydata.eyelash],LocalPlayer().ponydata.eyelash,false
	,npx-ScrW()/g_size-5,npy-ScrW()/g_size-5)	
	selector_eyelashes.DoClick = function( button )   
		OpenSelectorMenu(selector_eyelashes,0,EYELASHES,nil,LocalPlayer().ponydata.eyelash) 
	end
	selector_eyelashes.onselect = function( k )   
		LocalPlayer().ponydata.eyelash = k
	end
	
	////////////////////////////////
	local cl_size =30
	for i=1,6 do
		local datX = i%2
		local datY = i/2
		local selector_hair1COLOR = vgui.Create("DImageButton",window)
		CUR_LEFTPLATFORM_CONTROLLS[selector_hair1COLOR]=selector_hair1COLOR
		
		selector_hair1COLOR:SetSize( ScrW()/cl_size, ScrW()/cl_size )   
			  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-15-datY*6,ScrW()*0.336+datX*25)  
		selector_hair1COLOR:SetImage( "gui/editor/pictorect.png" )
		selector_hair1COLOR:SetAlpha(200)
		selector_hair1COLOR.index = i
		SetupColorSelector(selector_hair1COLOR,i,LocalPlayer().ponydata["haircolor"..i]or Vector(1,1,1)
		,npx-ScrW()/cl_size-5,npy-ScrW()/cl_size)	
		selector_hair1COLOR.DoClick = function( button )   
			OpenColorSelectorMenu(selector_hair1COLOR,LocalPlayer().ponydata["haircolor"..selector_hair1COLOR.index ]or Vector(1,1,1)) 
		end
		selector_hair1COLOR.onselect = function( k )   
			LocalPlayer().ponydata["haircolor"..selector_hair1COLOR.index ] = k
		end
	end
	/*
	////////////////////////////////
	local selector_hair2COLOR = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_hair2COLOR]=selector_hair2COLOR
	selector_hair2COLOR:SetSize( ScrW()/g_size, ScrW()/g_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-35,ScrW()*0.35)  
	selector_hair2COLOR:SetImage( "gui/editor/pictorect.png" )
	selector_hair2COLOR:SetAlpha(200)
	  
	SetupColorSelector(selector_hair2COLOR,"HAIR COLOR 2",LocalPlayer().ponydata.haircolor2
	,npx-ScrW()/g_size,npy-ScrW()/g_size)	
	selector_hair2COLOR.DoClick = function( button )   
		OpenColorSelectorMenu(selector_hair2COLOR,LocalPlayer().ponydata.haircolor2) 
	end
	selector_hair2COLOR.onselect = function( k )   
		LocalPlayer().ponydata.haircolor2 = k
	end
	*/
	////////////////////////////////
	local pslide1 = vgui.Create( "DNumSlider",window  )  
	 CUR_LEFTPLATFORM_CONTROLLS[pslide1]=pslide1
	pslide1:SetMin( 0.8 ) 
	pslide1:SetMax( 1.2 )
	pslide1:SetDecimals( 2 ) 
	pslide1:SetSize( 120,20 ) 
	pslide1:SetValue(LocalPlayer().ponydata.bodyweight)
	pslide1.Label:SetFont(PPM.EDM_FONT)
	pslide1.Label:SetColor(Color(0,0,0,255)) 
	pslide1:SetText("Weight")
	//pslide1.Label:SetSize( 0 )
	pslide1.OnValueChanged = function()
		LocalPlayer().ponydata.bodyweight=pslide1:GetValue()
		//pslide1:GetSlideX()*0.4+0.8//
	end
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,155,ScrW()*0.42)  
	SetupEl(pslide1,"",npx-ScrW()/g_size,npy- ScrW()/g_size)
	////////////////////////////////
	local hide_cmark = vgui.Create( "DCheckBoxLabel",window )
	 CUR_LEFTPLATFORM_CONTROLLS[hide_cmark]=hide_cmark
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,150-12.5,ScrW()*0.45)  
	hide_cmark:SetText( "Hide" ) 
	hide_cmark.Label:SetColor(Color(0,0,0,255)) 
	hide_cmark:SetValue( LocalPlayer().ponydata.cmark_enabled==2 )
	hide_cmark:SizeToContents()
	hide_cmark.OnChange = function(  pSelf, fValue) 
		if(fValue) then 
		LocalPlayer().ponydata.cmark_enabled = 2
		else
		LocalPlayer().ponydata.cmark_enabled = 1
		end
	end
	
	SetupEl(hide_cmark,"",npx-ScrW()/g_size,npy- ScrW()/g_size)
	////////////////////////////////
	local cmark_display_bg = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[cmark_display_bg]=cmark_display_bg
	
	local cmark_display = vgui.Create("DImage",window) CUR_LEFTPLATFORM_CONTROLLS[cmark_display]=cmark_display
	
	local selector_cmark = vgui.Create("DImageButton",window) CUR_LEFTPLATFORM_CONTROLLS[selector_cmark]=selector_cmark
	selector_cmark:SetSize( ScrW()/cm_size, ScrW()/cm_size )   
		  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,150-12.5,ScrW()*0.37) 
	//selector_cmark:SetPos(npx-ScrW()/cm_size,npy-ScrW()/cm_size)
	selector_cmark:SetImage( "gui/editor/group_circle.png" )
	selector_cmark:SetAlpha(10)
	
	cmark_display_bg:SetSize(0,0)// ScrW()/cm_size, ScrW()/cm_size )  
	cmark_display_bg:SetPos(ScrW()/2,ScrH()/2)//npx-ScrW()/cm_size,npy-ScrW()/cm_size)
	cmark_display_bg:SetColor(Color(0,0,0))
	cmark_display_bg:SetImage( "gui/editor/group_circle.png" )
	cmark_display_bg:SetAlpha(255)
	
	cmark_display_bg:SizeTo(ScrW()/cm_size, ScrW()/cm_size , 0.4, 0, 1) 
	cmark_display_bg:MoveTo( npx-ScrW()/cm_size,npy-ScrW()/cm_size, 0.4, 0, 1) 
	
	cmark_display:SetSize( 0,0)//ScrW()/cm_size, ScrW()/cm_size )  
	cmark_display:SetPos(ScrW()/2,ScrH()/2)//npx-ScrW()/cm_size,npy-ScrW()/cm_size+18)
	
	cmark_display:SizeTo(ScrW()/cm_size, ScrW()/cm_size , 0.4, 0, 1) 
	cmark_display:MoveTo( npx-ScrW()/cm_size,npy-ScrW()/cm_size+18, 0.4, 0, 1) 
	local CMRKS = {}
	local CMRKSTEXTURES = {}
	for k , v in pairs(PPM.m_cmarks) do 
		CMRKS[k] = v[2]  
		CMRKSTEXTURES[k] = "models/mlp/cmarks/"..v[2]  
	end 
	cmark_display:SetImage( CMRKSTEXTURES[LocalPlayer().ponydata.cmark] )
	 
	
	SetupSelector(selector_cmark,"CUTIEMARK",CMRKS[LocalPlayer().ponydata.cmark],LocalPlayer().ponydata.cmark,true
	,npx-ScrW()/cm_size,npy-ScrW()/cm_size)	
	selector_cmark.DoClick = function( button )   
		OpenSelectorMenu(selector_cmark,0,CMRKS,CMRKSTEXTURES,LocalPlayer().ponydata.cmark) 
	end
	selector_cmark.onselect = function( k )   
		LocalPlayer().ponydata.cmark = k
		cmark_display:SetImage( CMRKSTEXTURES[LocalPlayer().ponydata.cmark] )
	end
	

end
 
function open_panel_bdetails()
	local window =PPM.panel
	local g_size = 15
	////////////////////////////////
	
	
	////////////////////////////////
		BODYDETAILS = {}
		BODYDETAILS[1] = "NONE"
		for k,v in pairs(PPM.m_bodydetails) do
			BODYDETAILS[k+1] = v[2]
		end
		local clearbutton= vgui.Create("DButton",window) 
		clearbutton:SetText("CLEAR")
		CUR_LEFTPLATFORM_CONTROLLS[clearbutton]=clearbutton
			local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,206,ScrW()*0.39) 
		SetupSelector(clearbutton,"",0,0,false
		,npx-ScrW()/g_size,npy-ScrW()/g_size)
		clearbutton.DoClick = function( button )  
			for C=1,8 do  
				LocalPlayer().ponydata["bodydetail"..C] = 1
				LocalPlayer().ponydata["bodydetail"..C.."_c"] = Vector(0,0,0)
			end
			toggle_panel_left(5)
			timer.Simple(1,function() toggle_panel_left(5)end)
		end
		clearbutton:SetColor(Color(0,0,0)) 
		
	for C=1,8 do
		local selector_tex1 = vgui.Create("DImageButton",window) 
		CUR_LEFTPLATFORM_CONTROLLS[selector_tex1]=selector_tex1
		selector_tex1:SetSize( ScrW()/g_size, ScrW()/g_size ) 
			local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,214-C*8.5,ScrW()*0.40)  
		selector_tex1:SetImage( "gui/editor/group_circle.png" )
		selector_tex1:SetAlpha(200) 
		local detailvalue = LocalPlayer().ponydata["bodydetail"..C] or 1
		local detailcolor = LocalPlayer().ponydata["bodydetail"..C.."_c"] or Vector(0,0,0)
		SetupSelector(selector_tex1,C,
		BODYDETAILS[detailvalue],detailvalue,false
		,npx-ScrW()/g_size-5,npy-ScrW()/g_size+30)
		 
		selector_tex1.index = C
		selector_tex1.DoClick = function( button )    
			OpenSelectorMenu(selector_tex1,0,BODYDETAILS,nil,LocalPlayer().ponydata["bodydetail"..selector_tex1.index])  
		end
		selector_tex1.onselect = function( k )   
			LocalPlayer().ponydata["bodydetail"..selector_tex1.index] = k
		end
		
		local selector_tex1COLOR = vgui.Create("DImageButton",window) 
		CUR_LEFTPLATFORM_CONTROLLS[selector_tex1COLOR]=selector_tex1COLOR
		selector_tex1COLOR:SetSize( ScrW()/g_size, ScrW()/g_size )   
			npx = npx + ScrW()/g_size
			 // npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,190-12.5,ScrW()*0.33)  
		selector_tex1COLOR:SetImage( "gui/editor/pictorect.png" )
		selector_tex1COLOR:SetAlpha(200)
		  
		SetupColorSelector(selector_tex1COLOR,"",detailcolor
		,npx-ScrW()/g_size-5,npy-ScrW()/g_size+30)	
		selector_tex1COLOR.DoClick = function( button )   
			OpenColorSelectorMenu(selector_tex1COLOR,detailcolor) 
		end
		selector_tex1COLOR.onselect = function( k )   
			LocalPlayer().ponydata["bodydetail"..selector_tex1.index.."_c"] = k
		end
	end
end
function open_panel_clothing_L()
	local window =PPM.panel
	/////////////////////////////////////////////////////////// 
	local g_size = 15  
	WEARSLOTSL = {}
	////////////////////////////////
	
	for I=1,7 do
		
		local selector_clothing = vgui.Create("DImageButton",window) 
		CUR_LEFTPLATFORM_CONTROLLS[selector_clothing]=selector_clothing
		selector_clothing:SetSize( ScrW()/g_size, ScrW()/g_size )   
			  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,180-11*(I-3)+5,ScrW()*0.40)  
		selector_clothing:SetImage( "gui/item.png" )
		selector_clothing:SetAlpha(200)
		  
		SetupItemSelector(selector_clothing,ITEMSLOTS[I],REALSLOTS[I]
		,npx-ScrW()/g_size-5,npy-ScrW()/g_size-5)	
		selector_clothing.DoClick = function( button )   
			OpenColorSelectorMenu(selector_clothing,0) 
		end 
	
	end
	timer.Simple(1.2,function() PPM_UpdateSlots(1) end)
end
function open_panel_clothing_R()
	local window =PPM.panel
	/////////////////////////////////////////////////////////// 
	local g_size = 15 
	WEARSLOTSR = {}
	////////////////////////////////
	
	for I=1,7 do
		
		local selector_clothing = vgui.Create("DImageButton",window) 
		CUR_RIGHTPLATFORM_CONTROLLS[selector_clothing]=selector_clothing
		selector_clothing:SetSize( ScrW()/g_size, ScrW()/g_size )   
			  npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,11*(I-3)-5,ScrW()*0.40)  
		selector_clothing:SetImage( "gui/item.png" )
		selector_clothing:SetAlpha(200)
		
		SetupItemSelector(selector_clothing,ITEMSLOTS[I+7],REALSLOTS[I+7]
		,npx-ScrW()/g_size+95,npy-ScrW()/g_size-5)	
		
		selector_clothing.DoClick = function( button )   
			OpenColorSelectorMenu(selector_clothing,0) 
		end 
	
	end
	timer.Simple(1.2,function() PPM_UpdateSlots(2) end)
end
function open_panel_presets()
	local window =PPM.panel
	///////////////////////////////////////////////////////////
	
	local kind_size = 6
	local age_size = 15
	local g_size = 15
	local cm_size = 10
	
	////////////////////////////////
	 
	local dPresetListPanel = vgui.Create("DPanel") 
	CUR_RIGHTPLATFORM_CONTROLLS[ dPresetListPanel ]=dPresetListPanel 
	dPresetListPanel:SetParent(window) 
	dPresetListPanel:SetPos(0,0)
	dPresetListPanel:SetSize(ScrW()/8, ScrH()*2/4)
	
	local dPresetList = vgui.Create("DListView") 
	dPresetList:SetParent(dPresetListPanel) 
	dPresetList:SetPos(0,0)
	dPresetList:SetSize(ScrW()/8, ScrH()*1/4)
	dPresetList:SetMultiSelect(false)
	dPresetList:Dock( FILL )
	dPresetList:AddColumn("Preset") -- Add column 
	PPM.dPresetList =dPresetList
	 
	SetupEl(dPresetListPanel,"",ScrW()*16/20, ScrH()/4)
	
	local bAddPreset = vgui.Create( "DButton", dPresetListPanel )
	//CUR_RIGHTPLATFORM_CONTROLLS[bAddPreset]=bAddPreset
	bAddPreset:SetSize( 180, 30 )
	bAddPreset:Dock( BOTTOM )
	bAddPreset:SetText( "New Preset" )
	bAddPreset.DoClick = function( button )
		NewPresetMenu(bAddPreset) 
	end
	
	local bDelPreset = vgui.Create( "DButton", dPresetListPanel )
	//CUR_RIGHTPLATFORM_CONTROLLS[bAddPreset]=bAddPreset 
	bDelPreset.goDef = function() 
		if bDelPreset.bdel!=nil then
			bDelPreset.bdel:Remove()
			bDelPreset.bdel=nil
		end
		bDelPreset:SetSize( 180, 30 )
		bDelPreset:Dock( BOTTOM )
		bDelPreset:SetText( "Delete" )
		bDelPreset.sure =false
	end
	bDelPreset.goDef()
	bDelPreset.DoClick = function( button )
	
	
	
		local selline =dPresetList:GetSelectedLine()
		if(selline==nil) then
			colorFlash(bDelPreset, 0.1, Color(200,0,0),Color(0,0,0))
			bDelPreset.goDef()
		return end
		local selected_fname =dPresetList:GetLine(selline):GetColumnText(1)
		if(selected_fname==nil) then
			colorFlash(bDelPreset, 0.1, Color(200,0,0),Color(0,0,0))
			bDelPreset.goDef()
		return end
		if(table.HasValue(PPM.reservedPresetNames,selected_fname))then
			colorFlash(bDelPreset, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		 
	
	
		if !bDelPreset.sure then
			bDelPreset:SetText( "NO!" )
			bDelPreset:SetSize( 180, 15 )
			bDelPreset.sure=true
			bDelPreset.bdel = vgui.Create( "DButton", dPresetListPanel )
			bDelPreset.bdel:SetSize( 180, 15 )
			bDelPreset.bdel:Dock( BOTTOM )
			bDelPreset.bdel:SetText( "YES, DELETE!" )
			bDelPreset.bdel.DoClick = function( button )
				file.Delete("ppm/"..selected_fname)
				LoadFileList(PPM.dPresetList) 
				bDelPreset.goDef()
			end
		else
			bDelPreset.goDef()
		end
	end
	 
	 
	local button_reset = vgui.Create("DImageButton",window) CUR_RIGHTPLATFORM_CONTROLLS[button_reset]=button_reset
	button_reset:SetSize( ScrW()/g_size, ScrW()/g_size ) 
		//local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,0,ScrW()*0.40) 
		local npx = ScrW()*16.8/20
		local npy = ScrH()*2/10
	//selector_age:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	button_reset:SetImage( "gui/editor/group_circle.png" )
	button_reset:SetAlpha(200) 
	
	SetupEl(button_reset,"RESET",npx-ScrW()/g_size,npy- ScrW()/g_size)
	button_reset.DoClick = function( button )   
		PPM.cleanPony(LocalPlayer())
		colorFlash(button_reset, 0.1, Color(0,200,0),Color(255,255,255))
		ReopenRight()
	end
	 
	 
	local button_rnd = vgui.Create("DImageButton",window) CUR_RIGHTPLATFORM_CONTROLLS[button_rnd]=button_rnd
	button_rnd:SetSize( ScrW()/g_size, ScrW()/g_size ) 
		//local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,0,ScrW()*0.40) 
		local npx = ScrW()*18.2/20
		local npy = ScrH()*2/10
	//selector_age:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	button_rnd:SetImage( "gui/editor/group_circle.png" )
	button_rnd:SetAlpha(200) 
	
	SetupEl(button_rnd,"RANDOM",npx-ScrW()/g_size,npy- ScrW()/g_size)
	button_rnd.DoClick = function( button )   
		PPM.randomizePony(LocalPlayer()) 
		colorFlash(button_rnd, 0.1, Color(0,200,0),Color(255,255,255))
		ReopenRight()
	end
	
	local button_save = vgui.Create("DImageButton",window) CUR_RIGHTPLATFORM_CONTROLLS[button_save]=button_save
	button_save:SetSize( ScrW()/g_size, ScrW()/g_size ) 
		//local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,0,ScrW()*0.40) 
		local npx = ScrW()*16.8/20
		local npy = ScrH()*9/10
	//selector_age:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	button_save:SetImage( "gui/editor/group_circle.png" )
	button_save:SetAlpha(200) 
	PPM.button_save=button_save
	SetupEl(button_save,"SAVE",npx-ScrW()/g_size,npy- ScrW()/g_size)
	button_save.DoClick = function( button )   
	
		local selline =dPresetList:GetSelectedLine()
		if(selline==nil) then
			colorFlash(PPM.button_save, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		local selected_fname =dPresetList:GetLine(selline):GetColumnText(1)
		if(selected_fname==nil) then
			colorFlash(PPM.button_save, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		if(table.HasValue(PPM.reservedPresetNames,selected_fname))then
			colorFlash(PPM.button_save, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		PPM.Save(selected_fname,LocalPlayer().ponydata) 
		colorFlash(PPM.button_save, 0.1, Color(0,200,0),Color(255,255,255))
		 
		LoadFileList(PPM.dPresetList)  
	end
	 
	local button_load = vgui.Create("DImageButton",window) CUR_RIGHTPLATFORM_CONTROLLS[button_load]=button_load
	button_load:SetSize( ScrW()/g_size, ScrW()/g_size ) 
		//local npx,npy =getRotatedPos(ScrW()/2,ScrH()/2,0,ScrW()*0.40) 
		 npx = ScrW()*18.2/20
		 npy = ScrH()*9/10 
	//selector_age:SetPos(npx-ScrW()/g_size,npy-ScrW()/g_size)
	button_load:SetImage( "gui/editor/group_circle.png" )
	button_load:SetAlpha(200) 
	
	SetupEl(button_load,"LOAD",npx-ScrW()/g_size,npy- ScrW()/g_size)
	button_load.DoClick = function( button )   
	 
		local selline =dPresetList:GetSelectedLine()
		if(selline==nil) then
			colorFlash(button_load, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		local selected_fname =dPresetList:GetLine(selline):GetColumnText(1)
		if(selected_fname==nil) then
			colorFlash(button_load, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		//if(PPM.selected_filename==nil) then return end
		//if(PPM.selected_filename=="@NEWFILE@") then return end
		//PPM.ReadFile(PPM.selected_filename)  
		PPM.cleanPony(LocalPlayer())
		PPM.mergePonyData(LocalPlayer().ponydata,PPM.Load(selected_fname))
		
		PPM.SendCharToServer(LocalPlayer()) 
		colorFlash(button_load, 0.1, Color(0,200,0),Color(255,255,255))
		colorFlash(PPM.selector_circle[3], 0.2, Color(0,200,0),Color(255,255,255))
		PPM.Save_settings() 
		ReopenRight()
	end
	LoadFileList(dPresetList)
end
function NewPresetMenu(parent) 
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	
	local smenupanel = vgui.Create("DPanel",PPM.panel)
	local x,y = parent:GetParent():GetPos()
	local px,py =parent:GetPos()
	local w,h =parent:GetSize()
	smenupanel:SetSize( w, 3*h )  
	smenupanel:SetPos(px+x,py+y-3*h+h)
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
			colorFlash(bPSave, 0.1, Color(200,0,0),Color(255,255,255))
			colorFlash(PPM.button_save, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		if(table.HasValue( PPM.reservedPresetNames,selected_fname)) then 
			colorFlash(bPSave, 0.1, Color(200,0,0),Color(255,255,255))
			colorFlash(PPM.button_save, 0.1, Color(200,0,0),Color(255,255,255))
		return end
		PPM.Save(selected_fname,LocalPlayer().ponydata) 
		colorFlash(PPM.button_save, 0.1, Color(0,200,0),Color(255,255,255))
		 
		LoadFileList(PPM.dPresetList)
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
function ReopenRight()
	if left_open then
		toggle_panel_left(lcur_id)
		timer.Simple(0.5,function() 
		toggle_panel_left(lcur_id) end)
	end
end
function LoadFileList(CTL)
	CTL:Clear()
	local files = file.Find("data/ppm/*.txt","GAME" )
	for k,v in pairs(files) do
		if(!string.match( v,"*/_*", 0 )) then
			CTL:AddLine(v)   
		end
	end
end

 curmenupanel = nil
 curfunctpanel = nil
local tempcolorray = {
	Color(200,180,180),
	Color(180,200,180),
	Color(180,180,200),
	Color(200,200,180),
	Color(180,200,200),
	Color(200,180,200),
	Color(159,180,180),
	Color(159,159,180),
	Color(180,159,159),
	Color(159,180,159),
	Color(180,180,159),
	Color(159,180,180),
	Color(50,180,180),
	Color(50,180,50),
	Color(50,50,180),
	Color(159,50,50),
	Color(159,50,159)
} 
function SetupEl(selector,text,psx,psy)
	local delay = 0.4
	local gsx,gsy =selector:GetSize() 
	selector:SizeTo( gsx,gsy, delay, 0, 1) 
	selector:MoveTo( psx,psy, delay, 0, 1) 
	selector:SetPos(ScrW()/2,ScrH()/2)
	selector:SetSize(0,0)
	if text != "" then
		timer.Simple(delay+0.3,function()
		local lab1 = vgui.Create("DLabel", selector) 
		lab1:SetText(text)  
		lab1:SetFont(PPM.EDM_FONT)
		lab1:SizeToContents()  
		lab1:SetColor(Color(0,0,0,255))
		local x,y =selector:GetPos()
		local w,h =selector:GetSize()
		local sw,sh =lab1:GetSize()
		lab1:SetPos(w/2-sw/2,h/2-sh/2)end)
	end
end
function SetupSelector(selector,text,value,key,nocolor,psx,psy)
	local delay = 0.4
	local gsx,gsy =selector:GetSize() 
	selector:SizeTo( gsx,gsy, delay, 0, 1) 
	selector:MoveTo( psx,psy, delay, 0, 1) 
	selector:SetPos(ScrW()/2,ScrH()/2)
	selector:SetSize(0,0)
	
	if nocolor then 
		selector:SetColor( Color(255,255,255))
	else
		selector:SetColor(tempcolorray[key] or Color(255,255,255))
	end
	timer.Simple(delay+0.3,function()
	
	local lab1 = vgui.Create("DLabel", selector) 
	lab1:SetText(text)  
	lab1:SetFont(PPM.EDM_FONT)
	lab1:SizeToContents()  
	lab1:SetColor(Color(0,0,0,255))
	local x,y =selector:GetPos()
	local w,h =selector:GetSize()
	local sw,sh =lab1:GetSize()
	lab1:SetPos(w/2-sw/2,h/2-sh)
	
	local lab2 = vgui.Create("DLabel", selector) 
	lab2:SetText(value)  
	lab2:SizeToContents()  
	sw,sh =lab2:GetSize()
	lab2:SetColor(Color(0,0,0,255)) 
	lab2:SetPos(w/2-sw/2,h/2+sh)
	selector.vc = lab2
	end)
end

function SetupItemSelector(selector,text,index,psx,psy)
	local delay = 0.4
	local gsx,gsy =selector:GetSize() 
	selector:SizeTo( gsx,gsy, delay, 0, 1) 
	selector:MoveTo( psx,psy, delay, 0, 1) 
	selector:SetPos(ScrW()/2,ScrH()/2)
	selector:SetAlpha(255)
	selector:SetColor(Color(255,255,255,0))
	selector:SetImage( "gui/items/none.png" )
	selector.REALITEMINDEX = index
	//MsgN(selector.REALITEMINDEX)
	
	timer.Simple(delay+0.3,function()
		selector.disp = vgui.Create("DImage", selector) 
		selector.disp:SetImage( "gui/items/none.png" )
		selector.onselect = function( k ,item)   
			LocalPlayer().pi_wear[selector.REALITEMINDEX] = item
			PPM_UpdateSlots(0)
		end
		if psx>ScrW()/2 then
			WEARSLOTSR[selector.REALITEMINDEX] = selector
		else
			WEARSLOTSL[selector.REALITEMINDEX] = selector
		end 
		local selector_button = vgui.Create("DImageButton", selector) 
		selector.btn = selector_button
		selector_button:Dock(FILL)
		selector_button:SetImage( "gui/item.png" )
		selector_button:SetAlpha(200)
		
		selector_button.DoClick = function( button )  
			 OpenItemMenu(selector,selector.REALITEMINDEX,psx>ScrW()/2) 
		end
	
	
		local lab1 = vgui.Create("DLabel", selector) 
		lab1:SetText(text)  
		lab1:SetFont(PPM.EDM_FONT)
		lab1:SizeToContents()  
		lab1:SetColor(Color(255,255,255,255))
		local x,y =selector:GetPos()
		local w,h =selector:GetSize()
		local sw,sh =lab1:GetSize()
		lab1:SetPos(w/2-sw/2,h/2+sh*1.5) 
		selector.disp:SetPos(5,5)
		selector.disp:SetSize(w-10,h-10)
		
	end)
end
function SetupColorSelector(selector,text,color,psx,psy)
	local delay = 0.4
	local gsx,gsy =selector:GetSize() 
	selector:SizeTo( gsx,gsy, delay, 0, 1) 
	selector:MoveTo( psx,psy, delay, 0, 1) 
	selector:SetPos(ScrW()/2,ScrH()/2)
	selector:SetSize(0,0)
	 
	selector:SetColor( color*255) 
		
	timer.Simple(delay+0.3,function()
	local lab1 = vgui.Create("DLabel", selector) 
	lab1:SetText(text)  
	lab1:SetFont(PPM.EDM_FONT)
	lab1:SizeToContents()  
	lab1:SetColor(Color(0,0,0,255))
	local x,y =selector:GetPos()
	local w,h =selector:GetSize()
	local sw,sh =lab1:GetSize()
	lab1:SetPos(w/2-sw/2,h/2-sh/2)
	
	
	end)
end
function SetupSelectIon(item,text,down) 
	local lab1 = vgui.Create("DLabel", item) 
	lab1:SetText(text)
	lab1:SetFont(PPM.EDM_FONT)
	lab1:SizeToContents()  
	lab1:SetColor(Color(0,0,0,255))
	lab1:SetAlpha(255)
	local x,y =item:GetPos()
	local w,h =item:GetSize()
	local sw,sh =lab1:GetSize()
	if(down) then
	lab1:SetPos(w/2-sw/2,h-sh)
	else
	lab1:SetPos(w/2-sw/2,h/2-sh/2)
	end
	item.lab1 = lab1;
end

function PPM_UpdateSlots(LRB)
	if LRB==0 || LRB==1 then
		for k , eqSlot in pairs(WEARSLOTSL) do
			if eqSlot!=nil and eqSlot!=NULL then 
				//MsgN(k,eqSlot.weareditem)
				eqSlot.weareditem = LocalPlayer().pi_wear[k] 
				if(eqSlot.weareditem !=nil) then 
					eqSlot.btn:SetTooltip( eqSlot.weareditem.name )  
					eqSlot.disp:SetImage( "gui/items/"..eqSlot.weareditem.img..".png" ) 
					
					PONYPM:pi_SetupItem(eqSlot.weareditem,PPM.editor_clothing,true)  
					PONYPM:pi_SetupItem(eqSlot.weareditem,LocalPlayer()) 
				end
			end
		end
	end
	if LRB==0 || LRB==2 then
		for k , eqSlot in pairs(WEARSLOTSR) do
			if eqSlot!=nil and eqSlot!=NULL  then  
				eqSlot.weareditem = LocalPlayer().pi_wear[k]
				if(eqSlot.weareditem !=nil) then
					 
					eqSlot.btn:SetTooltip( eqSlot.weareditem.name )  
					eqSlot.disp:SetImage( "gui/items/"..eqSlot.weareditem.img..".png" ) 
					
					PONYPM:pi_SetupItem(eqSlot.weareditem,PPM.editor_clothing,true)  
					PONYPM:pi_SetupItem(eqSlot.weareditem,LocalPlayer()) 
				end
			end
		end
	end
end
function OpenItemMenu(parent,realid,rightside) 
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	local plymodel =LocalPlayer():GetInfo( "cl_playermodel" )
	local avitems = PONYPM:GetAvailItems(plymodel,realid)
	if avitems == nil then return end
	
	local smenupanel = vgui.Create("DPanel",PPM.panel)
	local x,y =parent:GetPos()
	local w,h =parent:GetSize()
	local linecount =math.Clamp(math.ceil(table.Count( avitems)/3),1,5)
	smenupanel:SetSize( 230, 68*linecount ) 
	if rightside then
		smenupanel:SetPos(x-230,y)
	else
		smenupanel:SetPos(x+w,y)
	end 
	curmenupanel = smenupanel
	
	local bExit = vgui.Create( "DButton", smenupanel )
	bExit:SetSize( 20, 20 ) 
	if rightside then
		bExit:Dock( LEFT )
	else
		bExit:Dock( RIGHT )
	end
	bExit:SetPos(0,0)
	bExit:SetText( "X" )
	bExit.DoClick = function( button ) 
		smenupanel:Remove( )  curmenupanel = nil
	end
	local PanelSelect = smenupanel:Add( "DPanelSelect" )
	PanelSelect:Dock( FILL )
	
	
	for k ,item in SortedPairs(avitems) do 
		local bopt = vgui.Create( "DImageButton", PanelSelect )
		bopt:SetSize( 64, 64 )
		bopt:SetTooltip( item.name )  
		SetupSelectIon(bopt,item.name,true) 
		
		bopt:SetImage("gui/items/"..item.img..".png" )
		bopt.col= Color(255,255,255) 
		
		bopt.OnMousePressed = function( button )  
			smenupanel:Remove( )  curmenupanel = nil 
			if(parent.vc!=nil) then 
			
			parent.vc:SetText( item.name ) 
			parent.vc:SizeToContents()  
			local x,y =parent:GetPos()
			local w,h =parent:GetSize()
			local sw,sh =parent.vc:GetSize()
			parent.vc:SetPos(w/2-sw/2,h/2+sh)
			
			end 
			
			net.Start("player_equip_item")
			net.WriteFloat(item.id) 
			net.SendToServer()
			
			if(parent.onselect!=nil) then parent.onselect(k,item) end 
		end  
		PanelSelect:AddPanel( bopt , { }) 
	end
	
end
function OpenSelectorMenu(parent,angle,options,textures,curoptionid) 
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	
	local smenupanel = vgui.Create("DPanel",PPM.panel)
	local x,y =parent:GetPos()
	local w,h =parent:GetSize()
	smenupanel:SetSize( 230, 64*3 )  
	smenupanel:SetPos(x+w,y)
	curmenupanel = smenupanel
	
	local bExit = vgui.Create( "DButton", smenupanel )
	bExit:SetSize( 20, 20 ) 
	bExit:Dock( RIGHT )
	bExit:SetPos(0,0)
	bExit:SetText( "X" )
	bExit.DoClick = function( button ) 
		smenupanel:Remove( )  curmenupanel = nil
	end
	local PanelSelect = smenupanel:Add( "DPanelSelect" )
	PanelSelect:Dock( FILL )
	PanelSelect:EnableVerticalScrollbar()
	for k ,v in pairs(options) do 
		local bopt = vgui.Create( "DImageButton", PanelSelect )
		bopt:SetSize( 64, 64 )
		bopt:SetTooltip( v )  
		SetupSelectIon(bopt,v,textures!=nil)
		if(textures!=nil)then
			bopt:SetImage(textures[k])
			bopt.col= Color(255,255,255)
		else
			bopt:SetImage( "gui/editor/group_circle.png" )
			bopt.col =tempcolorray[k] or Color(255,255,255)
			bopt:SetColor(bopt.col)
		end
		bopt.OnMousePressed = function( button ) 
			smenupanel:Remove( )  curmenupanel = nil
			parent:SetColor(bopt.col)
			if(parent.vc!=nil) then 
			
			parent.vc:SetText( v ) 
			parent.vc:SizeToContents()  
			local x,y =parent:GetPos()
			local w,h =parent:GetSize()
			local sw,sh =parent.vc:GetSize()
			parent.vc:SetPos(w/2-sw/2,h/2+sh)
			
			end
			if(parent.onselect!=nil) then parent.onselect(k,v) end
		end  
		PanelSelect:AddPanel( bopt , { }) 
	end
	PanelSelect.VBar.Scroll =  ( 64*(curoptionid/3)-64 ) 
	MsgN(PanelSelect.VBar)
	MsgN(PanelSelect.VBar.Scroll)
end

function OpenColorSelectorMenu(parent,color) 
	if(curmenupanel!=nil) then curmenupanel:Remove( ) curmenupanel = nil end
	
	local smenupanel = vgui.Create("DPanel",PPM.panel)
	local x,y =parent:GetPos()
	local w,h =parent:GetSize()
	smenupanel:SetSize( 300, 260 )  
	smenupanel:SetPos(x+w,y)
	curmenupanel = smenupanel
	
	local sR = vgui.Create("DPanel",smenupanel)
	sR:SetSize( 20, 20 ) 
	sR:Dock( RIGHT )
	
	local bExit = vgui.Create( "DButton", sR )
	bExit:SetSize( 20, 130 ) 
	bExit:Dock( TOP )
	bExit:SetPos(0,0)
	bExit:SetText( "X" )
	bExit.DoClick = function( button ) 
		smenupanel:Remove( )  curmenupanel = nil
	end
	local PanelSelect = smenupanel:Add( "DColorMixer" )
	
	local bCANCEL = vgui.Create( "DButton", sR )
	bCANCEL:SetSize( 20, 130 ) 
	bCANCEL:Dock( BOTTOM )
	bCANCEL:SetPos(0,0)
	bCANCEL:SetText( "C" )
	bCANCEL.DoClick = function( button ) 
		PanelSelect:SetColor(Color(color.x*255,color.y*255,color.z*255,255))
		PanelSelect.ValueChanged()
	end
	
	PanelSelect:SetColor(Color(color.x*255,color.y*255,color.z*255,255))
	 
	PanelSelect:Dock( FILL )
	
	PanelSelect.ValueChanged	= function() 
		if(parent.onselect!=nil) then parent.onselect(PanelSelect:GetVector()) end
		parent:SetColor(PanelSelect:GetColor())
	end
	
	
end
function OpenFunctorMenu(parent,angle,options) 
	if(curfunctpanel!=nil) then curfunctpanel:Remove( ) curfunctpanel = nil end
	
	
	
	
	local bExit = vgui.Create( "DButton", smenupanel )
	bExit:SetSize( 20, 20 ) 
	bExit:Dock( BOTTOM )
	bExit:SetPos(0,0)
	bExit:SetText( "X" )
	bExit.DoClick = function( button ) 
		smenupanel:Remove( )  curfunctpanel = nil
	end
	//bound_menu
	
end

function colorFlash(controll, time, color,defcolor) 
	 
	 controll:SetColor(color)
	timer.Simple(time,function()
		controll:SetColor(defcolor)
	end)
end
function VectorToLPCameraScreen( vDir, iScreenW, iScreenH, angCamRot, fFoV )
	--Same as we did above, we found distance the camera to a rectangular slice of the camera's frustrum, whose width equals the "4:3" width corresponding to the given screen height.
	local d = 4 * iScreenH / ( 6 * math.tan( 0.5 * fFoV ) );
	local fdp = angCamRot:Forward():Dot( vDir );
 
	--fdp must be nonzero ( in other words, vDir must not be perpendicular to angCamRot:Forward() )
	--or we will get a divide by zero error when calculating vProj below.
	if fdp == 0 then
		return 0, 0, -1
	end
 
	--Using linear projection, project this vector onto the plane of the slice
	local vProj = ( d / fdp ) * vDir;
 
	--Dotting the projected vector onto the right and up vectors gives us screen positions relative to the center of the screen.
	--We add half-widths / half-heights to these coordinates to give us screen positions relative to the upper-left corner of the screen.
	--We have to subtract from the "up" instead of adding, since screen coordinates decrease as they go upwards.
	local x = 0.5 * iScreenW + angCamRot:Right():Dot( vProj );
	local y = 0.5 * iScreenH - angCamRot:Up():Dot( vProj );
 
	--Lastly we have to ensure these screen positions are actually on the screen.
	local iVisibility
	if fdp < 0 then			--Simple check to see if the object is in front of the camera
		iVisibility = -1;
	elseif x < 0 || x > iScreenW || y < 0 || y > iScreenH then	--We've already determined the object is in front of us, but it may be lurking just outside our field of vision.
		iVisibility = 0;
	else
		iVisibility = 1;
	end
 
	return x, y, iVisibility;
end
end