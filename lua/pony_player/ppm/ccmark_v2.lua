
if CLIENT then
	net.Receive( "ppm_cmark_setup", function(len)  
        local ent = net.ReadEntity()  
        local lc = net.ReadInt(16)

        if lc==0 then
            ent.ponydata_cmark = nil 
        else
            local data = net.ReadData(lc)
            local decompressed = util.Decompress(data)
            
            
            local path = ""
            if ent:IsPlayer() then
                local userid = ent:UniqueID()
                path = "ppm/client_cmarks/"..userid..".png"
                file.CreateDir("ppm/client_cmarks/") 
            else
                local entid = ent:EntIndex()
                path = "ppm/entity_cmarks/"..entid..".png"
                file.CreateDir("ppm/entity_cmarks/")
            end
            file.Write(path, decompressed)


            ent.ponydata_cmark = "data/"..path 
        end
        PPM.RequestUpdate(ent)
    end) 

    function PPM.CmarkSend(image_path) 
		if file.Exists(image_path, "GAME") then
			local data = file.Read(image_path, "GAME")
			local cdata = util.Compress(data)
			local len = #cdata
			net.Start("ppm_cmark_upload")
			net.WriteInt(len,16)
			net.WriteData(cdata,len)
			net.SendToServer() 
			MsgN("sent ",len)
		end 
    end
    function PPM.CmarkClear()  
        net.Start("ppm_cmark_upload")
        net.WriteInt(0,16) 
        net.SendToServer()  
    end
end
 
if SERVER then
	local ppm_cmark_allow_custom = CreateConVar("ppm_cmark_allow_custom", "1", 0, "Allow custom cutie mark upload")
    local ppm_cmark_maxfilesize = CreateConVar("ppm_cmark_maxfilesize", "32000", 0, "Maximum file size of uploaded cutie mark in bytes (hard limit is 64kb)")

	util.AddNetworkString("ppm_cmark_upload")
	util.AddNetworkString("ppm_cmark_setup")
	
    net.Receive( "ppm_cmark_upload", function(len, ply)  
        if ppm_cmark_allow_custom:GetInt()==1 then
            MsgN("cmark data incoming ",len/8)  
            local maxsize = ppm_cmark_maxfilesize:GetFloat()
            if len/8 <= maxsize then
                local data = ""
                local lc = net.ReadInt(16)

                if lc<=0 then
                    local userid = ply:UniqueID()
                    local path = "ppm/cmarks/"..userid..".png"
                    file.Delete(path)
                    ply.ponydata_cmark = nil 
                else
                    MsgN("lc ",lc)
                    data = net.ReadData(lc)
                    MsgN("data ",#data)
                    local decompressed = util.Decompress(data)
                    MsgN("decompressed data ",#decompressed)
                    local userid = ply:UniqueID()
                    local path = "ppm/cmarks/"..userid..".png"
                    file.Write(path, decompressed)
                    ply.ponydata_cmark = path 
                end

                
                net.Start("ppm_cmark_setup")
                net.WriteEntity(ply)
                net.WriteInt(lc,16)
                if lc>0 then
                    net.WriteData(data,lc)
                end
                net.Broadcast() 
                MsgN("s sent to all ",lc)

            else
                Msg("received cmark from ",ply, " which is exceeding maximum file size limit! ",len/8," of ",maxsize," bytes")
            end
        end
    end) 
    function PPM.SetPonyCmark(ent,image_path)
        if image_path then 
            if file.Exists(image_path, "DATA") then
                ent.ponydata_cmark = image_path 

                local data = file.Read(image_path, "DATA")
                local cdata = util.Compress(data)
                local len = #cdata
                net.Start("ppm_cmark_setup")
                net.WriteEntity(ent)
                net.WriteInt(len,16)
                net.WriteData(cdata,len)
                net.Broadcast() 
                MsgN("s sent to all ",len)
            end
        else
            net.Start("ppm_cmark_setup")
            net.WriteEntity(ent)
            net.WriteInt(0,16) 
            net.Broadcast() 
        end
    end 
    function PPM.EntCmarkSendTo(ent,to) 
        local image_path = ent.ponydata_cmark 
		if image_path and file.Exists(image_path, "DATA") then
			local data = file.Read(image_path, "DATA")
			local cdata = util.Compress(data)
			local len = #cdata
			net.Start("ppm_cmark_upload")
			net.WriteInt(len,16)
            net.WriteData(cdata,len)
            if to=="all" then
                net.Broadcast()
            else
                net.Send(to) 
            end
			MsgN("sent ",len)
		end 
    end
end