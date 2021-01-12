
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
Data = {species="pony",race="earth"}

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
--	local model2 = parts[id]
--	if model2 then 
--		model2:SetModel(path)
--	else 
--		model2 = ClientsideModel( path , RENDER_GROUP_OPAQUE_ENTITY )  
--		parts[id] = model2
--	end 
--	model2:SetParent(Character)
--	model2:AddEffects(EF_BONEMERGE)
end
function ClearBodyParts()
	for k,v in pairs(parts) do
		v:Remove()
	end
	parts = {}
end
function BuildWindow()
	Tabs = {}
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
	mdl:SetAnimated( true )
	
	Data = LocalPlayer().gcpmdata or Data

	Character = mdl.Entity
	Character.gcpmdata = Data
	Character.Editor = true
	Character:SetSequence(0)
 

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

	local defaultpos = Vector(0,0,30)
	LoadTabs({
		species = {
			name = "Species",
			Action = function()
				SpeciesSelector(Window) 
				SetLook(defaultpos, 75)
			end,
			internal = true
		},
		presets = {
			name = "Presets",
			Action = function()
				SelectedNode = nil
				local sspanel = GetPanel(Window)
				NewPanel({type="presets",name = "Presets"},sspanel)
				SetLook(defaultpos, 75)
			end,
			internal = true
		},
	})

	gcpm.Update(Character)
--	SetupBodyPart("ears","models/mlp/pony_default/parts/chang_ears.mdl")
	SelectSpecies(Data.species,Data.race)
	--Select(Window,gcpm.species.pony.default.Parts.body)
end
function Apply()  
	local cm = LocalPlayer():GetInfo( "cl_playermodel" )
	if cm != "ponytest" then
		RunConsoleCommand( "cl_playermodel", "ponytest" )
	end

	gcpm.SetData(LocalPlayer(),Character.gcpmdata) 
	colorFlash(APPLY, 0.1, Color(0,200,0),Color(255,255,255)) 
end
function colorFlash()

end
function Think(self)
	UpdateCamera(self)
end
TargetViewPos = Vector(0,0,20)
TargetViewFOV = 75
function UpdateCamera(self)

	--TargetViewPos =  Vector(0,math.cos(CurTime())*10,math.sin(CurTime())*20)
	self.vLookatPos = self.vLookatPos + (TargetViewPos-self.vLookatPos)*0.1
	self.fFOV = self.fFOV + (TargetViewFOV-self.fFOV)*0.1--


	if self.ismousepressed then 
		local x, y =self:CursorPos(); 
		self.camangadd =Angle(math.Clamp(self.camang.p-y+self.mdy,-89,13)-self.camang.p, -x+self.mdx, 0)
	end
	local camvec =(Vector(1,0,0)*120)
	camvec:Rotate(self.camang+self.camangadd) 
	self:SetCamPos(self.vLookatPos+camvec) 
	self.camvec = camvec
end
function SetLook(pos,fov)
	TargetViewPos = pos or TargetViewPos
	TargetViewFOV = fov or TargetViewFOV
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

	--Character:SetSequence(0)
	--Character:FrameAdvance( 0.1 )

	local x, y = self:LocalToScreen( 0, 0 )
	local w, h = self:GetSize()

	local ang = self.aLookAngle
	if ( !ang ) then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end
	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, 4096 )
	cam.IgnoreZ( false )
	  
	
	local species = gcpm.GetSpecies(Data.species)
	if species and species.Body and species.Body.flexes then
		for k,v in pairs(species.Body.flexes) do
			local fi = Character:GetFlexIDByName(k)
			local val = gcpm.GetDataValue(species,Data,v)
			Character:SetFlexWeight( fi, val )
		end
	end

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
	  
	Character:SetupBones()
	Character:DrawModel()
	for k,v in pairs(Character:GetChildren()) do 
		local c = v:GetColor()
		--MsgN("c>",c.r," ",c.g," ",c.b)
		render.SetColorModulation( c.r/255, c.g/255, c.b/255 )
		v:DrawModel()
	end



	render.SuppressEngineLighting( false )
	
	UpdateSelectors(self)
	cam.End3D()
	DrawSelectors(self,ang)
end
SelectorPositions = {}
function UpdateSelectors(self)
	if SelectedNode then  
		for k,v in pairs(SelectedNode) do
			if v.pos then
				local nodepos = v.pos
				if v.bone then
					nodepos = nodepos + Character:GetBonePosition(Character:LookupBone(v.bone))
				end
				SelectorPositions[k] = (Character:GetPos()+ nodepos):ToScreen()
			end
		end
	end
end
mat_lid_ind = Material("gui/editor/lid_ind.png")
SelectedPoint = false
function DrawSelectors(self,ang)
	if SelectedNode then
		local race, species = gcpm.GetRace(Data)

		local w, h = self:GetSize()
		for k,v in pairs(SelectedNode) do
			local valid = true
			if v.racial then 
				if not race.Parts[k] then 
					valid = false
				end
			end
			if v.enabled then
				local dval = gcpm.GetProcDataValue(species,Data,v.enabled,false)
				--print("DVAL",dval,v.enabled)
				if not dval then
					valid = false
				end
			end
			if valid and v.pos then
				local nodepos = v.pos

				if v.bone then
					nodepos = nodepos + Character:GetBonePosition(Character:LookupBone(v.bone))
				end
				
				local locpos = ((Character:GetPos()+ nodepos)- self.camvec-self.vLookatPos):GetNormal( )
				
				--local tbl =(( v.pos)+LocalPlayer():GetPos()+ self.vCamPos   ):ToScreen() 
				
				local ud = SelectorPositions[k]  
				if ud then
					local x,y, viz = ud.x, ud.y, ud.visible -- VectorToLPCameraScreen(locpos, w, h, ang,math.rad( self.fFOV))

					
					local r3 =25
					local ss =math.sin(CurTime())+1

					local text_lowerer = 0
					
					local tt =50
					local tvpos =Vector(x,y,0)
					local mousepos =Vector( self:CursorPos())--input.GetCursorPos( ))
					local dist = tvpos:Distance(mousepos)/40
					
					if SelectedPoint==k then
						surface.SetDrawColor( 0, 255, 0, 80 ) 
						surface.SetMaterial(mat_lid_ind )
						surface.DrawTexturedRectRotated( x,y, r3*2,r3*2 ,CurTime()*200)
						text_lowerer = 20
					elseif dist < 0.8 then
						surface.SetDrawColor( 0, 0, 255, 80 ) 
						surface.SetMaterial(mat_lid_ind ) 
						surface.DrawTexturedRectRotated( x,y, r3*2,r3*2 ,CurTime()*200) 
						if input.IsButtonDown(MOUSE_LEFT) then 
							if k~=SelectedPoint then
								SelectedPoint = k 
								Select(self,v)
							end
						end
						text_lowerer = 20
					end
					draw.SimpleTextOutlined(v.name, "TAHDS", x, y+text_lowerer,  Color( 255, 255, 255,  255/dist ), 
						TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2,  Color( 0,0,0, 255/dist ) )
					 

				end
			end
		end
	end
end 
function GetPanel(window)
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
	return sspanel
end
function NewPanel(v,parent)
	local tp = panels[v.type] 
	if tp then 
		local header = vgui.Create( "DCollapsibleCategory", parent )	 
		header:SetLabel( v.name )					 
		header:SetPos( 25, 50 )		 
		header:SetSize( 250, 100 )	  
		header:Dock(TOP)
		local content = vgui.Create( "DPanelList",parent  ) 
		content:SetSpacing( 5 )							 
		content:EnableHorizontal( false )				  
		header:SetContents( content )		 
		 
		tp.spawn(content,v) 
	end
end
function SpeciesSelector(Window) 
	SelectedNode = nil
	local sspanel = GetPanel(window)
	NewPanel({type="select_species",name = "Species"},sspanel)
end
function Select(Window,node) 
	local sspanel = GetPanel(window)
	--cleanValueEditors()
	sspanel:Clear()

  
	for k,v in pairs(node.params) do  
		NewPanel(v,sspanel)
	end 
end 

function SelectSpecies(species,race)
	local data = gcpm.GetSpecies(species)
	if data then
		local model = data.Models[1]
		Character:SetModel(data.Directory.."/"..model.File)
		Character:SetSequence(ACT_IDLE)
		gcpm.InitSpeciesParams(Character) 
		--if model.Bodygroups then
		--	for k,v in pairs(model.Bodygroups) do
		--		local bg = Character:FindBodygroupByName(k)
		--		Character:SetBodygroup(bg, v)
		--	end
		--end
		--if model.Flexes then
		--	for k,v in pairs(model.Flexes) do
		--		local id = Character:GetFlexIDByName(k)
		--		Character:SetFlexWeight(id, v)
		--		Character:SetFlexScale(1)
		--	end
		--end
		Character:SetSkin(model.Skin or 0) 
		---local racetbl = data.Races[race]
		---ClearBodyParts()
		---for k,v in pairs(racetbl.Parts) do
		---	MsgN("FFF ",k)
		---	SetupBodyPart(k,data.PartsDirectory.."/"..v.model)
		---end
		SelectedNode = nil
		LoadTabs(data.Editor,60)  
	end
	gcpm.Update(Character)
end


Tabs = {}
SelectedTab = SelectedTab or nil
SelectedNode = SelectedNode or nil

function LoadTabs(data,off)
	for k,v in pairs(Tabs) do
		if not v.internal then
			v:Remove()
			Tabs[k] = nil
		end
	end 

	local taboffcet= table.Count(Tabs)*128 + (off or 0)
	for k,v in pairs(data) do	
		local TABBUTTON = Tabs[k] or vgui.Create( "X_ImageButton", Window ) 
		TABBUTTON.node = v
		TABBUTTON:SetSize( 128, 64 ) 
		TABBUTTON:SetPos( 100+taboffcet, -20 )  
		TABBUTTON:SetImage( "gui/editor/gui_tab.png" ) 
		TABBUTTON:SetFont("Trebuchet24")
		TABBUTTON:SetText(v.name)
		TABBUTTON:SetColor(Color(0,0,0)) 
		TABBUTTON.internal = TABBUTTON.internal or v.internal
		TABBUTTON.OnCursorEntered = function() 
			if SelectedTab ~= TABBUTTON then
				local px,py =TABBUTTON:GetPos()
				TABBUTTON:SetPos( px, -10 )  
			end
		end 
		TABBUTTON.OnCursorExited = function() 
			if SelectedTab ~= TABBUTTON then
				local px,py =TABBUTTON:GetPos()
				TABBUTTON:SetPos( px, -20 )  
			end
		end 
		TABBUTTON.DoClick = function() 
			if SelectedTab ~= TABBUTTON then
				if(IsValid(SelectedTab)) then
					local px,py =SelectedTab:GetPos()
					SelectedTab:SetPos( px, -20 )  
				end 
				
				local px,py =TABBUTTON:GetPos()
				TABBUTTON:SetPos( px, 0 )  
				
				SelectedTab = TABBUTTON
				
			end
			local sspanel = GetPanel(window)
			sspanel:Clear()
			SelectedPoint = false
			if v.Action then
				v.Action(v)
			else 
				LoadNode(v)  
			end
		end
		 
		
		
		taboffcet = taboffcet + 128 
		Tabs[k]=TABBUTTON 
	end
end

function LoadNode(node)
	SelectedNode = node.Parts
	
	local nodepos = node.pos 
	if node.bone then
		nodepos = nodepos + Character:GetBonePosition(Character:LookupBone(node.bone))
	end
	SetLook(nodepos,node.fov or 75)
end

function SetPart(ptype,pname)
	local bpdata = Character.gcpm_bpdata or {}
	Character.gcpm_bpdata = bpdata

	local bpent = bpdata[ptype]
	--if IsValid(bpent) then
	--	bpent:Remove()
	--end

	local pdata = gcpm.GetPart(Data,ptype,pname)
	if pdata and pdata.model then
		if not IsValid(bpent) then
			bpent = ents.CreateClientside("cpm_bodypart")
		end
		local mpath = gcpm.GetSpecies(Data.species).PartsDirectory .. '/' .. pdata.model
		if not string.EndsWith(mpath, ".mdl") then
			mpath = mpath .. '.mdl'
		end
		bpent:Set(Character, mpath) 
	else
		if IsValid(bpent) then
			bpent:Remove()
			bpent = nil
		end
	end
	
	bpdata[ptype] = bpent
	parts[ptype] = bpent

end