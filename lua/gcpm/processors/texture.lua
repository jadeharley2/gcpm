module( "gcpm", package.seeall )


local texscale = 512
local PosZero = Vector(0,0,0)
local PosHalf = Vector(0.5,0.5,0)
local ColorWhite = Color(255,255,255)

render_queue = {}
modes = {}

function RequestMaterial(name,data,shader,matdata,mattarget,callback) 
    local RT = GetRenderTarget( name.."_t", texscale, texscale, false )
    
    shader = shader or "UnlitGeneric"
    matdata = matdata or {} 
    matdata[mattarget or "$basetexture"] = RT:GetName()   

    local testmat = CreateMaterial( name, shader, matdata)
    render_queue[name] = {data =data,target = RT,callback = callback}
    return testmat
end


function RenderTexture(RT,data) 
    render.PushRenderTarget( RT )
    render.Clear( 0, 255, 255, 255, true ) 
    cam.Start2D()  

    if data.clear then
        render.Clear( data.clear.r, data.clear.g, data.clear.b, data.clear.a, true)   
    end
    for k,v in ipairs(data.layers) do
        if v.enabled~=2 then
            if v.texture then
                if not v.material then
                    v.material = Material(v.texture)
                end
                render.SetMaterial(v.material)  
            else
                render.SetColorMaterial()
            end 
            render.DrawQuadEasy( 
                (v.pos or PosHalf) * texscale,  
                Vector(0,0,-1),     
                texscale*(v.w or 1),
                texscale*(v.h or 1),   
                v.color or ColorWhite,   
                (v.rotation or 0)-90)   
        end
    end
    
    cam.End2D()
    render.PopRenderTarget() 
end



hook.Add("HUDPaint", "gcpm_render_texture", function()

    for k,v in pairs(render_queue) do
        render_queue[k] = nil
        RenderTexture(v.target,v.data)
        if v.callback then
            pcall(v.callback, k, v.target)
        end
    end
    --[[
    local TEST = RequestMaterial("xxtestxx",{
        clear = Color(0,0,0),
        layers = {
            {
                texture = "models/mlp/partrender/eye_oval.png",
                color = Color(0,0,255),
                w =0.5,
                h =0.2,
                rotation = 100*CurTime()
            },
            {
                texture = "models/mlp/partrender/eye_oval.png",
                color = Color(255,0,0),
                w =0.5,
                h =0.2,
                rotation = 80*CurTime()
            },
            {
                texture = "models/mlp/partrender/eye_oval.png",
                color = Color(0,255,0),
                w =0.5,
                h =0.1,
                rotation = 90*CurTime()
            }
        }
    })  
    surface.SetDrawColor( ColorWhite )
    surface.SetMaterial( Material("!xxtestxx") )
    surface.DrawTexturedRect(200, 200, 512, 512)

    ]]
end)



modes.part_layers = function(ent,name,data)

end