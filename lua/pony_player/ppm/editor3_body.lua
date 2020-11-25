 
 
PPM.Editor3_ponies =PPM.Editor3_ponies or {}
PPM.Editor3_ponies =
{ 
	pony = 
	{
		node_main = "node_main",
		node_body="pony_normal_body",
		node_face="pony_normal_face",
		node_equipment="pony_equipment",
		node_presets = "node_presets"
	},
	ponynj = 
	{
		node_main = "node_main",
		node_body="pony_normal_body",
		node_face="pony_normal_face",
		node_equipment="pony_equipment",
		node_presets = "node_presets"
	}
} 
 
PPM.Editor3_nodes =PPM.Editor3_nodes or {}
PPM.Editor3_nodes.node_main = 
{ 
	name = "OMG !ROOT NODE!" , 
	controlls =
	{ 
		{
			name = "Type",
			type = "edit_type",
			param = "kind",
			special = "maintype",
			choices =  
			{  "Earth","Pegasus","Unicorn","Alicorn" } 
		},
		//<-- age here
		{
			name = "Gender",
			type = "edit_type",
			param = "gender",
			special = "maintype",
			choices =  
			{  "Female","Male" }
		}
	} 
}
PPM.Editor3_nodes.node_presets = 
{
	name = "OMG !ROOT NODE!" , 
	controlls =
	{ 
		{
			name = "Type",
			type = "menu_save_load", 
		}
	} 
}
PPM.Editor3_nodes.pony_equipment = 
{ 
	name = "Equipment" ,  
	controlls = 
	{
		{
			name = "Head",
			type = "edit_equipment_slot",
			slotid = 0,  
		},
		{
			name = "Eyes",
			type = "edit_equipment_slot",
			slotid = 7,  
		},
		{
			name = "Neck",
			type = "edit_equipment_slot",
			slotid = 1,  
		},
		{
			name = "Front body",
			type = "edit_equipment_slot",
			slotid = 2,  
		},
		{
			name = "Front legs",
			type = "edit_equipment_slot",
			slotid = 3,  
		},
		{
			name = "Front hooves",
			type = "edit_equipment_slot",
			slotid = 5,  
		},
		{
			name = "Uniform",
			type = "edit_equipment_slot",
			slotid = 50,  
		},
		{
			name = "Back body",
			type = "edit_equipment_slot",
			slotid = 9,  
		},
		{
			name = "Hind legs",
			type = "edit_equipment_slot",
			slotid = 10,  
		},
		{
			name = "Hind hooves",
			type = "edit_equipment_slot",
			slotid = 12,  
		}
	} 
}
PPM.Editor3_nodes.pony_normal_face = 
{
eyelashes =
{
	name = "Eyelashes" , 
	pos = Vector(13,8,43.5),
	controlls = 
	{
		{
			name = "Type",
			type = "edit_type",
			param = "eyelash", 
			choices =  
			{ "Default","Double","Fluttershy","Full","Mess","None"} 
		}
	}
},
eyes = 
{
	name = "Eyes" , 
	pos = Vector(15,-5,40),
	controlls =
	{  
		/*
		{
			name = "View" ,
			type = "view_eye" 
		},
		*/
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
PPM.Editor3_nodes.pony_normal_body = 
{
body =
	{ 
		name = "Body" ,
		pos = Vector(10,0,20),
		controlls =
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
		}
	} ,
cutiemark =
	{
		name = "Cutiemark" ,
		pos = Vector(-8,6,27),
		controlls =
		{ 
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
				name = "Select custom cutiemark" ,
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
	} ,
tail =
	{
		name = "Tail" ,
		pos = Vector(-22,0,34),
		controlls =
		{ 
			{
				name = "Tail" ,
				type = "edit_type",
				param = "tail",
				choices =  
				{
					"DERPY","BON BON","LYRA","TRIXIE","FLUTTERSHY",
					"TAIL6","TAIL7","RAINBOW","TAIL9","TAIL10",
					"TWILIGHT","APPLEJACK","PINKIE","RARITY","NONE"
				}
			}, 
			{
				name = "Tail size" ,
				type = "edit_number",
				param = "tailsize",
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
	} ,
uppermane =
	{
		name = "Uppermane" ,
		pos = Vector(18,0,55),
		controlls =
		{ 
			{
				name = "Mane Upper" ,
				type = "edit_type",
				param = "mane",
				choices =  
				{
					"DERPY","BON BON","LYRA","TRIXIE","FLUTTERSHY",
					"MANE6","MANE7","RAINBOW","VINYL","HOOVES",
					"TWILIGHT","APPLEJACK","PINKIE","RARITY","SPITFIRE","NONE"
				}
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
	} ,
lowermane =
	{
		name = "Lowermane" ,
		pos = Vector(5,0,40),
		controlls =
		{ 
			{
				name = "Lower mane" ,
				type = "edit_type",
				param = "manel",
				choices =  
				{
					"DERPY","BON BON","LYRA","TRIXIE","FLUTTERSHY",
					"MANE6","MANE7","RD SHORT","RAINBOW","TWILIGHT",
					"APPLEJACK","RARITY","NONE"
				}
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
	} ,

/*
PPM.Editor3_nodes["face"] =
{
	pos = Vector(20,0,43)
} 
*/
}



for i=1,8 do
	local div = math.rad(i*(360/8))
	PPM.Editor3_nodes.pony_normal_body["bdetail"..i] = 
	{
		name = "B"..i ,
		pos = Vector(math.cos(div)*25,math.sin(div)*25,-5),
		controlls =
		{    
			{
				name = "Detail type" ,
				type = "edit_type",
				param = "bodydetail"..i,
				choices =  
				{
					"None",
					"Leg gradient","Lines","Stripes","Head stripes","Freckles",
					"Hooves big","Hooves small","Head layer","Hooves big rnd",
					"Hooves small rnd","Spots 1"
				}
			}, 
			{
				name = "Color" ,
				type = "edit_color",
				param = "bodydetail"..i.."_c"
			}
		}
	} 

end