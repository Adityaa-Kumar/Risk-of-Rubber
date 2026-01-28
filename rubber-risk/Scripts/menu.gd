extends Node3D
@onready var pickup_armour: Node3D = $car_selector/pickup_armour
@onready var sedan_armour: Node3D = $car_selector/sedan_armour
@onready var truck_armour: Node3D = $car_selector/truck_armour

func _on_button_pressed() -> void:
	if pickup_armour.visible == true:
		Global.selected_car = Global.vehicle.PICKUP
	elif sedan_armour.visible == true:
		Global.selected_car = Global.vehicle.SEDAN
	elif truck_armour.visible == true:
		Global.selected_car = Global.vehicle.TRUCK
	get_tree().change_scene_to_file("res://Map/test_map.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit(0)

func _on_button_3_pressed() -> void:
	if pickup_armour.visible == true:
		sedan_armour.visible = true
		pickup_armour.visible = false
		truck_armour.visible = false
	elif sedan_armour.visible == true:
		pickup_armour.visible = false
		sedan_armour.visible = false
		truck_armour.visible = true
	elif truck_armour.visible == true:
		pickup_armour.visible = true
		sedan_armour.visible = false
		truck_armour.visible = false
	
