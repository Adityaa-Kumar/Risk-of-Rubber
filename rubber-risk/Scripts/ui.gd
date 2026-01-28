extends CanvasLayer

func _process(delta: float) -> void:
	$lable_snap/Label_health.text = "Health: "+str(Global.player_health)
	$lable_snap/Label_ammo.text = "Ammo: "+str(Global.player_resource_global.Ammo)
	$lable_snap/Label_metal.text = "Metal: "+str(Global.player_resource_global.Metal)
	$lable_snap/Label_Parley_JEE.text = "Parley-JEE: "+str(Global.player_resource_global.Parley_JEE)
	$lable_snap/Label_speed.text = "Speed: " + str(Global.player_speed)
