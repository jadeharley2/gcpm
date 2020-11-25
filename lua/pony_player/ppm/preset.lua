
PPM.bannedVars = {"m_bodyt0"}

function PPM.Save(filename, ponydata) 
	local outfilename = filename
	local saveframe = ""
	/*
	saveframe = saveframe .. "\n kind " .. ponydata.kind
	saveframe = saveframe .. "\n gender " .. ponydata.gender
	saveframe = saveframe .. "\n mane " .. ponydata.mane
	saveframe = saveframe .. "\n tail " .. ponydata.tail
	saveframe = saveframe .. "\n eye " .. ponydata.eye
	saveframe = saveframe .. "\n haircolor1 " .. ponydata.haircolor1.x .." ".. ponydata.haircolor1.y.." ".. ponydata.haircolor1.z
	saveframe = saveframe .. "\n haircolor2 " .. ponydata.haircolor2.x .." ".. ponydata.haircolor2.y.." ".. ponydata.haircolor2.z
	saveframe = saveframe .. "\n coatcolor " .. ponydata.coatcolor.x .." ".. ponydata.coatcolor.y.." ".. ponydata.coatcolor.z
	 
	saveframe = saveframe .. "\n cmark " .. ponydata.cmark
	*/

	for k,v in SortedPairs(ponydata) do
		if !table.HasValue(PPM.bannedVars,k) then
			if type(v)=="number" then
				saveframe = saveframe .. "\n "..k.." " .. tostring(v)
			elseif type(v)=="Vector" then
				saveframe = saveframe .. "\n "..k.." " .. tostring(v)
			elseif type(v)=="boolean" then
				saveframe = saveframe .. "\n "..k.." b " .. tostring(v)
			end
		end
	end
	
	if !string.EndsWith(outfilename,".txt") then
		outfilename = outfilename .. ".txt"
	end
	if !file.Exists( "ppm", "DATA" ) then
		file.CreateDir( "ppm" )
	end
	MsgN("saving .... ".."ppm/"..outfilename)
	file.Write("ppm/"..outfilename,saveframe)
end
function PPM.Load(filename)
	local lines = file.Read("data/ppm/"..filename,"GAME")
	local litable = string.Split(lines,"\n")
	local ponydata = {}
	for k,v in pairs(litable) do
		local args = string.Split(string.Trim(v)," ") 
		local name = string.Replace(args[1],"pny_","") 
		if !table.HasValue(PPM.bannedVars,name) then
			if(table.Count(args)==2) then
				ponydata[name] =tonumber( args[2])
			elseif(table.Count(args)==4) then
				ponydata[name] =Vector(tonumber( args[2]),tonumber( args[3]),tonumber( args[4])) 
			elseif(table.Count(args)==3) then
				ponydata[name] = tobool( args[3])
				//print("FAFAFF ", args[3])
			end
		end
	end
	return ponydata
end 