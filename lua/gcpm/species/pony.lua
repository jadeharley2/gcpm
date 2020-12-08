
gcpm.AddSpecies("pony",{
    PrintName = "Pony",
    Directory = "mlp/pony_default",
    Models = {"player_default_base.mdl"},
    PartsDirectory = "mlp/pony_default/parts",
    Parts = {
        ears = {
            variants = {
                head_01_ears={model="head_01_ears.mdl"}
            }
        },
        wings = {
            variants = {
                head_01_ears={model="head_01_ears.mdl"}
            }
        },
        horn = {
            variants = {
                horn_01={model="horn_01.mdl"}
            }
        },
        uppermane = {
            variants = {
                uppermane_01={model="uppermane_01.mdl"}
            }
        },
        lowermane = {
            variants = {
                lowermane_01={model="lowermane_01.mdl"}
            }
        },
        tail = {
            variants = {
                tail_01={model="tail_01.mdl"}
            }
        },
    },
    Races = {
        earth = {
            name = "Earth pony",
            Parts = {}
        },
        pegasus = {
            name = "Pegasus",
            Parts = {
                wings = {model="wings_01_folded.mdl"},
            }
        },
        unicorn = {
            name = "Unicorn",
            Parts = {
                horn = {model="horn_01.mdl"},
            }
        },
        alicorn = {
            name = "Alicorn",
            Parts = {
                horn = {model="horn_01.mdl.mdl"},
                wings = {model="wings_01_folded.mdl"},
            }
        }
    },
    Parts = {
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
                    variants = {
                        ["DERPY"]      = {model="uppermane_01"},
                        ["BON BON"]    = {model="uppermane_02"},
                        ["LYRA"]       = {model="uppermane_03"},
                        ["TRIXIE"]     = {model="uppermane_04"},
                        ["FLUTTERSHY"] = {model="uppermane_05"},
                        ["MANE6"]      = {model="uppermane_06"},
                        ["MANE7"]      = {model="uppermane_07"},
                        ["RAINBOW"]    = {model="uppermane_08"},
                        ["VINYL"]      = {model="uppermane_09"},
                        ["HOOVES"]     = {model="uppermane_10"},
                        ["TWILIGHT"]   = {model="uppermane_11"},
                        ["APPLEJACK"]  = {model="uppermane_12"},
                        ["PINKIE"]     = {model="uppermane_13"},
                        ["RARITY"]     = {model="uppermane_14"},
                        ["SPITFIRE"]   = {model="uppermane_15"}, 
                    },
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
                    variants = {
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
                    },
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
                    variants = {
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
                    },
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
player_manager.AddValidModel( "ponytest", "models/mlp/pony_default/player_default_base.mdl" )   
player_manager.AddValidHands("ponytest","models/mlp/v_hoofs.mdl", 0, "00000000") 
if CLIENT then
    list.Set( "PlayerOptionsModel", "ponytest", "models/mlp/pony_default/player_default_base.mdl" )
end