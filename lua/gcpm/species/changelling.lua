--[[

{model="x"} -- body part


]]
gcpm.AddSpecies("changelling",{
    PrintName = "Changelling",
    Directory = "models/mlp/pony_default",
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
                Body = 2,
                Cmark = 1
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
    PartsDirectory = "models/mlp/pony_default/parts",
    Parts = {
        ears = {
            variants = {
                chang_ears={model="chang_ears.mdl"}
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
                changhorn_01={model="changhorn_01.mdl"}
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
            pos = Vector(10,0,20),
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
            pos = Vector(15,-5,40),
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
