if(CLIENT) then
	PPM.reservedPresetNames = {}
	function addPreset(name,code)
		//if(!file.Exists("ppm/"..name, "DATA")) then
			Save(name,code)
		PPM.reservedPresetNames[name] = name
		//MsgN(name)
		//end
	end
	function Save(filename,code) 
		if !file.Exists( "ppm", "DATA" ) then
			file.CreateDir( "ppm" )
		end
		//MsgN("creating preset .. ppm/"..filename)
		file.Write("ppm/"..filename,code) 
	end
	
	
	addPreset("rarity.txt","\n"..
	"age 2\n".. 
	"body_type 1\n".. 
	"bodyt0 1\n"..  
	"bodyweight 1\n".. 
	"cmark 28\n".. 
	"cmark_enabled 1\n".. 
	"coatcolor 0.913725 0.917647 0.925490\n".. 
	"eye 5\n"..  
	"eyecolor_iris 0.070588 0.223529 0.439216\n"..  
	"eyecolor_grad 0.223529 0.470588 0.733333\n".. 
	"eyecolor_line1 0.286275 0.501961 0.760784\n".. 
	"eyecolor_line2 0.411765 0.611765 0.827451\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"eyelash 4\n".. 
	"gender 1\n".. 
	"haircolor1 0.372549 0.345098 0.647059\n".. 
	"haircolor2 0.262745 0.145098 0.380392\n"..  
	"kind 3\n".. 
	"mane 14\n".. 
	"manel 12\n".. 
	"tail 14")
	
	addPreset("pinkie_pie.txt","\n"..
	"age 2\n".. 
	"body_type 1\n".. 
	"bodyt0 1\n"..  
	"bodyweight 1\n".. 
	"cmark 27\n".. 
	"cmark_enabled 1\n".. 
	"coatcolor 0.964706 0.717647 0.823529\n".. 
	"eye 5\n"..  
	"eyecolor_iris 0.152941 0.482353 0.631373\n"..  
	"eyecolor_grad 0.458824 0.784314 0.917647\n".. 
	"eyecolor_line1 0.701961 0.854902 0.921569\n".. 
	"eyecolor_line2 0.866667 0.941176 0.972549\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"eyelash 2\n".. 
	"gender 1\n".. 
	"haircolor1 0.929412 0.270588 0.552941\n".. 
	"haircolor2 0.745098 0.109804 0.478431\n"..  
	"kind 1\n".. 
	"mane 13\n".. 
	"manel 13\n".. 
	"tail 13")
	
	addPreset("applejack.txt","\n"..
	"age 2\n".. 
	"body_type 1\n".. 
	"bodyt0 1\n"..  
	"bodyweight 1\n".. 
	"bodydetail1 6\n".. 
	"bodydetail1_c 1.000000 1.000000 1.000000\n".. 
	"cmark 6\n".. 
	"cmark_enabled 1\n".. 
	"coatcolor 1.000000 0.752941 0.423529\n".. 
	"eye 8\n"..  
	"eyecolor_iris 0.188235 0.407843 0.117647\n"..  
	"eyecolor_grad 0.337255 0.666667 0.254902\n".. 
	"eyecolor_line1 0.450980 0.792157 0.384314\n".. 
	"eyecolor_line2 0.745098 0.909804 0.752941\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"eyelash 1\n".. 
	"gender 1\n".. 
	"haircolor1 0.984314 0.976471 0.690196\n".. 
	"haircolor2 0.925490 0.866667 0.419608\n".. 
	"haircolor3 0.976471 0.317647 0.321569\n"..  
	"kind 1\n".. 
	"mane 12\n".. 
	"manel 11\n".. 
	"tail 12")
	
	addPreset("twilight.txt","\n"..
	"age 2\n".. 
	"body_type 1\n".. 
	"bodyt0 1\n".. 
	"bodyt1 1\n".. 
	"bodyt1_color 0.650980 0.815686 0.972549\n".. 
	"bodyweight 1\n".. 
	"cmark 12\n".. 
	"cmark_enabled 1\n".. 
	"coatcolor 0.827451 0.705882 0.839216\n".. 
	"eye 6\n"..  
	"eyecolor_iris 0.141176 0.039216 0.254902\n"..  
	"eyecolor_grad 0.400000 0.184314 0.541176\n".. 
	"eyecolor_line1 0.584314 0.380392 0.658824\n".. 
	"eyecolor_line2 0.788235 0.666667 0.815686\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"eyelash 2\n".. 
	"gender 1\n".. 
	"haircolor1 0.243137 0.239216 0.447059\n".. 
	"haircolor2 0.015686 0.176471 0.325490\n".. 
	"haircolor3 0.439216 0.129412 0.505882\n".. 
	"haircolor4 0.913725 0.270588 0.541176\n".. 
	"haircolor5 0.000000 0.000000 0.000000\n".. 
	"haircolor6 0.000000 0.000000 0.000000\n".. 
	"kind 3\n".. 
	"mane 11\n".. 
	"manel 10\n".. 
	"tail 11")
	
	addPreset("rainbow_dash.txt","\n"..
	"age 2\n".. 
	"body_type 1\n".. 
	"bodyt0 1\n".. 
	"bodyt1 1\n".. 
	"bodyt1_color 0.650980 0.815686 0.972549\n".. 
	"bodyweight 1\n".. 
	"cmark 22\n".. 
	"cmark_enabled 1\n".. 
	"coatcolor 0.619608 0.858824 0.972549\n".. 
	"eye 4\n"..  
	"eyecolor_iris 0.266667 0.066667 0.156863\n"..  
	"eyecolor_grad 0.776471 0.105882 0.443137\n".. 
	"eyecolor_line1 0.850980 0.333333 0.627451\n".. 
	"eyecolor_line2 0.968627 0.721569 0.827451\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"gender 1\n".. 
	"haircolor1 0.937255 0.254902 0.211765\n".. 
	"haircolor2 0.956863 0.439216 0.196078\n".. 
	"haircolor3 1.000000 0.964706 0.592157\n".. 
	"haircolor4 0.478431 0.752941 0.262745\n".. 
	"haircolor5 0.101961 0.596078 0.835294\n".. 
	"haircolor6 0.400000 0.180392 0.537255\n".. 
	"kind 2\n".. 
	"mane 8\n".. 
	"manel 9\n".. 
	"tail 8\n")
	addPreset("derpy.txt","\n"..
	"kind 2\n"..
	"gender 1\n".. 
	"mane 1\n"..
	"manel 1\n".. 
	"tail 1\n"..
	"eye 3\n".. 
	"eyecolor_iris 0.937255 0.666667 0.196078\n"..  
	"eyecolor_grad 0.901961 0.917647 0.517647\n"..  
	"eyehaslines 2\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"haircolor1 0.97647058963776 0.97254902124405 0.68235296010971\n"..
	"haircolor2 1 1 1\n"..
	"coatcolor 0.76078432798386 0.77647060155869 0.83529412746429\n"..
	"cmark 7\n")
	
	addPreset("bonbon.txt","\n"..
	"kind 1\n"..
	"gender 1\n".. 
	"mane 2\n"..
	"manel 2\n".. 
	"tail 2\n"..
	"eye 5\n"..
	"eyecolor_iris 0.113725 0.270588 0.368627\n"..  
	"eyecolor_grad 0.023529 0.588235 0.596078\n".. 
	"eyecolor_line1 0.435294 0.749020 0.807843\n".. 
	"eyecolor_line2 0.627451 0.819608 0.862745\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"haircolor1 0.9450980424881 0.60000002384186 0.85098040103912\n"..
	"haircolor2 0.31764706969261 0.43529412150383 0.63137257099152\n"..
	"coatcolor 0.8901960849762 0.90196079015732 0.80784314870834\n"..
	"cmark 1\n")
	  
	addPreset("lyra.txt","\n"..
	"kind 3\n"..
	"gender 1\n".. 
	"mane 3\n"..
	"manel 3\n".. 
	"tail 3\n"..
	"eye 10\n"..
	"eyecolor_iris 0.949020 0.525490 0.254902\n"..  
	"eyecolor_grad 0.980392 0.972549 0.647059\n".. 
	"eyecolor_line1 0.988235 0.984314 0.764706\n".. 
	"eyecolor_line2 1.000000 0.996078 0.862745\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"haircolor1 0.68235296010971 0.90980392694473 0.90588235855103\n"..
	"haircolor2 1 1 1\n"..
	"coatcolor 0.57254904508591 1 0.85882353782654\n"..
	"cmark 2\n")

	addPreset("trixie.txt","\n"..
	"kind 3\n"..
	"gender 1\n".. 
	"mane 4\n"..
	"manel 4\n".. 
	"tail 4\n"..
	"eye 6\n"..
	"eyecolor_iris 0.592157 0.403922 0.592157\n"..  
	"eyecolor_grad 0.882353 0.592157 0.831373\n".. 
	"eyecolor_line1 0.890196 0.752941 0.870588\n".. 
	"eyecolor_line2 0.949020 0.900000 0.933333\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"haircolor1 0.86666667461395 0.94901961088181 0.96862745285034\n"..
	"haircolor2 0.7294117808342 1 0.96862745285034\n"..
	"coatcolor 0.47843137383461 0.74509805440903 0.90980392694473\n"..
	"cmark 4\n")
	  
	addPreset("fluttershy.txt","\n"..
	"kind 2\n"..
	"gender 1\n".. 
	"mane 5\n"..
	"manel 5\n".. 
	"tail 5\n"..
	"eye 5\n".. 
	"eyecolor_iris 0.058824 0.341176 0.337255\n"..  
	"eyecolor_grad 0.215686 0.741176 0.721569\n".. 
	"eyecolor_line1 0.243137 0.760784 0.745098\n".. 
	"eyecolor_line2 0.607843 0.854902 0.862745\n".. 
	"eyeholesize 0.7\n".. 
	"eyeirissize 0.7\n".. 
	"eyelash 3\n".. 
	"haircolor1 0.956863 0.713726 0.819608\n"..
	"haircolor2 0.905882 0.505882 0.701961\n"..
	"coatcolor 0.98823529481888 0.96470588445663 0.68235296010971\n"..
	"cmark 3\n" )
end