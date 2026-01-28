extends Node2D


func _on_upgrade_station_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/upgrades.tscn")

func _on_exit_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/test_map.tscn")


func _on_camp_pressed() -> void:
	Global.parley_jee += Global.score
	Global.score = 0
