extends Node2D

@onready var label_parley_jee: Label = $CanvasLayer/Control/Label_Parley_JEE
@onready var label_score: Label = $CanvasLayer/Control/Label_Score

func _on_upgrade_station_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/upgrades.tscn")

func _on_exit_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/small_map.tscn")


func _on_camp_pressed() -> void:
	Global.parley_jee += Global.score
	Global.score = 0

func _on_exit2_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/small_map.tscn")
	
func _process(delta: float) -> void:
	label_parley_jee.text = "Parley-JEE: "+str(Global.parley_jee)
	label_score.text = "Score: "+str(Global.score)
