--[[

{model="x"} -- body part


]]
gcpm.AddSpecies("pony",{
    PrintName = "Pony",
    Directory = "models/mlp/pony_default",
    pos = Vector(0,0,20),
    Parameters = {
        coatcolor  = {type="color",name="Coat color"},
        haircolor1 = {type="color",name="Color 1"},
        haircolor2 = {type="color",name="Color 2"},
        haircolor3 = {type="color",name="Color 3"},
        haircolor4 = {type="color",name="Color 4"},
        haircolor5 = {type="color",name="Color 5"},
        haircolor6 = {type="color",name="Color 6"},
    },
    Materials = {
        mouth = {},
        body = {
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
    Parts = {
        ears = {
            variants = {
                head_01_ears={model="head_01_ears.mdl"}
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
                horn_01={model="horn_01.mdl"}
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
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },
                ["TRIXIE"]     = {
                    model="uppermane_04",
                    material = {mode = "color", params = {"haircolor1","haircolor2"}}
                },
                ["FLUTTERSHY"] = {
                    model="uppermane_05",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                },
                ["MANE6"]      = {
                    model="uppermane_06",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                },
                ["MANE7"]      = {
                    model="uppermane_07",
                    material = {mode = "color", params = "haircolor1"}
                },
                ["RAINBOW"]    = {
                    model="uppermane_08",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2","haircolor3"}}
                },
                ["VINYL"]      = {
                    model="uppermane_09",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2","haircolor3","haircolor4"}}
                },
                ["HOOVES"]     = {
                    model="uppermane_10",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                },
                ["TWILIGHT"]   = {
                    model="uppermane_11",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2","haircolor3","haircolor4"}}
                },
                ["APPLEJACK"]  = {
                    model="uppermane_12",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                },
                ["PINKIE"]     = {
                    model="uppermane_13",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                },
                ["RARITY"]     = {
                    model="uppermane_14",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                },
                ["SPITFIRE"]   = {
                    model="uppermane_15",
                    material = {mode = "layers", params =  {"haircolor1","haircolor2"}}
                }, 
            }
        },
        lowermane = {
            variants = {
                none = {},
                ["DERPY"]      =  {model="lowermane_01"},
                ["BON BON"]    =  {model="lowermane_02"},
                ["LYRA"]       =  {model="lowermane_03"},
                ["TRIXIE"]     =  {model="lowermane_04"},
                ["FLUTTERSHY"] =  {model="lowermane_05"},
                ["MANE6"]      =  {model="lowermane_06"},
                ["MANE7"]      =  {model="lowermane_07"},
                ["RD SHORT"]   =  {model="lowermane_08"},
                ["RAINBOW"]    =  {model="lowermane_09"},
                ["TWILIGHT"]   =  {model="lowermane_10"},
                ["APPLEJACK"]  =  {model="lowermane_11"},
                ["RARITY"]     =  {model="lowermane_12"},
                ["MANE13"]     =  {model="lowermane_13"},
                ["MANE14"]     =  {model="lowermane_14"},
            }
        },
        tail = {
            variants = {
                none = {},
                ["DERPY"]      = {model="lowermane_01"},
                ["BON BON"]    = {model="lowermane_02"},
                ["LYRA"]       = {model="lowermane_03"},
                ["TRIXIE"]     = {model="lowermane_04"},
                ["FLUTTERSHY"] = {model="lowermane_05"},
                ["MANE6"]      = {model="lowermane_06"},
                ["MANE7"]      = {model="lowermane_07"},
                ["RAINBOW"]    = {model="lowermane_08"},
                ["TAIL9"]      = {model="lowermane_09"},
                ["TAIL10"]     = {model="lowermane_10"},
                ["TWILIGHT"]   = {model="lowermane_11"},
                ["APPLEJACK"]  = {model="lowermane_12"},
                ["PINKIE"]     = {model="lowermane_13"},
                ["RARITY"]     = {model="lowermane_14"},
            }
        }, 
    },
    Races = {
        earth = {
            name = "Earth",
            Parts = {
                ears = {model="head_01_ears.mdl"},
            }
        },
        pegasus = {
            name = "Pegasus",
            Parts = {
                ears = {model="head_01_ears.mdl"},
                wings = {model="wings_01_folded.mdl"},
            }
        },
        batpony = {
            name = "Bat",
            Parts = {
                ears = {model="head_01_ears.mdl"},
                wings = {model="wings_01_folded.mdl"},
            }
        },
        unicorn = {
            name = "Unicorn",
            Parts = {
                ears = {model="head_01_ears.mdl"},
                horn = {model="horn_01.mdl"},
            }
        },
        alicorn = {
            name = "Alicorn",
            Parts = {
                ears = {model="head_01_ears.mdl"},
                horn = {model="horn_01.mdl"},
                wings = {model="wings_01_folded.mdl"},
            }
        }
    },
    Editor = {
        body = {
            name = "Body" ,
            pos = Vector(0,0,28),
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
            Parts = {
                uppermane = {
                    name = "Uppermane" , 
                    pos = Vector(18,0,55),
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
                            name = "Tail" ,
                            type = "edit_part",
                            param = "lowermane", 
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
                        tailsize = {
                            name = "Tail size" ,
                            type = "number", 
                            min = 0.8,
                            max = 1.1
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
            name = "Head" ,
            pos = Vector(15,0,40),
            fov = 30,
            Parts = {
                eyes = {
                    name = "Eyes" , 
                    pos = Vector(15,-5,40),
                    params = {
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