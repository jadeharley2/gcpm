--[[

{model="x"} -- body part


]]
gcpm.AddSpecies("changelling",{
    PrintName = "Changelling",
    Directory = "models/mlp/pony_default",
    Parameters = {
        coatcolor  = {type="color",name="Coat color",default = Color(255,255,255)},
        haircolor1 = {type="color",name="Color 1",default = Color(255,0,0)},
        haircolor2 = {type="color",name="Color 2",default = Color(0,255,0)},
        haircolor3 = {type="color",name="Color 3",default = Color(0,0,255)},
        haircolor4 = {type="color",name="Color 4",default = Color(255,255,0)},
        haircolor5 = {type="color",name="Color 5",default = Color(0,255,255)},
        haircolor6 = {type="color",name="Color 6",default = Color(255,0,255)},
        
        horncolor =  {type="color",name="Horn Color",default = Color(150,150,150,100)},

        height      = {type="number",default = 0,min=0,max=0.2}, -- -0.5
        bodyweight  = {type="number",default = 1,min=0.8,max=1.2},
        weightbalance  = {type="number",default = 0.5,min=0,max=1},
        wingssize   = {type="number",default = 1,min=0.8,max=1.2},
        tailsize    = {type="number",default = 1,min=0.5,max=1.5},
        lmanesize   = {type="number",default = 1,min=0.5,max=1.5},
        umanesize   = {type="number",default = 1,min=0.5,max=1.5},

        heterochromia  = {type="bool",name="Heterochromia",default = false},
        
        eyecolor_bg = {type="color",default = Color(255,255,255)},
        eyecolor_hole = {type="color",default = Color(0,0,0)},
        eyecolor_iris = {type="color",default = Color(150,150,150)},
        eyecolor_grad = {type="color",default = Color(255,150,150)},
        eyecolor_line1 = {type="color",default = Color(150,255,150)}, 
        eyecolor_line2 = {type="color",default = Color(150,150,255)},
        eyecolor_effects = {type="color",default = Color(255,255,255)},
        eyeirissize = {type="number",default = 0.6},
        eyehaslines = {type="bool",default = true}, 
        eyeholesize = {type="number",default = 0.7},
        eyejholerssize = {type="number",default = 1},

        eyelashes_type = {type="number",default = 0},
        eyelashes_color = {type="color",name="Horn Color",default = Color(10,10,10)},

        eye2color_bg = {type="color",default = Color(255,255,255)},
        eye2color_hole = {type="color",default = Color(0,0,0)},
        eye2color_iris = {type="color",default = Color(150,150,150)},
        eye2color_grad = {type="color",default = Color(255,150,150)},
        eye2color_line1 = {type="color",default = Color(150,255,150)}, 
        eye2color_line2 = {type="color",default = Color(150,150,255)}, 
        eye2color_effects = {type="color",default = Color(255,255,255)},
 

        eyeshadow =  {type="color",default = Color(150,150,255,0)},
        eyeliner =   {type="color",default = Color(0,0,0,100)},
        lips    =   {type="color",default = Color(150,150,255,0)},
        
        head_form_0  = {type="number",default = 0,min=0,max=1},
        eye_form     = {type="number",default = 0,min=0,max=1},
        eye_form2     = {type="number",default = 0,min=0,max=1},
        eyelash_form = {type="number",default = 1,min=0,max=1},
 
        bodymask1   = {type="string",default="none"},
        bodymask2   = {type="string",default="none"},
        bodymask3   = {type="string",default="none"},
        bodymask4   = {type="string",default="none"},
        bodymask5   = {type="string",default="none"},
        bodymask6   = {type="string",default="none"}, 
        bodymask7   = {type="string",default="none"}, 
        bodymask8   = {type="string",default="none"}, 
        bodymask9   = {type="string",default="none"}, 
        bodymask1_c = {type="color",name="Mask 1 Color",default = Color(255,0,0)},
        bodymask2_c = {type="color",name="Mask 2 Color",default = Color(255,0,0)},
        bodymask3_c = {type="color",name="Mask 3 Color",default = Color(255,0,0)},
        bodymask4_c = {type="color",name="Mask 4 Color",default = Color(255,0,0)},
        bodymask5_c = {type="color",name="Mask 5 Color",default = Color(255,0,0)},
        bodymask6_c = {type="color",name="Mask 6 Color",default = Color(255,0,0)},
        bodymask7_c = {type="color",name="Mask 7 Color",default = Color(255,0,0)},
        bodymask8_c = {type="color",name="Mask 8 Color",default = Color(255,0,0)},
        bodymask9_c = {type="color",name="Mask 9 Color",default = Color(255,0,0)},

    },
    Materials = {
        body = {
            matdata = {  
                ["$bumpmap"] = "models/mlp/base/render/body_n",
                ["$model"] = 1,
                ["$phong"] = 1,
                
                ["$phongexponent"] = 0.6,
                ["$phongboost"] = 0.5,
                ["$phongalbedotint"] = 1,
                ["$phongtint"] = Vector(1,0.95,0.95),
                ["$phongfresnelranges"] =	Vector(0.5,6,10),
                
                ["$rimlight"] =                1,
                ["$rimlightexponent"] =        2,
                ["$rimlightboost"] =           1 ,
            }, 
            mode = "procedural",  
            layers = {
                {
                    texture = "models/mlp/base/body2.png",
                    color = "$coatcolor"
                }, 
                {
                    texture = "@ 'models/mlp/body/'..(bodymask1 or 'none')..'.png'",
                    color = "$bodymask1_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask2 or 'none')..'.png'",
                    color = "$bodymask2_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask3 or 'none')..'.png'",
                    color = "$bodymask3_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask4 or 'none')..'.png'",
                    color = "$bodymask4_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask5 or 'none')..'.png'",
                    color = "$bodymask5_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask6 or 'none')..'.png'",
                    color = "$bodymask6_c", 
                }, 
                {
                    texture = "@ 'models/mlp/body/'..(bodymask7 or 'none')..'.png'",
                    color = "$bodymask7_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask8 or 'none')..'.png'",
                    color = "$bodymask8_c", 
                },
                {
                    texture = "@ 'models/mlp/body/'..(bodymask9 or 'none')..'.png'",
                    color = "$bodymask9_c", 
                },
                
                {
                    texture = "@ 'models/mlp/parts/eyeshadow.png'",
                    color = "$eyeshadow", 
                },
                {
                    texture = "@ 'models/mlp/parts/eyeline.png'",
                    color = "$eyeliner", 
                },
                {
                    texture = "@ 'models/mlp/parts/lips.png'",
                    color = "$lips", 
                }, 
            } 
        },
        eyel = {
            matdata = { 
               -- ["$Iris"]      =         "models/mlp/base/face/p_luna",
                ["$Irisframe"] =0    ,
        
                ["$AmbientOcclTexture"] ="models/mlp/base/face/black"  ,   
                ["$Envmap" ]            ="models/mlp/base/face/black"   ,  
                ["$CorneaTexture"]     = "models/mlp/base/face/white"   ,   
                ["$lightwarptexture"]= "models/mlp/clothes/lightwarp"  ,
        
                ["$EyeballRadius"] =3.7    ,
                ["$AmbientOcclColor"] =Vector(0.3,0.3,0.3)  ,
                ["$Dilation"] =0.5      ,
                ["$Glossiness"] =1      ,
                ["$ParallaxStrength"] =0.1          ,
                ["$CorneaBumpStrength"] =0.1   ,
        
                ["$halflambert"] =1,
                ["$nodecal"] =1,
        
                ["$RaytraceSphere"] =1     ,
                ["$SphereTexkillCombo"] =0   , 
            },
            mode = "procedural",  
            shader = "eyes",
            target = "iris",
            clear = "@switch(heterochromia,eye2color_bg,eyecolor_bg)",  
            layers = {
                { 
                    texture = "models/mlp/partrender/eye_oval.png",
                    color = "@switch(heterochromia,eye2color_iris,eyecolor_iris)",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                { 
                    texture = "models/mlp/partrender/eye_grad.png",
                    color = "$eyecolor_grad",
                    color = "@switch(heterochromia,eye2color_grad,eyecolor_grad)",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    --enabled = "$eyehaslines",
                    texture = "models/mlp/partrender/eye_line_r2.png", 
                    color = "@switch(heterochromia,eye2color_line2,eyecolor_line2)",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    --enabled = "$eyehaslines",
                    texture = "models/mlp/partrender/eye_line_r1.png", 
                    color = "@switch(heterochromia,eye2color_line1,eyecolor_line1)",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                { 
                    texture = "models/mlp/partrender/eye_oval.png",
                    color = "$eyecolor_hole",
                    color = "@switch(heterochromia,eye2color_hole,eyecolor_hole)",
                    w = "@ eyeirissize * eyeholesize * eyejholerssize",
                    h = "@ eyeirissize * eyeholesize",
                },
                { 
                    texture = "models/mlp/partrender/eye_effect.png",
                    color = "@switch(heterochromia,eye2color_effects,eyecolor_effects)",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {  
                    texture = "models/mlp/partrender/eye_reflection.png",
                    color = "@switch(heterochromia,eye2color_effects,eyecolor_effects)",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
            } 
        },
        eyer = {
            matdata = {
                --["$Iris"]      =         "models/mlp/base/face/p_luna",
                ["$Irisframe"] =0    ,
        
                ["$AmbientOcclTexture"] ="models/mlp/base/face/black"  ,   
                ["$Envmap" ]            ="models/mlp/base/face/black"   ,  
                ["$CorneaTexture"]     = "models/mlp/base/face/white"   ,   
                ["$lightwarptexture"]= "models/mlp/clothes/lightwarp"  ,
        
                ["$EyeballRadius"] =3.7    ,
                ["$AmbientOcclColor"] =Vector(0.3,0.3,0.3)  ,
                ["$Dilation"] =0.5      ,
                ["$Glossiness"] =1      ,
                ["$ParallaxStrength"] =0.1          ,
                ["$CorneaBumpStrength"] =0.1   ,
        
                ["$halflambert"] =1,
                ["$nodecal"] =1,
        
                ["$RaytraceSphere"] =1     ,
                ["$SphereTexkillCombo"] =0   , 
            },
            mode = "procedural",  
            shader = "eyes",
            target = "iris",
            clear = "$eyecolor_bg",
            layers = {  
                {
                    texture = "models/mlp/partrender/eye_oval.png",
                    color = "$eyecolor_iris",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    texture = "models/mlp/partrender/eye_grad.png",
                    color = "$eyecolor_grad",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    --enabled = "$eyehaslines",
                    texture = "models/mlp/partrender/eye_line_l2.png",
                    color = "$eyecolor_line2",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    --enabled = "$eyehaslines",
                    texture = "models/mlp/partrender/eye_line_l1.png",
                    color = "$eyecolor_line1",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    texture = "models/mlp/partrender/eye_oval.png",
                    color = "$eyecolor_hole",
                    w = "@ eyeirissize * eyeholesize * eyejholerssize",
                    h = "@ eyeirissize * eyeholesize",
                },
                {
                    texture = "models/mlp/partrender/eye_effect.png",
                    color = "$eyecolor_effects",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
                {
                    texture = "models/mlp/partrender/eye_reflection.png",
                    color = "$eyecolor_effects",
                    w = "$eyeirissize",
                    h = "$eyeirissize",
                },
            } 
        }, 
    },
    Models = {
        {
            File = "player_default_base.mdl",
            Bodygroups = {
                Body = 2,
                Cmark = 1,
                dump_bones_donotuse=0,
            },
            Materials = { 
                mouth = 0,
                body = 1,
                eyel = 2,
                eyer = 3,  
            },
            Flexes = {
                m02=1
            },
            Skin = 3
        } 
    },
    Body = {
        skin = "eyelashes_type",
        materials = {
            {},
            "body",
            "eyel",
            "eyer",
            {
                mode = "color", 
                params = "eyelashes_color"
            },   
            {
                mode = "color", 
                texture = "models/mlp/base/l0",
                params = "eyelashes_color",
                matdata = {
                    ["$alphatest"] = 1
                },
            },   
            {
                mode = "color", 
                texture = "models/mlp/base/l1",
                params = "eyelashes_color",
                matdata = {
                    ["$alphatest"] = 1
                },
            },   
        },
        flexes = {
            m01 = "head_form_0",
            e01 = "eye_form", 
            eyelashesturn = "eyelash_form",
            langry = "eye_form2",
            rangry = "eye_form2",
        },
        bones = {
            groups = {
                leg_bl = {"Lrig_LEG_BL_Femur","Lrig_LEG_BL_Tibia",
                "Lrig_LEG_BL_LargeCannon","Lrig_LEG_BL_PhalanxPrima","Lrig_LEG_BL_RearHoof"},
                leg_br = {"Lrig_LEG_BR_Femur","Lrig_LEG_BR_Tibia",
                "Lrig_LEG_BR_LargeCannon","Lrig_LEG_BR_PhalanxPrima","Lrig_LEG_BR_RearHoof"}, 
                leg_fl = {"Lrig_LEG_FL_Scapula","Lrig_LEG_FL_Humerus","Lrig_LEG_FL_Radius",
                "Lrig_LEG_FL_Metacarpus","Lrig_LEG_FL_PhalangesManus","Lrig_LEG_FL_FrontHoof"},
                leg_fr = {"Lrig_LEG_FR_Scapula","Lrig_LEG_FR_Humerus","Lrig_LEG_FR_Radius",
                "Lrig_LEG_FR_Metacarpus","Lrig_LEG_FR_PhalangesManus","Lrig_LEG_FR_FrontHoof"},
                neck = {"LrigNeck1","LrigNeck2","LrigNeck3"},
                ribcage = {"LrigSpine1","LrigSpine2","LrigRibcage"},
                rear = {"LrigPelvis"},
                tail = {"Tail01","Tail02","Tail03"},--,"LrigTail4","LrigTail5","LrigTail6"},
                uppermane = {"Mane01","Mane04","Mane05","Mane06","Mane07"},
                lowermane = {"Mane02","Mane03","Mane03_tip"},
                --wings = {"WingRight0.R","WingRight0.L","LrigRibcage"},
            },
            modifiers = {
                rescale = {
                    leg_bl = "$bodyweight",
                    leg_br = "$bodyweight",
                    leg_fl = "$bodyweight",
                    leg_fr = "$bodyweight",
                    neck = "$bodyweight",
                    rear = "$bodyweight",
                    ["tail:tail"] = "$tailsize",
                    ["lowermane:lowermane"] = "$lmanesize",
                    ["uppermane:uppermane"] = "$umanesize",
                }
            }
        },
        poseparams = {
            height_test = "$height"
        }
    },
    
    Eyes = {
        attachment = "eyes",
        offset = 2,
        set = 40,
    },
    Viewmodel = {
        material = "body"
    },

    PartsDirectory = "models/mlp/pony_default/parts",
    Parts = {
        ears = {
            variants = {
                chang_ears={model="chang_ears.mdl",material = "body"}
            }
        },
        wings = {
            variants = {
                none = {},
                head_01_ears={model="head_01_ears.mdl"}
            }
        },
        horn = {
            variants = {
                none = {},
                changhorn_01={
                    model="changhorn_01.mdl",
                    material = {
                        mode = "color",   
                        params = "coatcolor"
                    }
                }
            }
        },
        mane = {
            basematerial = "uppermane",
            variants = {
                none = {},  
                changmane_01={model="changmane_01.mdl"}
            }
        }, 
        tail = {
            variants = {
                none = {}, 
                changtail_01={model="changtail_01.mdl"}
            }
        }, 
    },
    Races = {
        changelling = {
            name = "Generic changelling",
            Parts = {
                ears = {whitelist={"chang_ears"}},
                horn = {whitelist={"changhorn_01"}},
                mane = {whitelist={"changmane_01"}},
                tail = {whitelist={"changtail_01"}},
            }
        }, 
    },
    Editor = {
        body = {
            name = "Body" ,
            pos = Vector(0,0,28), 
            Parts = {

                body = {
                    name = "Body" ,
                    pos = Vector(10,0,25),
                    params =
                    {  
                        {
                            name = "Weight" ,
                            type = "edit_number",
                            param = "bodyweight",
                            min = 0.8,
                            max = 1.2
                        },
                        {
                            name = "Height" ,
                            type = "edit_number",
                            param = "height",
                            min = -0.5,
                            max = 0.2
                        },
                        {
                            name = "Coat color" ,
                            type = "edit_color",
                            param = "coatcolor"
                        },  
                        {
                            name = "Coat layers" ,
                            type = "edit_layers",
                            path = "materials/models/mlp/body/",--.png'", 
                            params = {
                                { type = "bodymask1", color = "bodymask1_c"},
                                { type = "bodymask2", color = "bodymask2_c"},
                                { type = "bodymask3", color = "bodymask3_c"},
                                { type = "bodymask4", color = "bodymask4_c"},
                                { type = "bodymask5", color = "bodymask5_c"},
                                { type = "bodymask6", color = "bodymask6_c"},
                                { type = "bodymask7", color = "bodymask7_c"},
                                { type = "bodymask8", color = "bodymask8_c"},
                                { type = "bodymask9", color = "bodymask9_c"},
                            }
                        }
                    },
                },

                horn = {
                    name = "Horn" , 
                    bone = "LrigScull",
                    pos = Vector(6,0,12), 
                    racial = true,
                    params = {  
                        {
                            name = "Color" ,
                            type = "edit_color",
                            param = "horncolor"
                        },  
                    } 
                },
                uppermane = {
                    name = "Uppermane" , 
                    bone = "LrigScull", 
                    pos = Vector(15,0,55)-Vector(12,0,43),
                    params = {
                        {
                            name = "Mane Upper" ,
                            type = "edit_type",
                            param = "mane",
                        }, 
                        {
                            name = "Mane Upper" ,
                            type = "edit_part",
                            param = "uppermane", 
                        }, 
                        {
                            name = "Size" ,
                            type = "edit_number", 
                            param = "umanesize",
                            min = 0.5,
                            max = 1.5
                        }, 
                        {
                            name = "Color 1" ,
                            type = "edit_color",
                            param = "haircolor1"
                        }, 
                        {
                            name = "Color 2" ,
                            type = "edit_color",
                            param = "haircolor2"
                        }, 
                        {
                            name = "Color 3" ,
                            type = "edit_color",
                            param = "haircolor3"
                        }, 
                        {
                            name = "Color 4" ,
                            type = "edit_color",
                            param = "haircolor4"
                        }, 
                        {
                            name = "Color 5" ,
                            type = "edit_color",
                            param = "haircolor5"
                        }, 
                        {
                            name = "Color 6" ,
                            type = "edit_color",
                            param = "haircolor6"
                        }
                    } 
                },
                
                
                lowermane = {
                    name = "Lowermane" ,
                    bone = "LrigScull", 
                    pos = Vector(5,0,40)-Vector(12,0,43),
                    params = {
                        {
                            name = "Lower mane" ,
                            type = "edit_part",
                            param = "lowermane", 
                        }, 
                        {
                            name = "Size" ,
                            type = "edit_number", 
                            param = "lmanesize",
                            min = 0.5,
                            max = 1.5
                        }, 
                        {
                            name = "Color 1" ,
                            type = "edit_color",
                            param = "haircolor1"
                        }, 
                        {
                            name = "Color 2" ,
                            type = "edit_color",
                            param = "haircolor2"
                        }, 
                        {
                            name = "Color 3" ,
                            type = "edit_color",
                            param = "haircolor3"
                        }, 
                        {
                            name = "Color 4" ,
                            type = "edit_color",
                            param = "haircolor4"
                        }, 
                        {
                            name = "Color 5" ,
                            type = "edit_color",
                            param = "haircolor5"
                        }, 
                        {
                            name = "Color 6" ,
                            type = "edit_color",
                            param = "haircolor6"
                        }
                    } 
                },
                tail = {
                    name = "Tail" ,
                    pos = Vector(-22,0,34),
                    params = {
                        {
                            name = "Tail" ,
                            type = "edit_part",
                            param = "tail", 
                        }, 
                        {
                            name = "Size" ,
                            type = "edit_number", 
                            param = "tailsize",
                            min = 0.5,
                            max = 1.5
                        }, 
                        {
                            name = "Color 1" ,
                            type = "edit_color",
                            param = "haircolor1"
                        }, 
                        {
                            name = "Color 2" ,
                            type = "edit_color",
                            param = "haircolor2"
                        }, 
                        {
                            name = "Color 3" ,
                            type = "edit_color",
                            param = "haircolor3"
                        }, 
                        {
                            name = "Color 4" ,
                            type = "edit_color",
                            param = "haircolor4"
                        }, 
                        {
                            name = "Color 5" ,
                            type = "edit_color",
                            param = "haircolor5"
                        }, 
                        {
                            name = "Color 6" ,
                            type = "edit_color",
                            param = "haircolor6"
                        }
                    } 
                }, 
            }
        },
        head = {
            name = "Face" ,
            bone = "LrigScull",
            pos = Vector(15,0,40)-Vector(12,0,40),
            fov = 30,
            Parts = {
                eyes = {
                    name = "Eyes" , 
                    bone = "LrigScull",
                    pos = Vector(15,-5,40)-Vector(12,0,40),
                    params = {
                        {
                            name = "Form" ,
                            type = "edit_number",
                            param = "eye_form",
                            min = 0,
                            max = 1
                        }, 
                        {
                            name = "Evilness" ,
                            type = "edit_number",
                            param = "eye_form2",
                            min = 0,
                            max = 1
                        },  
                        {
                            name = "Heterochromia" ,
                            type = "edit_bool",
                            param = "heterochromia", 
                        }, 
                        {
                            name = "Back color" ,
                            type = "edit_color",
                            param = "eyecolor_bg"
                        }, 
                        {
                            name = "Iris size" ,
                            type = "edit_number",
                            param = "eyeirissize",
                            min = 0.2,
                            max = 2
                        },
                        {
                            name = "Iris color" ,
                            type = "edit_color",
                            param = "eyecolor_iris"
                        }, 
                        {
                            name = "Iris color 2" ,
                            type = "edit_color",
                            param = "eyecolor_grad"
                        },  
                        {
                            name = "Line 1 color" ,
                            type = "edit_color",
                            param = "eyecolor_line1"
                        }, 
                        {
                            name = "Line 2 color" ,
                            type = "edit_color",
                            param = "eyecolor_line2"
                        },  
                        {
                            name = "Pupil size" ,
                            type = "edit_number",
                            param = "eyeholesize",
                            min = 0.3,
                            max = 1
                        }, 
                        {
                            name = "Pupil width" ,
                            type = "edit_number",
                            param = "eyejholerssize",
                            min = 0.2,
                            max = 1
                        },
                        {
                            name = "Pupil color" ,
                            type = "edit_color",
                            param = "eyecolor_hole"
                        }, 
                        {
                            name = "Effects" ,
                            type = "edit_color",
                            param = "eyecolor_effects"
                        }, 
                    }
                },
                
                eyes2 = {
                    name = "Left Eye" , 
                    bone = "LrigScull",
                    enabled = "$heterochromia",
                    pos = Vector(15,5,40)-Vector(12,0,40),
                    params = { 
                        {
                            name = "Back color" ,
                            type = "edit_color",
                            param = "eye2color_bg"
                        },  
                        {
                            name = "Iris color" ,
                            type = "edit_color",
                            param = "eye2color_iris"
                        }, 
                        {
                            name = "Iris color 2" ,
                            type = "edit_color",
                            param = "eye2color_grad"
                        },  
                        {
                            name = "Line 1 color" ,
                            type = "edit_color",
                            param = "eye2color_line1"
                        }, 
                        {
                            name = "Line 2 color" ,
                            type = "edit_color",
                            param = "eye2color_line2"
                        },   
                        {
                            name = "Pupil color" ,
                            type = "edit_color",
                            param = "eye2color_hole"
                        }, 
                        {
                            name = "Effects" ,
                            type = "edit_color",
                            param = "eye2color_effects"
                        }, 
                    }
                },
                
                eyelashes = {
                    name = "Eyelashes" , 
                    bone = "LrigScull",
                    pos = Vector(12,7,45)-Vector(12,0,40), 
                    params = {
                        { 
                            name = "Type" ,
                            type = "edit_skin",
                            param = "eyelashes_type",
                            choices = {
                                { name = "Both", val = 0 },
                                { name = "Bottom", val = 1 },
                                { name = "Top", val = 2 },
                                { name = "none", val = 3 },
                            }
                        },  
                        {
                            name = "Rotation" ,
                            type = "edit_number",
                            param = "eyelash_form",
                            min = 0,
                            max = 1
                        }, 
                        {
                            name = "Color" ,
                            type = "edit_color",
                            param = "eyelashes_color"
                        },  
                        {
                            name = "Eyeliner" ,
                            type = "edit_color",
                            param = "eyeliner"
                        },  
                        {
                            name = "Eyeshadow" ,
                            type = "edit_color",
                            param = "eyeshadow"
                        },   
                    }
                },
                 
            }
        }

    } 
})
