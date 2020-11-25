
function PPM.loadResources()
	if CLIENT then
		PPM.m_body = Material( "models/mlp/base/body" ) 
		PPM.m_bodyf = Material( "models/mlp/base/bodyf" ) 
		PPM.m_bodym = Material( "models/mlp/base/bodym" ) 
		
		PPM.m_wings = Material( "models/mlp/base/wings" ) 
		PPM.m_horn = Material( "models/mlp/base/horn" ) 
		PPM.m_cmark = Material( "models/mlp/base/cmark" ) 
		PPM.m_hair1 = Material( "models/mlp/base/hair_color_1" ) 
		PPM.m_hair2 = Material( "models/mlp/base/hair_color_2" ) 
		PPM.m_tail1 = Material( "models/mlp/base/tail_color_1" ) 
		PPM.m_tail2 = Material( "models/mlp/base/tail_color_2" ) 

		PPM.m_eyel = Material( "models/mlp/base/eye_l" ) 
		PPM.m_eyer = Material( "models/mlp/base/eye_r" )

		PPM.t_eyes = {
			{Material( "models/mlp/base/face/tc00"),"Gray"
			,"models/mlp/base/face/tc00" },
			{Material( "models/mlp/base/face/tc01"),"Turquoise"
			,"models/mlp/base/face/tc01" },
			{Material( "models/mlp/base/face/tc02"),"Yellow"
			,"models/mlp/base/face/tc02" },
			{Material( "models/mlp/base/face/tc03"),"Red"
			,"models/mlp/base/face/tc03" },
			{Material( "models/mlp/base/face/tc04"),"Blue"
			,"models/mlp/base/face/tc04" },
			{Material( "models/mlp/base/face/tc05"),"Purple"
			,"models/mlp/base/face/tc05" },
			{Material( "models/mlp/base/face/tc06"),"Slate Blue"
			,"models/mlp/base/face/tc06" },
			{Material( "models/mlp/base/face/tc07"),"Green"
			,"models/mlp/base/face/tc07" },
			{Material( "models/mlp/base/face/tc08"),"Gold"
			,"models/mlp/base/face/tc08" },
			{Material( "models/mlp/base/face/tc09"),"Orange"
			,"models/mlp/base/face/tc09" }
		}  

		PPM.t_cmarks = { 
			Material("models/mlp/cmarks/bon_bon.vtf"),
			Material("models/mlp/cmarks/lyra.vtf"),
			Material("models/mlp/cmarks/fluttershy.vtf"),
			Material("models/mlp/cmarks/trixie.vtf"),
			Material("models/mlp/cmarks/celestia.vtf"),
			Material("models/mlp/cmarks/applej.vtf"),
			Material("models/mlp/cmarks/derpy.vtf"),
			Material("models/mlp/cmarks/waters.vtf"),
			Material("models/mlp/cmarks/cloudy.vtf"),
			Material("models/mlp/cmarks/time.vtf"),
			Material("models/mlp/cmarks/sflowers.vtf"),
			Material("models/mlp/cmarks/twilight.vtf"),
			Material("models/mlp/cmarks/rosen.vtf"),
			Material("models/mlp/cmarks/zecora.vtf"),
			Material("models/mlp/cmarks/mine.vtf"),
			Material("models/mlp/cmarks/island.vtf"),
			Material("models/mlp/cmarks/firezap.vtf"),
			Material("models/mlp/cmarks/applem.vtf"),
			Material("models/mlp/cmarks/pankk.vtf"),
			Material("models/mlp/cmarks/storm.vtf"),
			Material("models/mlp/cmarks/weer.vtf"),
			Material("models/mlp/cmarks/rainbow_dash.vtf"),
			Material("models/mlp/cmarks/time2.vtf"),
			Material("models/mlp/cmarks/carrots.vtf"),
			Material("models/mlp/cmarks/fruits.vtf"),
			Material("models/mlp/cmarks/note.vtf"),
			Material("models/mlp/cmarks/pinkie_pie.vtf"),
			Material("models/mlp/cmarks/rarity.vtf"),
			Material("models/mlp/cmarks/octavia.vtf"),
			Material("models/mlp/cmarks/custom01.vtf") ,
			Material("models/mlp/cmarks/custom02.vtf")  
		}
				 
		PPM.m_cmarks = { 
			{Material("models/mlp/cmarks/bon_bon.vtf"),"bon_bon"},
			{Material("models/mlp/cmarks/lyra.vtf"),"lyra"},
			{Material("models/mlp/cmarks/fluttershy.vtf"),"fluttershy"},
			{Material("models/mlp/cmarks/trixie.vtf"),"trixie"},
			{Material("models/mlp/cmarks/celestia.vtf"),"celestia"},
			{Material("models/mlp/cmarks/applej.vtf"),"applej"},
			{Material("models/mlp/cmarks/derpy.vtf"),"derpy"},
			{Material("models/mlp/cmarks/waters.vtf"),"waters"},
			{Material("models/mlp/cmarks/cloudy.vtf"),"cloudy"},
			{Material("models/mlp/cmarks/time.vtf"),"time"},
			{Material("models/mlp/cmarks/sflowers.vtf"),"sflowers"},
			{Material("models/mlp/cmarks/twilight.vtf"),"twilight"},
			{Material("models/mlp/cmarks/rosen.vtf"),"rosen"},
			{Material("models/mlp/cmarks/zecora.vtf"),"zecora"},
			{Material("models/mlp/cmarks/mine.vtf"),"mine"},
			{Material("models/mlp/cmarks/island.vtf"),"island"},
			{Material("models/mlp/cmarks/firezap.vtf"),"firezap"},
			{Material("models/mlp/cmarks/applem.vtf"),"applem"},
			{Material("models/mlp/cmarks/pankk.vtf"),"pankk"},
			{Material("models/mlp/cmarks/storm.vtf"),"storm"},
			{Material("models/mlp/cmarks/weer.vtf"),"weer"},
			{Material("models/mlp/cmarks/rainbow_dash.vtf"),"rainbow_dash"},
			{Material("models/mlp/cmarks/time2.vtf"),"time2"},
			{Material("models/mlp/cmarks/carrots.vtf"),"carrots"},
			{Material("models/mlp/cmarks/fruits.vtf"),"fruits"},
			{Material("models/mlp/cmarks/note.vtf"),"note"},
			{Material("models/mlp/cmarks/pinkie_pie.vtf"),"pinkie_pie"},
			{Material("models/mlp/cmarks/rarity.vtf"),"rarity"} ,
			{Material("models/mlp/cmarks/octavia.vtf"),"octavia"}  ,
			{Material("models/mlp/cmarks/custom01.vtf"),"custom01"} ,
			{Material("models/mlp/cmarks/custom02.vtf"),"custom02"} 
		}
		PPM.m_bodyt0 = {
			Material("models/mlp/texclothes/clothes_wbs_light.png"),
			Material("models/mlp/texclothes/clothes_wbs_full.png"),
			Material("models/mlp/texclothes/clothes_sbs_full.png"),
			Material("models/mlp/texclothes/clothes_sbs_light.png"),
			Material("models/mlp/texclothes/clothes_royalguard.png"),
		}
		PPM.m_bodydetails = {
			{Material("models/mlp/partrender/body_leggrad1.png"),"Leg grad"}, 
			{Material("models/mlp/partrender/body_lines1.png"),"Lines"}, 
			{Material("models/mlp/partrender/body_stripes1.png"),"Stripes"}, 
			{Material("models/mlp/partrender/body_headstripes1.png"),"Head stripes"}, 
			{Material("models/mlp/partrender/body_freckles.png"),"Freckles"}, 
			{Material("models/mlp/partrender/body_hooves1.png"),"Hooves big"}, 
			{Material("models/mlp/partrender/body_hooves2.png"),"Hooves small"}, 
			{Material("models/mlp/partrender/body_headmask1.png"),"Head layer"}, 
			{Material("models/mlp/partrender/body_hooves1_crit.png"),"Hooves big rnd"}, 
			{Material("models/mlp/partrender/body_hooves2_crit.png"),"Hooves small rnd"}, 
			{Material("models/mlp/partrender/body_spots1.png"),"Spots 1"}, 
			
		} 
	end
end