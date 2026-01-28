extends Node3D
@onready var pickup_armour: Node3D = $car_selector/pickup_armour
@onready var sedan_armour: Node3D = $car_selector/sedan_armour
@onready var truck_armour: Node3D = $car_selector/truck_armour
@onready var label_metal: Label = $Camera3D/CanvasLayer/Metal/Label_metal

func _ready() -> void:
	Global.load_game()
	if Global.selected_car == Global.vehicle.PICKUP:
		sedan_armour.visible = false
		pickup_armour.visible = true
		truck_armour.visible = false
	elif Global.selected_car == Global.vehicle.SEDAN:
		sedan_armour.visible = true
		pickup_armour.visible = false
		truck_armour.visible = false
	elif Global.selected_car == Global.vehicle.TRUCK:
		sedan_armour.visible = false
		pickup_armour.visible = false
		truck_armour.visible = true

func _on_button_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/home_base.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit(0)

func _on_button_3_pressed() -> void:
	if pickup_armour.visible == true:
		sedan_armour.visible = true
		pickup_armour.visible = false
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.SEDAN
	elif sedan_armour.visible == true:
		pickup_armour.visible = false
		sedan_armour.visible = false
		truck_armour.visible = true
		Global.selected_car = Global.vehicle.TRUCK
	elif truck_armour.visible == true:
		pickup_armour.visible = true
		sedan_armour.visible = false
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.PICKUP

func _on_button_4_pressed() -> void:
	if pickup_armour.visible == true:
		sedan_armour.visible = false
		pickup_armour.visible = false
		truck_armour.visible = true
		Global.selected_car = Global.vehicle.TRUCK
	elif sedan_armour.visible == true:
		pickup_armour.visible = true
		sedan_armour.visible = false
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.PICKUP
	elif truck_armour.visible == true:
		pickup_armour.visible = false
		sedan_armour.visible = true
		truck_armour.visible = false
		Global.selected_car = Global.vehicle.SEDAN


func _on_button_test_2_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/test_map_2.tscn")


func _on_button_smol_pressed() -> void:
	Global.save_game()
	SceneLoader.load_scene("res://Map/small_map.tscn")
