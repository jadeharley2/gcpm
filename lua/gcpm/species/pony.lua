--[[

{model="x"} -- body part


]]
gcpm.AddSpecies("pony",{
    PrintName = "Pony",
    Directory = "models/mlp/pony_default",
    pos = Vector(0,0,20),
    --all variables exept parts
    Parameters = {
        coatcolor  = {type="color",name="Coat color",default = Color(255,255,255)},
        haircolor1 = {type="color",name="Color 1",default = Color(255,0,0)},
        haircolor2 = {type="color",name="Color 2",default = Color(0,255,0)},
        haircolor3 = {type="color",name="Color 3",default = Color(0,0,255)},
        haircolor4 = {type="color",name="Color 4",default = Color(255,255,0)},
        haircolor5 = {type="color",name="Color 5",default = Color(0,255,255)},
        haircolor6 = {type="color",name="Color 6",default = Color(255,0,255)},
        
        horncolor =  {type="color",name="Horn Color",default = Color(150,150,150)},

        bodyweight  = {type="number",default = 1,min=0.8,max=1.2},
        tailsize    = {type="number",default = 1,min=0.5,max=1.5},
        lmanesize   = {type="number",default = 1,min=0.5,max=1.5},
        umanesize   = {type="number",default = 1,min=0.5,max=1.5},
        
        eyecolor_bg = {type="color",default = Color(255,255,255)},
        eyecolor_hole = {type="color",default = Color(0,0,0)},
        eyecolor_iris = {type="color",default = Color(150,150,150)},
        eyecolor_grad = {type="color",default = Color(255,150,150)},
        eyecolor_line1 = {type="color",default = Color(150,255,150)}, 
        eyecolor_line2 = {type="color",default = Color(150,150,255)},
        eyeirissize = {type="number",default = 0.6},
        eyehaslines = {type="bool",default = true}, 
        eyeholesize = {type="number",default = 0.7},
        eyejholerssize = {type="number",default = 1},

        eyelashes_type = {type="number",default = 0},
        eyelashes_color = {type="color",name="Horn Color",default = Color(10,10,10)},

        eyeshadow =  {type="color",default = Color(150,150,255)},
        eyeliner =   {type="color",default = Color(150,150,255)},
        lips    =   {type="color",default = Color(150,150,255)},
        
        head_form_0 = {type="number",default = 0,min=0,max=1},
        eye_form = {type="number",default = 0,min=0,max=1},
        eyelash_form = {type="number",default = 0,min=0,max=1},
 
        bodymask1   = {type="string",default="none"},
        bodymask2   = {type="string",default="none"},
        bodymask3   = {type="string",default="none"},
        bodymask4   = {type="string",default="none"},
        bodymask5   = {type="string",default="none"},
        bodymask6   = {type="string",default="none"}, 
        bodymask1_c = {type="color",name="Mask 1 Color",default = Color(255,0,0)},
        bodymask2_c = {type="color",name="Mask 2 Color",default = Color(255,0,0)},
        bodymask3_c = {type="color",name="Mask 3 Color",default = Color(255,0,0)},
        bodymask4_c = {type="color",name="Mask 4 Color",default = Color(255,0,0)},
        bodymask5_c = {type="color",name="Mask 5 Color",default = Color(255,0,0)},
        bodymask6_c = {type="color",name="Mask 6 Color",default = Color(255,0,0)},
    },
    MaterialBase = { 
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
    Materials = {
        mouth = {}, 
        body = {
            params = {
                ["$basetexture"] = "models/mlp/base/body",
        
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
            procedural = true
        },
        eyel = {
            ["$Iris"]      =         "models/mlp/base/face/p_luna",
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
    
    
            ["$eyeorigin"] =Vector(0, 0, 0)  ,
            ["$irisu"] ="[0 1 0 0]",
            ["$irisv"] ="[0 0 1 0]",
            ["$Entityorigin"] =4.0 , 
        },
        eyer = {
            ["$Iris"]      =         "models/mlp/base/face/p_luna",
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
    
    
            ["$eyeorigin"] =Vector(0, 0, 0)  ,
            ["$irisu"] ="[0 1 0 0]",
            ["$irisv"] ="[0 0 1 0]",
            ["$Entityorigin"] =4.0 , 
        }, 
        cmark = {
            ["$basetexture"] = "models/mlp/cmarks/rarity",
    
            ["$translucent"] = 1, 
            ["$phong"] = 1, 
            ["$phongexponent"] = 6,
            ["$phongboost"] = 0.05,
            ["$phongalbedotint"] = 1,
            ["$phongtint"] = Vector(1,0.95,0.95),
            ["$phongfresnelranges"] =	Vector(0.5,6,10),
            
            ["$rimlight"] =                1,
            ["$rimlightexponent"] =        2,
            ["$rimlightboost"] =           1 ,
        },

        horn = {
            ["$basetexture"] = "models/mlp/base/horn",
     
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
        wings = { 
            ["$basetexture"] = "models/mlp/base/wings",
    
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
        uppermane = {
            procedural = true,
            mode = "part_layers",
            params = {
                ["$basetexture"] = "models/mlp/base/wings",
        
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
            }
        },
        lowermane = {
            ["$basetexture"] = "models/mlp/base/wings",
    
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
        tail = {
            ["$basetexture"] = "models/mlp/base/wings",
    
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
    },
    Models = {
        {
            File = "player_default_base.mdl",
            Bodygroups = {
                Body = 0
            },
            Materials = { 
                mouth = 0,
                body = 1,
                eyel = 2,
                eyer = 3, 
                cmark = 8, 
            }
        } 
    },
    PartsDirectory = "models/mlp/pony_default/parts",
    Body = {
        skin = "eyelashes_type",
        materials = {
            {},
            {--body
                mode = "procedural",  
                layers = {
                    {
                        texture = "models/mlp/base/body.png",
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
            {--lefteye
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
                        enabled = "$eyehaslines",
                        texture = "models/mlp/partrender/eye_line_r2.png",
                        color = "$eyecolor_line2",
                        w = "$eyeirissize",
                        h = "$eyeirissize",
                    },
                    {
                        enabled = "$eyehaslines",
                        texture = "models/mlp/partrender/eye_line_r1.png",
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
                        color = Color(255,255,255),
                        w = "$eyeirissize",
                        h = "$eyeirissize",
                    },
                    {
                        texture = "models/mlp/partrender/eye_reflection.png",
                        color = Color(255,255,255),
                        w = "$eyeirissize",
                        h = "$eyeirissize",
                    },
                } 
            },
            {--righteye
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
                        enabled = "$eyehaslines",
                        texture = "models/mlp/partrender/eye_line_l2.png",
                        color = "$eyecolor_line2",
                        w = "$eyeirissize",
                        h = "$eyeirissize",
                    },
                    {
                        enabled = "$eyehaslines",
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
                        color = Color(255,255,255),
                        w = "$eyeirissize",
                        h = "$eyeirissize",
                    },
                    {
                        texture = "models/mlp/partrender/eye_reflection.png",
                        color = Color(255,255,255),
                        w = "$eyeirissize",
                        h = "$eyeirissize",
                    },
                } 
            },  
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
            eyelashesturn = "eyelash_form"
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
            },
            modifiers = {

            }
        }
    },
    Parts = {
        ears = { 
            material = "body",
            variants = {
                head_01_ears={
                    model="head_01_ears.mdl",
                    material = {mode = "color", texture = "models/mlp/base/body", params = "coatcolor"}
                }
            }
        },
        wings = { 
            material = "wings",
            variants = {
                none = {},
                wings_01={
                    model="wings_01_folded.mdl",
                    material = {mode = "color", params = "coatcolor"}
                }
            }
        },
        horn = { 
            material = "horn",
            variants = {
                none = {},
                horn_01={
                    model="horn_01.mdl", 
                    material = {
                        mode = "procedural", 
                        clear = "$coatcolor",
                        layers = {
                            {
                                texture = "models/mlp/parts/horn.png",
                                color = "$horncolor"
                            }
                        } 
                    }
                }
            }
        },
        uppermane = {
            basematerial = "uppermane", 
            variants = {
                none = {}, 
                ["DERPY"]      = {
                    model="uppermane_01",
                    material = {mode = "color", params = "haircolor1"}
                },
                ["BON BON"]    = {
                    model="uppermane_02",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },
                ["LYRA"]       = {
                    model="uppermane_03",
                    material = {
                        mode = "color", 
                        params = {"haircolor1","haircolor2"}
                    }
                },
                ["TRIXIE"]     = {
                    model="uppermane_04",
                    material = {
                        mode = "color", 
                        params = {"haircolor1","haircolor2"}
                    }
                },
                ["FLUTTERSHY"] = {
                    model="uppermane_05",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_5_mask0.png",
                                color = "$haircolor2"
                            }
                        } 
                    }
                },
                ["MANE6"]      = {
                    model="uppermane_06",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_6_mask0.png",
                                color = "$haircolor2"
                            }
                        } 
                    } 
                },
                ["MANE7"]      = {
                    model="uppermane_07",
                    material = {mode = "color", params = "haircolor1"}
                },
                ["RAINBOW"]    = {
                    model="uppermane_08",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_8_mask0.png",
                                color = "$haircolor2"
                            },
                            {
                                texture = "models/mlp/partrender/upmane_8_mask1.png",
                                color = "$haircolor3"
                            }
                        } 
                    }  
                },
                ["VINYL"]      = {
                    model="uppermane_09",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_9_mask0.png",
                                color = "$haircolor2"
                            },
                            {
                                texture = "models/mlp/partrender/upmane_9_mask1.png",
                                color = "$haircolor3"
                            },
                            {
                                texture = "models/mlp/partrender/upmane_9_mask2.png",
                                color = "$haircolor4"
                            }
                        } 
                    }   
                },
                ["HOOVES"]     = {
                    model="uppermane_10",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_10_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },
                ["TWILIGHT"]   = {
                    model="uppermane_11",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_11_mask0.png",
                                color = "$haircolor2"
                            },
                            {
                                texture = "models/mlp/partrender/upmane_11_mask1.png",
                                color = "$haircolor3"
                            },
                            {
                                texture = "models/mlp/partrender/upmane_11_mask2.png",
                                color = "$haircolor4"
                            }
                        } 
                    }   
                },
                ["APPLEJACK"]  = {
                    model="uppermane_12",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_12_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },
                ["PINKIE"]     = {
                    model="uppermane_13",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_13_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },
                ["RARITY"]     = {
                    model="uppermane_14",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_14_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },
                ["SPITFIRE"]   = {
                    model="uppermane_15",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/upmane_15_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                }, 
            }
        },
        lowermane = {
            variants = {
                none = {},
                ["DERPY"]      = {
                    model="lowermane_01",
                    material = {mode = "color", params = "haircolor1"}
                },
                ["BON BON"]      = {
                    model="lowermane_02",
                    material = {mode = "color", params = "haircolor2"}
                },
                ["LYRA"]      = {
                    model="lowermane_03",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },
                ["TRIXIE"]      = {
                    model="lowermane_04",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                }, 
                ["FLUTTERSHY"]   = {
                    model="lowermane_05",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/dnmane_5_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },  
                ["MANE6"]      = {
                    model="lowermane_06",
                    material = {mode = "color", params = "haircolor2"}
                }, 
                ["MANE7"]      = {
                    model="lowermane_07",
                    material = {mode = "color", params = "haircolor2"}
                },  
                ["RD SHORT"]   = {
                    model="lowermane_08",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor4",
                        layers = {
                            {
                                texture = "models/mlp/partrender/dnmane_8_mask0.png",
                                color = "$haircolor5"
                            }, 
                            {
                                texture = "models/mlp/partrender/dnmane_8_mask1.png",
                                color = "$haircolor6"
                            }, 
                        } 
                    }   
                }, 
                ["RAINBOW"]   = {
                    model="lowermane_09",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor4",
                        layers = {
                            {
                                texture = "models/mlp/partrender/dnmane_9_mask0.png",
                                color = "$haircolor5"
                            }, 
                            {
                                texture = "models/mlp/partrender/dnmane_9_mask1.png",
                                color = "$haircolor6"
                            }, 
                        } 
                    }   
                },  
                ["TWILIGHT"]   = {
                    model="lowermane_10",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/dnmane_10_mask0.png",
                                color = "$haircolor2"
                            }, 
                            {
                                texture = "models/mlp/partrender/dnmane_10_mask1.png",
                                color = "$haircolor3"
                            }, 
                            {
                                texture = "models/mlp/partrender/dnmane_10_mask2.png",
                                color = "$haircolor4"
                            }, 
                        } 
                    }   
                },  
                ["APPLEJACK"]   = {
                    model="lowermane_11",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/dnmane_11_mask0.png",
                                color = "$haircolor2"
                            },  
                        } 
                    }   
                },   
                ["RARITY"]   = {
                    model="lowermane_12",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/dnmane_12_mask0.png",
                                color = "$haircolor2"
                            },  
                        } 
                    }   
                },    
               -- ["MANE13"]     =  {model="lowermane_13"},
               -- ["MANE14"]     =  {model="lowermane_14"},
            }
        },
        tail = {
            variants = {
                none = {},
                ["DERPY"]      = {
                    model="tail_01",
                    material = {mode = "color", params = "haircolor1"}
                },
                ["BON BON"]      = {
                    model="tail_02",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },
                ["LYRA"]      = {
                    model="tail_03",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },
                ["TRIXIE"]      = {
                    model="tail_04",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                }, 
                ["FLUTTERSHY"]   = {
                    model="tail_05",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_5_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },   
                ["MANE6"]      = {
                    model="tail_06",
                    material = {mode = "color", params = "haircolor1"}
                }, 
                ["MANE7"]      = {
                    model="tail_07",
                    material = {mode = "color", params = "haircolor1"}
                },  
                ["RAINBOW"]   = {
                    model="tail_08",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_8_mask0.png",
                                color = "$haircolor2"
                            }, 
                            {
                                texture = "models/mlp/partrender/tail_8_mask1.png",
                                color = "$haircolor3"
                            }, 
                            {
                                texture = "models/mlp/partrender/tail_8_mask2.png",
                                color = "$haircolor4"
                            }, 
                            {
                                texture = "models/mlp/partrender/tail_8_mask3.png",
                                color = "$haircolor5"
                            }, 
                            {
                                texture = "models/mlp/partrender/tail_8_mask4.png",
                                color = "$haircolor6"
                            }, 
                        } 
                    }   
                },  
                ["TAIL9"]      = {
                    model="tail_09",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },  
                ["TAIL10"]   = {
                    model="tail_10",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_10_mask0.png",
                                color = "$haircolor2"
                            }, 
                        } 
                    }   
                },   
                ["TWILIGHT"]   = {
                    model="tail_11",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_11_mask0.png",
                                color = "$haircolor2"
                            }, 
                            {
                                texture = "models/mlp/partrender/tail_11_mask1.png",
                                color = "$haircolor2"
                            }, 
                            {
                                texture = "models/mlp/partrender/tail_11_mask2.png",
                                color = "$haircolor3"
                            }, 
                        } 
                    }   
                },   
                ["APPLEJACK"]   = {
                    model="tail_12",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_12_mask0.png",
                                color = "$haircolor2"
                            },  
                        } 
                    }   
                },  
                ["PINKIE"]   = {
                    model="tail_13",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_13_mask0.png",
                                color = "$haircolor2"
                            },  
                        } 
                    }   
                },   
                ["RARITY"]   = {
                    model="tail_14",
                    material = {
                        mode = "procedural", 
                        clear = "$haircolor1",
                        layers = {
                            {
                                texture = "models/mlp/partrender/tail_14_mask0.png",
                                color = "$haircolor2"
                            },  
                        } 
                    }   
                },    
            }
        }, 
    },
    Races = {
        earth = {
            name = "Earth",
            Parts = {
                ears = { whitelist = {"head_01_ears"} },
            }
        },
        pegasus = {
            name = "Pegasus",
            Parts = { 
                ears = { whitelist = {"head_01_ears"} },
                wings = { whitelist = {"wings_01"} }
            }
        },
        batpony = {
            name = "Bat",
            Parts = {
                ears = { whitelist = {"head_01_ears"} },
                wings = { whitelist = {"wings_01"} }
            }
        },
        unicorn = {
            name = "Unicorn",
            Parts = {
                ears = { whitelist = {"head_01_ears"} },
                horn = { whitelist = {"horn_01"} },
            }
        },
        alicorn = {
            name = "Alicorn",
            Parts = {
                ears = { whitelist = {"head_01_ears"} },
                horn = { whitelist = {"horn_01"} },
                wings = { whitelist = {"wings_01"} }
            }
        }
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
                            name = "Coat color" ,
                            type = "edit_color",
                            param = "coatcolor"
                        }
                    },
                },
                
                horn = {
                    name = "Horn" , 
                    pos = Vector(18,0,55),
                    params = { 
                       -- {
                       --     name = "Mane Upper" ,
                       --     type = "edit_part",
                       --     param = "uppermane", 
                       -- }, 
                        {
                            name = "Color" ,
                            type = "edit_color",
                            param = "horncolor"
                        },  
                    } 
                },
                uppermane = {
                    name = "Uppermane" , 
                    pos = Vector(7,0,55),
                    params = { 
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
                    pos = Vector(5,0,40),
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
                cutiemark = {
                    name = "Cutiemark",
                    pos = Vector(-8,6,27),
                    params = {
                        {
                            name = "View" ,
                            type = "view_cmark" 
                        },
                        {
                            name = "No cutiemark" ,
                            type = "edit_bool",
                            param = "cmark_enabled",
                            onvalue = 2,
                            offvalue = 1
                        }, 
                        {
                            name = "Cutiemark",
                            type = "edit_cmark"
                        },
                        {
                            name = "Custom cutiemark" ,
                            type = "select_custom_cmark"
                        },
                        {
                            name = "Cutiemark",
                            type = "edit_type",
                            param = "cmark",
                            choices =
                            {
                                    "bon bon", "lyra", "fluttershy",
                                    "trixie", "celestia", "applej"
                                    ,"derpy" ,"drops" ,"cloudy"
                                    ,"time" ,"sflowers" ,"twilight"
                                    ,"rosen" ,"zecora" ,"mine"
                                    ,"island" ,"firezap" ,"applem"
                                    ,"pankk" ,"storm" ,"fan"
                                    ,"rainbow dash" ,"time2" ,"carrots"
                                    ,"fruits" ,"note" ,"pinkie_pie"
                                    ,"rarity" ,"octavia" ,"custom01" 
                                    ,"custom02" 
                            }
                        }
                    }
                },
                markings = {

                },
            }
        },
        head = {
            name = "Face" ,
            pos = Vector(15,0,40),
            fov = 30,
            Parts = {
                eyes = {
                    name = "Eyes" , 
                    pos = Vector(15,-5,40),
                    params = {
                        {
                            name = "Form" ,
                            type = "edit_number",
                            param = "eye_form",
                            min = 0,
                            max = 1
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
                            name = "No lines" ,
                            type = "edit_bool",
                            param = "eyehaslines",
                            onvalue = 2,
                            offvalue = 1
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
                    }
                },
                
                eyelashes = {
                    name = "Eyelashes" , 
                    pos = Vector(12,7,45), 
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
                
                mouth = {
                    name = "Mouth" , 
                    pos = Vector(20,0,38),
                    params = { 
                        {
                            name = "Form" ,
                            type = "edit_number",
                            param = "head_form_0",
                            min = 0,
                            max = 1
                        }, 
                        {
                            name = "Lips" ,
                            type = "edit_color",
                            param = "lips"
                        }, 
                    }
                }
            }
        }

    } 
})
player_manager.AddValidModel( "ponytest", "models/mlp/pony_default/player_default_base.mdl" )   
player_manager.AddValidHands("ponytest","models/mlp/v_hoofs.mdl", 0, "00000000") 
if CLIENT then
    list.Set( "PlayerOptionsModel", "ponytest", "models/mlp/pony_default/player_default_base.mdl" )
end