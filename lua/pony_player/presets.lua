if(CLIENT) then

	function addPreset(name,code)
		//if(!file.Exists("ppm/"..name, "DATA")) then
			Save(name,code)
		//end
	end
	function Save(filename,code) 
		if !file.Exists( "ppm", "DATA" ) then
			file.CreateDir( "ppm" )
		end
		//MsgN("creating preset .. ppm/"..filename)
		file.Write("ppm/"..filename,code) 
	end
	
	addPreset("derpy.txt","\n"..
	"pny_kind 2\n"..
	"pny_mane 1\n"..
	"pny_tail 1\n"..
	"pny_eye 3\n"..
	"pny_haircolor1 0.97647058963776 0.97254902124405 0.68235296010971\n"..
	"pny_haircolor2 1 1 1\n"..
	"pny_coatcolor 0.76078432798386 0.77647060155869 0.83529412746429\n"..
	"pny_cmark 7\n")
	
	addPreset("bonbon.txt","\n"..
	"pny_kind 1\n"..
	"pny_mane 2\n"..
	"pny_tail 2\n"..
	"pny_eye 5\n"..
	"pny_haircolor1 0.9450980424881 0.60000002384186 0.85098040103912\n"..
	"pny_haircolor2 0.31764706969261 0.43529412150383 0.63137257099152\n"..
	"pny_coatcolor 0.8901960849762 0.90196079015732 0.80784314870834\n"..
	"pny_cmark 1\n")
	  
	addPreset("lyra.txt","\n"..
	"pny_kind 3\n"..
	"pny_mane 3\n"..
	"pny_tail 3\n"..
	"pny_eye 10\n"..
	"pny_haircolor1 0.68235296010971 0.90980392694473 0.90588235855103\n"..
	"pny_haircolor2 1 1 1\n"..
	"pny_coatcolor 0.57254904508591 1 0.85882353782654\n"..
	"pny_cmark 2\n")

	addPreset("trixie.txt","\n"..
	"pny_kind 3\n"..
	"pny_mane 4\n"..
	"pny_tail 4\n"..
	"pny_eye 6\n"..
	"pny_haircolor1 0.86666667461395 0.94901961088181 0.96862745285034\n"..
	"pny_haircolor2 0.7294117808342 1 0.96862745285034\n"..
	"pny_coatcolor 0.47843137383461 0.74509805440903 0.90980392694473\n"..
	"pny_cmark 4\n")
	  
	addPreset("fluttershy.txt","\n"..
	"pny_kind 2\n"..
	"pny_mane 5\n"..
	"pny_tail 5\n"..
	"pny_eye 5\n".. 
	"pny_haircolor1 0.44313725829124 0.419607847929 0.62745100259781\n"..
	"pny_haircolor2 0.46666666865349 0.22745098173618 0.22745098173618\n"..
	"pny_coatcolor 0.98823529481888 0.96470588445663 0.68235296010971\n"..
	"pny_cmark 3\n" )
end